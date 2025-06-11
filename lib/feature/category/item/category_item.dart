import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../component/theme/color.dart';

class CategoryItem extends StatelessWidget {
  final int? id;
  final String title;
  final int amount;
  final DateTime date;
  final Function() onTrashClick;
  final Function() onClickCreate;

  const CategoryItem({
    super.key,
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.onTrashClick,
    required this.onClickCreate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedAmount = NumberFormat.decimalPattern().format(amount);
    final formattedDate = DateFormat.yMMMd().format(date);

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
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                          onTrashClick();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '금액: ₩ $formattedAmount',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '날짜: $formattedDate',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onClickCreate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HourColors.orange500,
                      ),
                      child: const Text('수정하기'),
                    ),
                  ),
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
            const Icon(Icons.folder, color: Colors.orange),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(
              '₩ $formattedAmount',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}