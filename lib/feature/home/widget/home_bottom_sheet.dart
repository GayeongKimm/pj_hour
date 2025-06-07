import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/home/item/home_bottom_item.dart';
import 'package:hour/feature/home/viewmodel/home_viewmodel.dart';

import '../../../component/modal_bottom_sheet_container.dart';

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({super.key});

  @override
  State<HomeBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<HomeBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool isExpenseSelected = true;

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required Color selectedColor,
  }) {
    final Color backgroundColor = isSelected ? selectedColor : HourColors.gray500;
    final Color borderColor = isSelected ? selectedColor : HourColors.gray500;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpenseSelected = (label == "소비");
        });
      },
      child: Container(
        width: 62,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: HourColors.staticWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 44,
                width: 380,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    "소비 기록하기", style: HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // ...viewmodel.tblHistories.map(
              //         (data) {
              //       final categoryName = viewmodel.getCategoryNameById(data.category); // 예시 메서드
              //       return HomeBottomItem(
              //         title: data.title,
              //         content: data.content,
              //         type: data.type,
              //         category: categoryName,
              //         price: data.price,
              //         date: data.date,
              //         onTrashClick: () {
              //           viewmodel.removeEntity(data.id ?? 0);
              //         },
              //         onClickCreate: () async {
              //           Navigator.pop(context);
              //           await viewmodel.nightStudy(data);
              //         },
              //       );
              //     }
              // ).toList(),


              // Container(
              //   decoration: const BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(color: HourColors.gray500),
              //     ),
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: TextField(
              //           controller: _controller,
              //           style: const TextStyle(color: Colors.white),
              //           decoration: const InputDecoration(
              //             hintText: "소비 이름",
              //             hintStyle: TextStyle(color: HourColors.gray500),
              //             border: InputBorder.none,
              //             enabledBorder: InputBorder.none,
              //             focusedBorder: InputBorder.none,
              //             disabledBorder: InputBorder.none,
              //             isDense: true,
              //             contentPadding: EdgeInsets.symmetric(vertical: 12),
              //           ),
              //           cursorColor: HourColors.staticWhite,
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           _controller.clear();
              //         },
              //         icon: Image.asset(
              //           "assets/images/ic_trash.png",
              //           width: 24,
              //           height: 24,
              //           color: HourColors.gray500,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 2, left: 8, right: 8),
                    child: Text(
                      "₩",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  hintText: "0",
                  hintStyle: TextStyle(color: HourColors.gray500),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: HourColors.staticWhite),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                cursorColor: HourColors.staticWhite,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    "쇼핑",
                    style: TextStyle(color: HourColors.gray500),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/ic_down.png",
                    width: 24,
                    height: 24,
                    color: HourColors.gray500,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildToggleButton(
                    label: "소비",
                    isSelected: isExpenseSelected,
                    selectedColor: HourColors.orange500,
                  ),
                  const SizedBox(width: 8),
                  _buildToggleButton(
                    label: "소득",
                    isSelected: !isExpenseSelected,
                    selectedColor: HourColors.primary400,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(height: 1, color: HourColors.gray500),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    "assets/images/ic_plus.png",
                    width: 24,
                    height: 24,
                    color: HourColors.gray500,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "새로운 소비 기록하기",
                    style: TextStyle(color: Colors.white),
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
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  textStyle: HourStyles.label1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Center(
                  child: Text("저장하기"),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}