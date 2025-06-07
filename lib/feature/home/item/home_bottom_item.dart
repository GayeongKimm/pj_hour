import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/home/item/home_item.dart';

class HomeBottomItem extends StatelessWidget {
  final String title;
  final String content;
  final HistoryType type;
  final String category;
  final int price;
  final DateTime date;
  final Function() onTrashClick;
  final Function() onClickCreate;

  const HomeBottomItem({
    super.key,
    required this.title,
    required this.content,
    required this.type,
    required this.category,
    required this.price,
    required this.date,
    required this.onTrashClick,
    required this.onClickCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HourColors.staticBlack,
      child: InkWell(
        onTap: onClickCreate,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: HourStyles.body2.copyWith(color: HourColors.gray500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content.isNotEmpty ? "$content" : "소비 이름을 입력해 주세요.",
                      style: HourStyles.body2.copyWith(
                        color: content.isNotEmpty
                            ? HourColors.staticWhite
                            : HourColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
