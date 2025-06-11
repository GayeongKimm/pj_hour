import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:intl/intl.dart';

import '../../home/item/home_item.dart';

class HistoryItem extends StatelessWidget {
  final int? id;
  final String title;
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
    required this.type,
    required this.categoryId,
    required this.price,
    required this.date,
    required this.onTrashClick,
    required this.onClickCreate,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
    final formattedPrice = formatter.format(price);
    final formattedDate = DateFormat('yyyy.MM.dd').format(date);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: HourColors.staticBlack,
        child: InkWell(
          onTap: onClickCreate,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: type == HistoryType.CONSUMPTION ? HourColors.orange500 : HourColors.primary400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      type == HistoryType.CONSUMPTION ? "지출" : "수입",
                      style: HourStyles.label2.copyWith(
                        color: HourColors.staticWhite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: HourStyles.body1.copyWith(
                          color: HourColors.staticWhite,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: HourStyles.label2.copyWith(
                          color: HourColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${type == HistoryType.CONSUMPTION ? "-" : "+"}₩$formattedPrice",
                  style: HourStyles.body1.copyWith(
                    color: type == HistoryType.CONSUMPTION ? HourColors.orange500 : HourColors.primary400,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: HourColors.gray500,
                  ),
                  onPressed: onTrashClick,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}