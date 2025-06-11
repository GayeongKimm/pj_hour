import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class CategoryCell extends StatelessWidget {
  final String title;
  final int amount;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryCell({
    super.key,
    required this.title,
    required this.amount,
    required this.onDelete,
    required this.onEdit,
  });

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
          // 왼쪽: 제목 및 금액
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: HourStyles.body2.copyWith(
                    color: HourColors.staticWhite,
                  ),
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
                ),
              ],
            ),
          ),

          // 오른쪽: 점 3개 메뉴 버튼
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: HourColors.gray500),
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
                child: Text('수정', style: TextStyle(color: HourColors.staticWhite)),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('삭제', style: TextStyle(color: HourColors.staticWhite)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}