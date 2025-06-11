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
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _amountControllers = [];

  bool isCreatingMultiple = false;

  @override
  void initState() {
    super.initState();

    if (widget.viewModel.isEditing && widget.viewModel.selectedCategory != null) {
      _titleControllers.add(TextEditingController(text: widget.viewModel.selectedCategory!.title));
      _amountControllers.add(TextEditingController(text: widget.viewModel.selectedCategory!.amount.toString()));
    } else {
      _addNewCategoryField(); // 기본 한 줄
    }
  }

  void _addNewCategoryField() {
    setState(() {
      _titleControllers.add(TextEditingController());
      _amountControllers.add(TextEditingController());
      isCreatingMultiple = true;
    });
  }

  void _clearFields() {
    setState(() {
      _titleControllers.clear();
      _amountControllers.clear();
      _addNewCategoryField();
    });
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
                  "카테고리 생성하기",
                  style: HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                ),
                const SizedBox(height: 12),

                if (!isCreatingMultiple && !widget.viewModel.isEditing)
                  ...viewModel.categoryEntities.map((data) => CategoryItem(
                    id: data.id,
                    title: data.title,
                    amount: data.amount,
                    date: data.date,
                    onTrashClick: () => viewModel.removeEntity(data.id ?? 0),
                    onClickCreate: () {
                      viewModel.setEditingCategory(data);
                      Navigator.pop(context);
                    },
                  )),

                // 동적으로 입력칸 생성
                ...List.generate(_titleControllers.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HourTextField(
                        labelText: "카테고리 이름",
                        hintText: "카테고리 이름을 입력해주세요.",
                        controller: _titleControllers[index],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _amountControllers[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          prefixText: '₩ ',
                          prefixStyle: HourStyles.label1.copyWith(
                              color: HourColors.staticWhite
                          ),
                          hintText: '금액을 입력해주세요',
                          hintStyle: HourStyles.label1.copyWith(color: HourColors.gray500),
                          border: InputBorder.none,
                        ),
                        style: HourStyles.body2.copyWith(color: HourColors.staticWhite),
                        onChanged: (value) {
                          String rawValue = value.replaceAll(',', '');
                          final int? intValue = int.tryParse(rawValue);
                          if (intValue == null) return;
                          String formatted = _formatter.format(intValue);
                          if (formatted != value) {
                            _amountControllers[index].value = TextEditingValue(
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

                const SizedBox(height: 12),
                GestureDetector(
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
                ),
                const SizedBox(height: 24),

                viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator(color: HourColors.orange500))
                    : ElevatedButton(
                  onPressed: () async {
                    if (widget.viewModel.isEditing && widget.viewModel.selectedCategory != null) {
                      final title = _titleControllers[0].text.trim();
                      final amount = int.tryParse(_amountControllers[0].text.replaceAll(',', '')) ?? 0;
                      if (title.isNotEmpty && amount > 0) {
                        // TODO: updateCategory 메서드 추가 필요
                        print('업데이트 필요: ${title}, ${amount}');
                      }
                      Navigator.of(context).pop();
                      return;
                    }

                    for (int i = 0; i < _titleControllers.length; i++) {
                      final title = _titleControllers[i].text.trim();
                      final raw = _amountControllers[i].text.replaceAll(',', '');
                      final amount = int.tryParse(raw) ?? 0;

                      if (title.isEmpty || amount <= 0) continue;

                      await viewModel.addCategory(
                        title: title,
                        amount: amount,
                        date: DateTime.now(),
                      );
                    }

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("카테고리가 저장되었습니다.")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HourColors.orange500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("저장하기", style: HourStyles.label1.copyWith(color: HourColors.staticWhite)),
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
