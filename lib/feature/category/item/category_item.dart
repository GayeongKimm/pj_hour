import 'package:flutter/material.dart';

import '../../../component/theme/color.dart';
import '../../../component/theme/style.dart';

class CategoryItem extends StatelessWidget {
  final String icon;
  final String title;
  final int amount;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.onDelete,
    required this.onEdit,
  });

  bool _isAssetImage(String value) {
    return value.endsWith('.png') || value.endsWith('.jpg') || value.endsWith('.jpeg') || value.startsWith('assets/');
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _isAssetImage(icon)
                        ? Image.asset(
                      icon,
                      width: 20,
                      height: 20,
                    )
                        : Text(
                      icon,
                      style: HourStyles.label2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: HourStyles.body2.copyWith(
                        color: HourColors.staticWhite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "₩",
                      style: HourStyles.label2.copyWith(
                        color: HourColors.primary300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (amount > 0) ...[
                      const SizedBox(width: 4),
                      Text(
                        amount.toString().replaceAllMapped(
                          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                              (m) => '${m[1]},',
                        ),
                        style: HourStyles.label2.copyWith(
                          color: HourColors.staticWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
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
              const PopupMenuItem(
                value: 'edit',
                child: Text('수정', style: TextStyle(
                  color: HourColors.staticWhite,
                )),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('삭제', style: TextStyle(
                  color: HourColors.staticWhite,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}