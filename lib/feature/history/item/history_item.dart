import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

import '../../home/item/home_item.dart';

class HistoryItem extends StatelessWidget {
  final int? id;
  final String title;
  final String content;
  final HistoryType type;
  final int categoryId;
  final int price;
  final DateTime date;
  final Function() onTrashClick;
  final Function() onClickCreate;

  const HistoryItem({
    super.key,
    this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.categoryId,
    required this.price,
    required this.date,
    required this.onTrashClick,
    required this.onClickCreate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          backgroundColor: HourColors.staticBlack,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: HourStyles.body1.copyWith(
                          color: HourColors.gray800
                        )
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          Navigator.pop(context);
                          onTrashClick();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: HourStyles.label1.copyWith(
                        color: HourColors.gray700
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Chip(
                        label: Text(type.name),
                        backgroundColor: type == HistoryType.INCOME
                            ? Colors.green[100]
                            : Colors.red[100],
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text('카테고리 ID: $categoryId'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '금액: $price원',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '날짜: ${DateFormat.yMMMd().format(date)}',
                    style: HourStyles.label1.copyWith(
                        color: HourColors.gray800
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onClickCreate();
                      },
                      child: const Text('수정하기'),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: HourColors.gray500, blurRadius: 5),
          ],
        ),
        child: Row(
          children: [
            Icon(
              type == HistoryType.INCOME ? Icons.arrow_downward : Icons.arrow_upward,
              color: type == HistoryType.INCOME ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text('$price원'),
          ],
        ),
      ),
    );
  }
}