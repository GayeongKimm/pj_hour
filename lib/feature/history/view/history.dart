import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/history/widget/history_calendar.dart';
import 'package:hour/feature/history/widget/history_spending_cell.dart';

import '../../../component/default_appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DefaultAppbar(
          title: '월별 예산 설정',
        ),
      ),
      backgroundColor: HourColors.staticBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HistoryCalendar(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay
                ),
                SizedBox(height: 20),
                Text(
                  "사용한 금액",
                  style:
                  HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    HistorySpendingCell(
                        category: "쇼핑",
                        item: "졸업사진 옷",
                        amount: 200000
                    ),
                    SizedBox(height: 10),
                    HistorySpendingCell(
                        category: "쇼핑",
                        item: "졸업사진 옷",
                        amount: 200000
                    ),
                    SizedBox(height: 10),
                    HistorySpendingCell(
                        category: "쇼핑",
                        item: "졸업사진 옷",
                        amount: 200000
                    ),
                    SizedBox(height: 10),
                    HistorySpendingCell(
                        category: "쇼핑",
                        item: "졸업사진 옷",
                        amount: 200000
                    ),
                    SizedBox(height: 10),
                    HistorySpendingCell(
                        category: "쇼핑",
                        item: "졸업사진 옷",
                        amount: 200000
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
