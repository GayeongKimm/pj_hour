import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class HomeSpendWidget extends StatelessWidget {
  final String title;
  final int usedAmount;
  final int maxAmount;
  final String bottomText;

  const HomeSpendWidget({
    super.key,
    required this.title,
    required this.usedAmount,
    required this.maxAmount,
    required this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    final percent = maxAmount == 0 ? 0.0 : usedAmount / maxAmount;
    return Container(
      decoration: BoxDecoration(
        color: HourColors.darkBlack,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  title,
                  style: HourStyles.label1.copyWith(
                      color: HourColors.staticWhite
                  )
              ),
              Text(
                  '한도: ₩ ${NumberFormat("#,###").format(maxAmount)}',
                  style: HourStyles.label1.copyWith(
                      color: HourColors.staticWhite
                  )
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₩ ${NumberFormat("#,###").format(usedAmount)}',
            style: HourStyles.title1.copyWith(
                color: HourColors.staticWhite
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: LinearProgressIndicator(
              value: percent.clamp(0.0, 1.0),
              backgroundColor: HourColors.gray600,
              valueColor: const AlwaysStoppedAnimation(
                  HourColors.primary300
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
              bottomText, style: HourStyles.label2.copyWith(
              color: HourColors.staticWhite
          )
          ),
        ],
      ),
    );
  }
}