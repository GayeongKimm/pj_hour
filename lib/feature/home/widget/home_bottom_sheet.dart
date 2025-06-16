import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hour/component/textfield.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:hour/feature/history/viewmodel/history_viewmodel.dart';
import 'package:hour/feature/home/item/home_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../component/modal_bottom_sheet_container.dart';
import '../../../core/util/flushbar.dart';
import '../../../local/entity/category_entity.dart';

class HomeBottomSheet extends StatefulWidget {
  final BuildContext context;
  final HistoryViewmodel viewModel;

  const HomeBottomSheet({
    super.key,
    required this.context,
    required this.viewModel,
  });

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  final NumberFormat _formatter = NumberFormat.decimalPattern();
  final List<TextEditingController> _titleControllers = [];
  final List<TextEditingController> _priceControllers = [];

  bool isCreatingMultiple = false;
  HistoryType _selectedType = HistoryType.CONSUMPTION;
  int? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  CategoryEntity? selectedCategory;

  @override
  void initState() {
    super.initState();
    final selected = widget.viewModel.selectedHistory;
    if (widget.viewModel.isEditing && selected != null) {
      _titleControllers.add(TextEditingController(text: selected.title));
      _priceControllers.add(TextEditingController(text: selected.price.toString()));
      _selectedType = selected.type;
      _selectedCategoryId = selected.categoryId;
      _selectedDate = selected.date;
    } else {
      _titleControllers.add(TextEditingController());
      _priceControllers.add(TextEditingController());
      isCreatingMultiple = true;
    }
  }

  void _addNewHistoryField() {
    setState(() {
      _titleControllers.add(TextEditingController());
      _priceControllers.add(TextEditingController());
      isCreatingMultiple = true;
    });
  }

  Future<void> _handleEditHistory() async {
    final title = _titleControllers[0].text.trim();
    final price = int.tryParse(_priceControllers[0].text.replaceAll(',', '')) ?? 0;

    if (title.isEmpty || price <= 0 || _selectedCategoryId == null) {
      FlushbarUtil.show(context, "소비 이름, 금액, 카테고리를 올바르게 입력해주세요.");
      return;
    }

    try {
      widget.viewModel.setIsLoading(true);
      await widget.viewModel.updateCategory(
        id: widget.viewModel.selectedHistory!.id!,
        title: title,
        price: price,
        date: _selectedDate,
        type: _selectedType,
        categoryId: _selectedCategoryId!,
      );
      if (context.mounted) {
        Navigator.of(context).pop();
        FlushbarUtil.show(context, "소비가 수정되었습니다.", color: HourColors.green);
      }
    } catch (e) {
      FlushbarUtil.show(context, "수정 중 오류 발생: $e");
    } finally {
      widget.viewModel.setIsLoading(false);
    }
  }

  Future<void> _handleCreateHistories() async {
    bool hasSaved = false;

    for (int i = 0; i < _titleControllers.length; i++) {
      final title = _titleControllers[i].text.trim();
      final price = int.tryParse(_priceControllers[i].text.replaceAll(',', '')) ?? 0;

      if (title.isEmpty || price <= 0 || _selectedCategoryId == null) continue;

      await widget.viewModel.addCategory(
        title: title,
        type: _selectedType,
        categoryId: _selectedCategoryId!,
        price: price,
        date: _selectedDate,
      );
      hasSaved = true;
    }

    if (hasSaved) {
      if (context.mounted) {
        Navigator.of(context).pop();
        FlushbarUtil.show(context, "소비가 저장되었습니다.", color: HourColors.green);
      }
    } else {
      FlushbarUtil.show(context, "소비 이름과 금액을 입력해주세요.");
    }
  }

  Widget _buildHistoryFields() {
    return Column(
      children: List.generate(_titleControllers.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HourTextField(
              labelText: "소비 이름",
              hintText: "소비 이름을 입력해주세요.",
              controller: _titleControllers[index],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceControllers[index],
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixText: '₩ ',
                prefixStyle: HourStyles.label1.copyWith(color: HourColors.staticWhite),
                hintText: '금액을 입력해주세요',
                hintStyle: HourStyles.label1.copyWith(color: HourColors.gray500),
                border: InputBorder.none,
              ),
              style: HourStyles.body2.copyWith(color: HourColors.staticWhite),
              onChanged: (value) {
                final rawValue = value.replaceAll(',', '');
                final int? intValue = int.tryParse(rawValue);
                if (intValue == null) return;
                final formatted = _formatter.format(intValue);
                if (formatted != value) {
                  _priceControllers[index].value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: formatted.length),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _addNewHistoryField,
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_plus.png",
            width: 20,
            height: 20,
            color: HourColors.staticWhite,
          ),
          const SizedBox(width: 8),
          Text(
            "새로운 소비 추가하기",
            style: HourStyles.label1.copyWith(color: HourColors.staticWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return widget.viewModel.isLoading
        ? const Center(child: CircularProgressIndicator(color: HourColors.orange500))
        : ElevatedButton(
      onPressed: () {
        if (widget.viewModel.isEditing) {
          _handleEditHistory();
        } else {
          _handleCreateHistories();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: HourColors.primary300,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text("저장하기", style: HourStyles.label1.copyWith(color: HourColors.staticWhite)),
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      children: [
        _buildToggleButton(
          label: "소비",
          isSelected: _selectedType,
          selectedColor: HourColors.orange500,
        ),
        const SizedBox(width: 8),
        _buildToggleButton(
          label: "소득",
          isSelected: _selectedType,
          selectedColor: HourColors.primary400,
        ),
      ],
    );
  }

  Widget _buildToggleButton({
    required String label,
    required HistoryType isSelected,
    required Color selectedColor,
  }) {
    final isActive = (label == "소비" && isSelected == HistoryType.CONSUMPTION) ||
        (label == "소득" && isSelected == HistoryType.INCOME);

    final Color backgroundColor = isActive ? selectedColor : HourColors.gray500;
    final Color borderColor = isActive ? selectedColor : HourColors.gray500;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = (label == "소비") ? HistoryType.CONSUMPTION : HistoryType.INCOME;
        });
      },
      child: Container(
        width: 176,
        height: 43,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: HourStyles.label1.copyWith(
              color: HourColors.staticWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(List<CategoryEntity> categories) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 180,
        height: 60,
        decoration: const BoxDecoration(
          color: HourColors.staticBlack,
        ),
        child: DropdownButton<CategoryEntity>(
          value: selectedCategory,
          hint: Text(
            "카테고리를 선택해 주세요.",
            style: HourStyles.label1.copyWith(color: HourColors.staticWhite),
          ),
          items: categories.map((category) {
            return DropdownMenuItem<CategoryEntity>(
              value: category,
              child: Text(
                category.title,
                style: HourStyles.label1.copyWith(color: HourColors.staticWhite),
              ),
            );
          }).toList(),
          onChanged: (CategoryEntity? value) {
            setState(() {
              selectedCategory = value;
              _selectedCategoryId = value?.id;
            });
          },
          dropdownColor: HourColors.staticBlack,
          icon: Image.asset(
            "assets/images/ic_down.png",
            width: 15,
            height: 15,
            color: HourColors.staticWhite,
          ),
          underline: const SizedBox(),
          isExpanded: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryViewmodel>().categoryEntities;

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return ModalBottomSheetContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(height: 16),
                _buildHistoryFields(),
                if (isCreatingMultiple) _buildAddButton(),
                const SizedBox(height: 16),
                _buildCategoryDropdown(categories),
                const SizedBox(height: 8),
                _buildToggleButtons(),
                const SizedBox(height: 24),
                _buildSaveButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}