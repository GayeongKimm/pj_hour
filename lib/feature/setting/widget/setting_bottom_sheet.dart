import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/item/category_item.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../component/modal_bottom_sheet_container.dart';
import '../../../component/textfield.dart';

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
  final TextEditingController _titleTextFieldController = TextEditingController();
  final TextEditingController _priceTextFieldController = TextEditingController();
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  bool isExpenseSelected = true;

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
      initialChildSize: 0.45,
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
                  title: data.title,
                  amount: data.amount,
                  date: data.date,
                  onTrashClick: () => viewModel.removeEntity(data.id ?? 0),
                  onClickCreate: () => Navigator.pop(context),
                )),
                const SizedBox(height: 16),
                HourTextField(
                  labelText: "카테고리 이름",
                  hintText: "카테고리 이름을 입력해주세요.",
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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _titleTextFieldController.clear();
                    _priceTextFieldController.clear();
                  },
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
                ),
                const SizedBox(height: 20),
                viewModel.isLoading ? const Center(
                  child: CircularProgressIndicator(
                    color: HourColors.orange500,
                  ),
                ) : ElevatedButton(
                  onPressed: () async {
                    final title = _titleTextFieldController.text.trim();
                    final rawAmount = _priceTextFieldController.text.replaceAll(',', '');
                    final amount = int.tryParse(rawAmount) ?? 0;

                    if (title.isEmpty || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("카테고리 이름과 금액을 올바르게 입력해주세요.")
                        ),
                      );
                      return;
                    }
                    try {
                      widget.viewModel.setIsLoading(true);
                      await widget.viewModel.addCategory(
                        title: title,
                        amount: amount,
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
