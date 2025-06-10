import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/item/category_item.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../component/modal_bottom_sheet_container.dart';
import '../../../component/textfield.dart';

class SettingBottomSheet extends StatefulWidget {
  final BuildContext context;
  final CategoryViewmodel viewModel;

  const SettingBottomSheet({
    super.key,
    required this.context,
    required this.viewModel
  });

  @override
  State<SettingBottomSheet> createState() => _SettingBottomSheetState();
}

class _SettingBottomSheetState extends State<SettingBottomSheet> {
  final TextEditingController _titleTextFieldController = TextEditingController();
  final TextEditingController _priceTextFieldController = TextEditingController();

  bool isExpenseSelected = true;

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required Color selectedColor,
  }) {
    final Color backgroundColor = isSelected ? selectedColor : HourColors
        .gray500;
    final Color borderColor = isSelected ? selectedColor : HourColors.gray500;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpenseSelected = (label == "소비");
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
                color: HourColors.staticWhite
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _priceTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewmodel>(context);
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
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
                  ...viewModel.categoryEntities.map((data) => CategoryItem(
                    id: data.id,
                    month: data.month,
                    amount: data.amount,
                    date: data.date,
                    onTrashClick: () {
                      viewModel.removeEntity(data.id ?? 0);
                    },
                    onClickCreate: () async {
                      Navigator.pop(context);
                    },
                  )),
                  const SizedBox(height: 16),
                  HourTextField(
                    labelText: "카테고리 이름",
                    hintText: "카테고리 이름을 입력해주세요.",
                    controller: _titleTextFieldController,
                  ),
                  const SizedBox(height: 12),
                  HourTextField(
                    labelText: "최대 금액",
                    hintText: "최대 금액을 입력해주세요.",
                    controller: _titleTextFieldController,
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
                        "새로운 카테고리 만들기",
                        style: HourStyles.label1.copyWith(
                            color: HourColors.staticWhite
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
        }
    );
  }
}
