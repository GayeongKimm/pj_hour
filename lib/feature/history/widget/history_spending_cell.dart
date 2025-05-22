import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

class HistorySpendingCell extends StatelessWidget {

  final String category;
  final String item;
  final dynamic amount;

  HistorySpendingCell({super.key,required this.category, required this.item, required this.amount});

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
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HourColors.gray600,
              ),
              child: Image.asset(
                'assets/images/ic_shopping.png',
                color: HourColors.primary300,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "쇼핑",
                  style: HourStyles.label1
                      .copyWith(color: HourColors.staticWhite),
                ),
                SizedBox(height: 5),
                Text(
                  "졸업사진 옷",
                  style:
                      HourStyles.label2.copyWith(color: HourColors.staticWhite),
                ),
              ],
            ),
            Spacer(flex: 1),
            Text(
              "₩${formatter.format(this.amount)}",
              style: HourStyles.label2
                  .copyWith(color: HourColors.staticWhite),
            ),
          ],
        ),
      ),
    );
  }
}
