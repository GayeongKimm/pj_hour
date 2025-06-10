import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

class SettingCell extends StatelessWidget {

  final String title;
  final int budget;

  SettingCell({
    super.key,
    required this.title,
    required this.budget
  });

  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: HourColors.gray800,
          borderRadius: BorderRadius.all(
              Radius.circular(12)
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${this.title}",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                Spacer(flex: 1),
                Image.asset(
                  width: 24,
                  height: 24,
                  "assets/images/ic_more.png",
                  color: HourColors.gray500,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "₩",
                  style: HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                ),
                Spacer(flex: 1),
                Row(
                  children: [
                    Text(
                      "${formatter.format(this.budget)}",
                      style: HourStyles.title1.copyWith(
                          color: HourColors.staticWhite
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
