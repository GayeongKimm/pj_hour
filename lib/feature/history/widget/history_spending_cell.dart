import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

class HistorySpendingCell extends StatelessWidget {
  final String category;
  final String title;
  final String icon;
  final int amount;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const HistorySpendingCell({
    super.key,
    required this.category,
    required this.title,
    required this.icon,
    required this.amount,
    required this.onDelete,
    required this.onEdit,
  });

  static final _formatter = NumberFormat('#,###');

  static bool _isAssetImage(String value) {
    return value.endsWith('.png') ||
        value.endsWith('.jpg') ||
        value.endsWith('.jpeg') ||
        value.startsWith('assets/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HourColors.gray800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (_isAssetImage(icon))
            Image.asset(
              icon,
              width: 36,
              height: 36,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 36, color: HourColors.gray500);
              },
            )
          else
            const Icon(Icons.category, size: 36, color: HourColors.gray500),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: HourStyles.label0.copyWith(color: HourColors.staticWhite),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: HourStyles.label2.copyWith(color: HourColors.staticWhite),
                ),
              ],
            ),
          ),
          Text(
            "₩${_formatter.format(amount)}",
            style: HourStyles.label1.copyWith(color: HourColors.staticWhite),
          ),
          PopupMenuButton<String>(
            tooltip: '더보기',
            icon: Image.asset(
              "assets/images/ic_more.png",
              width: 20,
              height: 20,
              color: HourColors.gray500,
            ),
            color: HourColors.gray700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text('수정', style: HourStyles.label2.copyWith(color: HourColors.staticWhite)),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text('삭제', style: HourStyles.label2.copyWith(color: HourColors.staticWhite)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}