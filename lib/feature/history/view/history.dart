import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/history/viewmodel/history_viewmodel.dart';
import 'package:hour/feature/history/widget/history_calendar.dart';
import 'package:hour/feature/history/item/history_spending_item.dart';
import 'package:provider/provider.dart';

import '../../../component/default_appbar.dart';
import '../../../local/entity/category_entity.dart';
import '../../category/viewmodel/category_viewmodel.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    final historyViewModel = context.read<HistoryViewmodel>();
    historyViewModel.getHistoryEntities();
  }

  @override
  Widget build(BuildContext context) {
    final historyViewModel = context.watch<HistoryViewmodel>();
    final histories = historyViewModel.historyEntities;

    final categoryViewModel = context.watch<CategoryViewmodel>();
    final categories = categoryViewModel.categoryEntities;

    final selectedDate = _selectedDay!;
    final filteredHistories = histories.where((history) =>
    history.date.year == selectedDate.year &&
        history.date.month == selectedDate.month &&
        history.date.day == selectedDate.day
    ).toList();

    CategoryEntity? findCategoryById(int id) {
      final matches = categories.where((category) => category.id == id);
      return matches.isNotEmpty ? matches.first : null;
    }

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
                  selectedDay: _selectedDay,
                  onDaySelected: (selected, focused) {
                    setState(() {
                      _selectedDay = selected;
                      _focusedDay = focused;
                      print(selected);
                      print(focused);
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "사용한 금액",
                  style: HourStyles.title1.copyWith(
                    color: HourColors.staticWhite,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: filteredHistories.map((history) {
                    final category = findCategoryById(history.categoryId);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: HistorySpendingCell(
                        category: category?.title ?? '알 수 없음',
                        title: history.title,
                        amount: history.price,
                        icon: category?.icon ?? 'assets/images/ic_default.png',
                        onDelete: () { },
                        onEdit: () { },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}