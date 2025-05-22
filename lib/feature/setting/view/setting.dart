import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/setting/widget/add_category_bottom_sheet.dart';
import 'package:hour/feature/setting/widget/setting_cell.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void _showAddCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)
        ),
      ),
      isScrollControlled: true,
      builder: (context) => const AddCategoryBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "월별 예산 설정",
                  style:
                  HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                ),
                SizedBox(
                    height: 20
                ),
                SettingCell(
                    title: "이번달 예산",
                    budget: 200000
                ),
                SizedBox(
                    height: 14
                ),
                Row(
                  children: [
                    Text(
                      "카테고리",
                      style:
                      HourStyles.title1.copyWith(
                          color: HourColors.staticWhite
                      ),
                    ),
                    Spacer(
                        flex: 1
                    ),
                    GestureDetector(
                      onTap: () => _showAddCategoryBottomSheet(context),
                      child: Image.asset(
                        width: 24,
                        height: 24,
                        "assets/images/ic_plus.png",
                        color: HourColors.gray700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 20
                ),
                Column(
                  children: [
                    SettingCell(
                        title: "생활비",
                        budget: 200000
                    ),
                    SizedBox(
                        height: 10
                    ),
                    SettingCell(
                        title: "쇼핑",
                        budget: 200000
                    ),
                    SizedBox(
                        height: 10
                    ),
                    SettingCell(
                        title: "저축",
                        budget: 100000
                    ),
                    SizedBox(
                        height: 10
                    ),
                    SettingCell(
                        title: "고정지출",
                        budget: 300000
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
