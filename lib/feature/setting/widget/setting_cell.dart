import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

class SettingCell extends StatelessWidget {

  final String title;
  final int amount;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  SettingCell({
    super.key,
    required this.title,
    required this.amount,
    required this.onDelete,
    required this.onEdit,
  });

  final formatter = NumberFormat('#,###');

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: HourStyles.body2.copyWith(
                          color: HourColors.staticWhite,
                        ),
                      ),
                      const Spacer(flex: 1),
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
                                color: HourColors.staticWhite)
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('삭제', style: TextStyle(
                                color: HourColors.staticWhite)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "₩",
                        style: HourStyles.body1.copyWith(
                            color: HourColors.primary300
                        ),
                      ),
                      Spacer(flex: 1),
                      Row(
                        children: [
                          Text(
                            "${formatter.format(this.amount)}",
                            style: HourStyles.body2.copyWith(
                                color: HourColors.staticWhite
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
