import 'package:flutter/cupertino.dart';
import 'package:hour/component/theme/color.dart';


enum HistoryType { INCOME, CONSUMPTION }

extension HomeItemExtension on HistoryType {
  String get name {
    switch (this) {
      case HistoryType.INCOME:
        return "소득";
      case HistoryType.CONSUMPTION:
        return "소비";
    }
  }
}

class NightStudyItem extends StatelessWidget {
  final HistoryType tagType;
  final Function() onClickTrash;
  final String? rejectReason;
  final DateTime date;

  const NightStudyItem({
    super.key,
    required this.tagType,
    required this.onClickTrash,
    this.rejectReason,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        color: HourColors.staticWhite,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: HourColors.staticBlack,
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

        ),
      ),
    );
  }


}