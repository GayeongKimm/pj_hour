import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

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
    final Color backgroundColor =
    isSelected ? selectedColor : HourColors.gray500;
    final Color borderColor =
    isSelected ? selectedColor : HourColors.gray500;

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
          border: Border.all(
              color: borderColor
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 6 / 10,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "소비 기록하기",
                  style: HourStyles.title1.copyWith(
                      color: Colors.white
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: HourColors.gray500
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      decoration: const InputDecoration(
                        hintText: "소비 이름",
                        hintStyle: TextStyle(
                            color: HourColors.gray500
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12
                        ),
                      ),
                      cursorColor: HourColors.staticWhite,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: Image.asset(
                      width: 24,
                      height: 24,
                      "assets/images/ic_trash.png",
                      color: HourColors.gray500,
                    ),
                  )
                ],
              ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      top: 2,
                      left: 8,
                      right: 8
                  ),
                  child: Text(
                    "₩",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                prefixIconConstraints:
                BoxConstraints(
                    minWidth: 0,
                    minHeight: 0
                ),
                hintText: "0",
                hintStyle: TextStyle(
                    color: HourColors.gray500
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: HourColors.staticWhite
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.white
              ),
              cursorColor: HourColors.staticWhite,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                    "쇼핑",
                    style: TextStyle(
                        color: HourColors.gray500
                    )
                ),
                Spacer(flex: 1),
                Image.asset(
                  width: 24,
                  height: 24,
                  "assets/images/ic_down.png",
                  color: HourColors.gray500,
                ),
              ],
            ),
            SizedBox(
                height: 10
            ),
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
            SizedBox(height: 10),
            Container(
              height: 1,
              color: HourColors.gray500,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  width: 24,
                  height: 24,
                  "assets/images/ic_plus.png",
                  color: HourColors.gray500,
                ),
                SizedBox(width: 5),
                Text(
                    "새로운 소비 기록하기",
                    style: TextStyle(
                        color: Colors.white
                    )
                ),
              ],
            ),
            Spacer(flex: 1),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HourColors.orange500,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
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
                child: Text(
                    "저장하기"
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
