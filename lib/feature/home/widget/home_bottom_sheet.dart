import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hour/component/textfield.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:hour/feature/history/viewmodel/history_create_viewmodel.dart';
import 'package:hour/feature/history/viewmodel/history_viewmodel.dart';
import 'package:hour/feature/home/item/home_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../component/modal_bottom_sheet_container.dart';
import '../../../local/entity/category_entity.dart';
import '../../history/item/history_item.dart';

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
  final TextEditingController _titleTextFieldController = TextEditingController();
  final TextEditingController _priceTextFieldController = TextEditingController();
  HistoryType _isExpenseSelected = HistoryType.CONSUMPTION;
  final NumberFormat _formatter = NumberFormat.decimalPattern();

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
          _isExpenseSelected = (label == "소비") ? HistoryType.CONSUMPTION : HistoryType.INCOME;
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


  CategoryEntity? selectedCategory;

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _priceTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryViewmodel>().categoryEntities;
    final viewModel = Provider.of<HistoryViewmodel>(context);

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
                const SizedBox(height: 12),
                Text(
                  "소비 기록하기",
                  style: HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                ),
                const SizedBox(height: 12),
                ...viewModel.historyEntities.map((data) => HistoryItem(
                  title: data.title,
                  type: data.type,
                  categoryId: data.categoryId,
                  price: data.price,
                  date: data.date,
                  onTrashClick: () => viewModel.removeEntity(data.id ?? 0),
                  onClickCreate: () => Navigator.pop(context),
                )),
                const SizedBox(height: 12),
                HourTextField(
                  labelText: "소비 이름",
                  hintText: "소비 이름을 입력해주세요.",
                  controller: _titleTextFieldController,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _priceTextFieldController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    prefixText: '₩ ',
                    prefixStyle: HourStyles.label1.copyWith(
                        color: HourColors.staticWhite
                    ),
                    hintText: '금액을 입력해주세요',
                    hintStyle: HourStyles.label1.copyWith(
                        color: HourColors.gray500
                    ),
                    border: InputBorder.none,
                  ),
                  style: HourStyles.body2.copyWith(
                      color: HourColors.staticWhite
                  ),
                  onChanged: (value) {
                    String rawValue = value.replaceAll(',', '');
                    if (rawValue.isEmpty) return;
                    final int? intValue = int.tryParse(rawValue);
                    if (intValue == null) return;
                    String formatted = _formatter.format(intValue);
                    if (formatted != value) {
                      _priceTextFieldController.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(
                            offset: formatted.length
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  width: 180,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: HourColors.staticBlack,
                  ),
                  child: DropdownButton<CategoryEntity>(
                      value: selectedCategory,
                      hint: Text(
                        "카테고리를 선택해 주세요.",
                        style: HourStyles.label1.copyWith(
                            color: HourColors.staticWhite
                        ),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem<CategoryEntity>(
                          value: category,
                          child: Text(
                            category.title,
                            style: HourStyles.label1.copyWith(
                                color: HourColors.staticWhite
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (CategoryEntity? value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      dropdownColor: HourColors.staticBlack,
                      icon: Image.asset(
                        "assets/images/ic_down.png",
                        width: 15,
                        height: 15,
                        color: HourColors.staticWhite,
                      ),
                      underline: SizedBox(),
                      isExpanded: true,
                      style: HourStyles.label1.copyWith(
                          color: HourColors.staticWhite
                      )
                  ),
                ),
                Row(
                  children: [
                    _buildToggleButton(
                      label: "소비",
                      isSelected: _isExpenseSelected,
                      selectedColor: HourColors.orange500,
                    ),
                    const SizedBox(width: 8),
                    _buildToggleButton(
                      label: "소득",
                      isSelected: _isExpenseSelected,
                      selectedColor: HourColors.primary400,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/ic_plus.png",
                      width: 20,
                      height: 20,
                      color: HourColors.staticWhite,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "새로운 소비 기록하기",
                      style: HourStyles.label1.copyWith(
                          color: HourColors.staticWhite
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                viewModel.isLoading ? const Center(
                  child: CircularProgressIndicator(
                    color: HourColors.orange500,
                  ),
                ) : ElevatedButton(
                  onPressed: () async {
                    final title = _titleTextFieldController.text.trim();
                    final type = _isExpenseSelected;
                    final categoryId = selectedCategory?.id;
                    final price = int.tryParse(_priceTextFieldController.text.trim()) ?? 0;

                    if (title.isEmpty || price <= 0 || categoryId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("카테고리, 이름, 금액을 올바르게 입력해주세요.")
                        ),
                      );
                      return;
                    }
                    try {
                      widget.viewModel.setIsLoading(true);
                      await widget.viewModel.addCategory(
                        title: title,
                        type: type,
                        categoryId: categoryId,
                        price: price,
                        date: DateTime.now(),
                      );
                      _titleTextFieldController.clear();
                      _priceTextFieldController.clear();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                      Future.delayed(
                          const Duration(milliseconds: 300), () {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("저장되었습니다")
                            ),
                          );
                        }
                      }
                      );
                    } catch (e) {
                      print('$e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("저장 중 오류 발생: $e")
                        ),
                      );
                    } finally {
                      widget.viewModel.setIsLoading(false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HourColors.orange500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "저장하기",
                    style: HourStyles.label1.copyWith(
                        color: HourColors.staticWhite
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}