import 'package:flutter/material.dart';
import 'package:hour/component/default_appbar.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/item/category_item.dart';
import 'package:hour/feature/history/viewmodel/history_viewmodel.dart';
import 'package:hour/feature/history/item/history_item.dart';
import 'package:hour/feature/home/item/home_item.dart';
import 'package:hour/feature/home/widget/home_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../component/appbar.dart';
import '../../../local/entity/category_entity.dart';
import '../../../local/entity/month_entity.dart';
import '../../category/viewmodel/category_viewmodel.dart';
import '../../month/viewmodel/month_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final historyViewModel = context.read<HistoryViewmodel>();
      historyViewModel.getHistoryEntities();
      final categoryViewModel = context.read<CategoryViewmodel>();
      categoryViewModel.getCategoryEntities();
    });
  }

  void _showHomeBottomSheet(BuildContext context) {
    final viewModel = Provider.of<HistoryViewmodel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => HomeBottomSheet(
        context: context,
        viewModel: viewModel,
      ),
    );
  }

  MonthEntity? _getCurrentMonth(MonthViewmodel viewModel) {
    final now = DateTime.now();
    return viewModel.monthEntities.firstWhere(
          (e) => e.date.year == now.year && e.date.month == now.month,
      orElse: () => MonthEntity(amount: 0, date: DateTime(now.year, now.month, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final historyViewModel = context.watch<HistoryViewmodel>();
    final histories = historyViewModel.historyEntities;

    final categoryViewModel = context.watch<CategoryViewmodel>();
    final categories = categoryViewModel.categoryEntities;

    final monthViewModel = context.watch<MonthViewmodel>();
    final currentMonth = _getCurrentMonth(monthViewModel);

    CategoryEntity? findCategoryById(int id) {
      final matches = categories.where((category) => category.id == id);
      return matches.isNotEmpty ? matches.first : null;
    }

    final now = DateTime.now();

    final monthSpending = histories
        .where((h) => h.date.year == now.year && h.date.month == now.month)
        .fold<int>(0, (sum, h) =>
    h.type == HistoryType.INCOME ? sum - h.price : sum + h.price);

    final monthLimit = currentMonth?.amount ?? 0;

    final todayHistories = histories.where((history) {
      final date = history.date;
      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    final todaySpending = todayHistories.fold<int>(0, (sum, h) =>
    h.type == HistoryType.INCOME ? sum - h.price : sum + h.price);

    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final int dailyBudget = (monthLimit / daysInMonth).floor();

    final bool isMonthOverLimit = monthSpending > monthLimit;
    final Color monthProgressColor = isMonthOverLimit
        ? HourColors.primary400
        : HourColors.primary300;

    final bool isDailyOverLimit = todaySpending > dailyBudget;
    final Color dailyProgressColor = isDailyOverLimit
        ? HourColors.primary400
        : HourColors.primary300;

    final double monthProgress = monthLimit == 0 ? 0 : (monthSpending / monthLimit).clamp(0.0, 1.0);
    final double dailyProgress = todaySpending / (dailyBudget == 0 ? 1 : dailyBudget);

    final int dailyMonthRemaining = monthLimit - monthSpending;
    final bool isMonthOverLimitText = dailyMonthRemaining < 0;
    final String remainingText = isMonthOverLimitText
        ? '₩ ${NumberFormat("#,###").format(-dailyMonthRemaining)}원 초과 했어요'
        : '₩ ${NumberFormat("#,###").format(dailyMonthRemaining)}원 더 쓸 수 있어요!';

    final int dailyRemaining = dailyBudget - todaySpending;
    final bool isOverLimit = dailyRemaining < 0;
    final String remainingDailyText = isOverLimit
        ? '₩ ${NumberFormat("#,###").format(-dailyRemaining)}원 초과 했어요'
        : '₩ ${NumberFormat("#,###").format(dailyRemaining)}원 더 쓸 수 있어요!';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SubAppbar(
          title: '이번 달 소비',
          onPlusClick: () => _showHomeBottomSheet(context),
        ),
      ),
      backgroundColor: HourColors.staticBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: HourColors.darkBlack,
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '이번달 쓴 금액',
                          style: HourStyles.label1.copyWith(
                              color: HourColors.staticWhite),
                        ),
                        Text(
                          '한도: ₩ ${NumberFormat("#,###").format(monthLimit)}',
                          style: HourStyles.label1.copyWith(
                              color: HourColors.staticWhite),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₩ ${NumberFormat('#,###').format(monthSpending)}',
                      style: HourStyles.title1.copyWith(
                          color: HourColors.staticWhite),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: LinearProgressIndicator(
                        value: monthProgress,
                        backgroundColor: HourColors.gray600,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(monthProgressColor),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      remainingText,
                      style: HourStyles.label2.copyWith(
                          color: HourColors.staticWhite),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
              child: DefaultAppbar(title: '오늘의 소비'),
            ),
            Container(
              decoration: BoxDecoration(
                color: HourColors.darkBlack,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘 쓴 금액',
                    style: HourStyles.label1.copyWith(
                        color: HourColors.staticWhite),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₩ ${NumberFormat("#,###").format(todaySpending)}',
                        style: HourStyles.title1.copyWith(
                            color: HourColors.staticWhite),
                      ),
                      const Spacer(),
                      Text(
                        '₩ ${NumberFormat("#,###").format(dailyBudget)}',
                        style: HourStyles.label0.copyWith(
                            color: HourColors.staticWhite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: LinearProgressIndicator(
                      value: dailyProgress.clamp(0.0, 1.0),
                      backgroundColor: HourColors.gray600,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(dailyProgressColor),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    remainingDailyText,
                    style: HourStyles.label2.copyWith(
                        color: HourColors.staticWhite),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: histories.isEmpty
                  ? const Center(
                child: Text(
                  '기록이 없습니다.\n추가 버튼을 눌러 기록을 만들어보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HourColors.gray500),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                itemCount: todayHistories.length,
                itemBuilder: (context, index) {
                  final history = todayHistories[index];
                  final category = findCategoryById(history.categoryId);

                  return HistoryItem(
                    category: category?.title ?? '알 수 없음',
                    title: history.title,
                    amount: history.price,
                    historyType: history.type,
                    icon: category?.icon ?? 'assets/images/ic_clock.png',
                    onDelete: () {
                      historyViewModel.removeHistory(history.id!, context);
                    },
                    onEdit: () {
                      historyViewModel.setEditingHistory(history);
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: HourColors.gray800,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)),
                        ),
                        isScrollControlled: true,
                        builder: (_) => HomeBottomSheet(
                          context: context,
                          viewModel: historyViewModel,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}