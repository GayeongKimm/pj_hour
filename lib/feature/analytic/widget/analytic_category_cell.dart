import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

class AnalyticCategoryCell extends StatelessWidget {

  final String title;
  final String item;
  final dynamic content;

  AnalyticCategoryCell({super.key, required this.title, required this.item, required this.content});

  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: HourColors.darkBlack,
          borderRadius: BorderRadius.all(
              Radius.circular(12)
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HourColors.darkBlack
              ),
              //TODO 재사용 할 수 있는 클래스 적용
              child: Image.asset(
                width: 24,
                height: 24,
                "assets/images/ic_shopping.png",
                color: HourColors.primary300,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "음식",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "shonnting",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Spacer(flex: 1),
            Text(
              this.content.runtimeType == int ? "₩${formatter.format(this.content)}" : this.content,
              style: HourStyles.title1.copyWith(color: HourColors.staticWhite),
            ),
          ],
        ),
      ),
    );
  }
}
