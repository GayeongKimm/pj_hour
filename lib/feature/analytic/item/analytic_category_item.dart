import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

class AnalyticCategoryCell extends StatelessWidget {

  final String title;
  final String icon;
  final dynamic content;

  AnalyticCategoryCell({
    super.key,
    required this.title,
    required this.icon,
    required this.content
  });

  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HourColors.darkBlack,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: HourColors.darkBlack
            ),
            child: Image.asset(
              width: 24,
              height: 24,
              icon,
              color: HourColors.primary300,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: HourStyles.body2.copyWith(
                    color: HourColors.staticWhite
                ),
              ),
            ],
          ),
          Spacer(flex: 1),
          Text(
            this.content.runtimeType == int ? "₩${formatter.format(this.content)}" : this.content,
            style: HourStyles.body2.copyWith(color: HourColors.staticWhite),
          ),
        ],
      ),
    );
  }
}