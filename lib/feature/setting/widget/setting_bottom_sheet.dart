import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/item/category_item.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../../component/modal_bottom_sheet_container.dart';
import '../../../component/textfield.dart';
import '../../../core/util/flushbar.dart';

class SettingBottomSheet extends StatefulWidget {
  final BuildContext context;
  final CategoryViewmodel viewModel;

  const SettingBottomSheet({
    super.key,
    required this.context,
    required this.viewModel,
  });

  @override
  State<SettingBottomSheet> createState() => _SettingBottomSheetState();
}

class _SettingBottomSheetState extends State<SettingBottomSheet> {
  final NumberFormat _formatter = NumberFormat.decimalPattern();
  final List<TextEditingController> _titleControllers = [];
  final List<TextEditingController> _amountControllers = [];
  final List<String> _selectedIcons = [];

  bool isCreatingMultiple = false;

  final List<String> availableIcons = [
    'assets/images/ic_food.png',
    'assets/images/ic_book.png',
    'assets/images/ic_bus.png',
    'assets/images/ic_game.png',
    'assets/images/ic_gift.png',
    'assets/images/ic_shopping.png',
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewmodel>(context);

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
                Text("카테고리 생성하기", style: HourStyles.title1.copyWith(color: HourColors.staticWhite)),
                const SizedBox(height: 12),
                if (!isCreatingMultiple && !widget.viewModel.isEditing)
                  buildExistingCategoryList(viewModel),
                buildCategoryFields(),
                const SizedBox(height: 12),
                buildAddButton(),
                const SizedBox(height: 24),
                buildSaveButton(viewModel),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final selected = widget.viewModel.selectedCategory;
    if (widget.viewModel.isEditing && selected != null) {
      _titleControllers.add(TextEditingController(text: selected.title));
      _amountControllers.add(TextEditingController(text: selected.amount.toString()));
      _selectedIcons.add(selected.icon ?? availableIcons.first);
    } else {
      setState(() {
        _titleControllers.add(TextEditingController());
        _amountControllers.add(TextEditingController());
        _selectedIcons.add(availableIcons.first);
        isCreatingMultiple = true;
      });
    }
  }

  void _addNewCategoryField() {
    setState(() {
      _titleControllers.add(TextEditingController());
      _amountControllers.add(TextEditingController());
      _selectedIcons.add(availableIcons.first);
      isCreatingMultiple = true;
    });
  }

  Future<void> _handleEditCategory() async {
    final title = _titleControllers[0].text.trim();
    final icon = _selectedIcons[0];

    if (title.isEmpty) {
      FlushbarUtil.show(context, "카테고리 이름과 금액을 올바르게 입력해주세요.");
      return;
    }

    try {
      widget.viewModel.setIsLoading(true);
      await widget.viewModel.updateCategory(
        id: widget.viewModel.selectedCategory!.id!,
        title: title,
        // amount: amount,
        icon: icon,
      );
      if (context.mounted) {
        Navigator.of(context).pop();
        FlushbarUtil.show(context, "카테고리가 수정되었습니다.", color: HourColors.green);
      }
    } catch (e) {
      FlushbarUtil.show(context, "수정 중 오류 발생: $e");
    } finally {
      widget.viewModel.setIsLoading(false);
    }
  }

  Future<void> _handleCreateCategories() async {
    bool hasSaved = false;

    for (int i = 0; i < _titleControllers.length; i++) {
      final title = _titleControllers[i].text.trim();
      final icon = _selectedIcons[i];

      if (title.isEmpty) continue;

      await widget.viewModel.addCategory(
        title: title,
        icon: icon,
        date: DateTime.now(),
      );
      hasSaved = true;
    }

    if (hasSaved) {
      if (context.mounted) {
        Navigator.of(context).pop();
        FlushbarUtil.show(context, "카테고리가 저장되었습니다.", color: HourColors.green);
      }
    } else {
      FlushbarUtil.show(context, "카테고리 이름과 금액을 입력해주세요.");
    }
  }

  Widget buildCategoryFields() {
    return Column(
      children: List.generate(_titleControllers.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HourTextField(
              labelText: "카테고리 이름",
              hintText: "카테고리 이름을 입력해주세요.",
              controller: _titleControllers[index],
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 12),
            Text(
                "아이콘을 선택해 주세요",
                style: HourStyles.label1.copyWith(
                    color: HourColors.staticWhite
                )
            ),
            DropdownButton<String>(
              dropdownColor: HourColors.gray800,
              value: _selectedIcons[index],
              style: HourStyles.label1.copyWith(
                  color: HourColors.staticWhite
              ),
              items: availableIcons.map((iconPath) {
                return DropdownMenuItem(
                  value: iconPath,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      _selectedIcons[index] == iconPath
                          ? HourColors.primary300
                          : HourColors.staticWhite,
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(iconPath, width: 32, height: 32),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedIcons[index] = value;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  Widget buildExistingCategoryList(CategoryViewmodel viewModel) {
    return Column(
      children: viewModel.categoryEntities.map((data) {
        return CategoryItem(
          title: data.title,
          amount: data.amount,
          icon: data.icon,
          onDelete: () => viewModel.removeEntity(data.id ?? 0),
          onEdit: () {
            viewModel.setEditingCategory(data);
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }

  Widget buildAddButton() {
    return GestureDetector(
      onTap: _addNewCategoryField,
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
            "새로운 카테고리 만들기",
            style: HourStyles.label1.copyWith(
                color: HourColors.staticWhite
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSaveButton(CategoryViewmodel viewModel) {
    return viewModel.isLoading
        ? const Center(
      child: CircularProgressIndicator(color: HourColors.orange500),
    )
        : ElevatedButton(
      onPressed: () {
        if (widget.viewModel.isEditing) {
          _handleEditCategory();
        } else {
          _handleCreateCategories();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: HourColors.primary300,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        "저장하기",
        style: HourStyles.label1.copyWith(
            color: HourColors.staticWhite
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _titleControllers) {
      c.dispose();
    }
    for (final c in _amountControllers) {
      c.dispose();
    }
    super.dispose();
  }
}