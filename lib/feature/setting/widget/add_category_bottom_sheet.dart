import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 4.5 / 10,
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
                  "카테고리 생성하기",
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
                        hintText: "카테고리 이름",
                        hintStyle: TextStyle(color: HourColors.gray500),
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
                    icon: const Icon(Icons.delete, color: HourColors.gray500),
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
                prefixIconConstraints: BoxConstraints(
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
                Image.asset(
                  width: 24,
                  height: 24,
                  "assets/images/ic_plus.png",
                  color: HourColors.gray500,
                ),
                SizedBox(width: 5),
                Text(
                    "새로운 카테고리 만들기",
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
                child: Text("저장하기"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
