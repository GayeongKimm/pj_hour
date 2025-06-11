import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class SpendingItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final String price;
  final Color color;

  const SpendingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HourColors.gray800,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HourColors.gray600,
            child: Image.asset(
              icon, width: 24, height: 24, color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, style: HourStyles.label1.copyWith(
                    color: HourColors.staticWhite
                )),
                Text(
                  subtitle, style: HourStyles.label2.copyWith(
                    color: HourColors.staticWhite
                )),
              ],
            ),
          ),
          Text(
            price, style: HourStyles.label2.copyWith(
              color: HourColors.staticWhite
          )),
        ],
      ),
    );
  }
}