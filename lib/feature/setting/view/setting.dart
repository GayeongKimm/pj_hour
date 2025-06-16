import 'package:flutter/material.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:hour/feature/setting/widget/month_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../component/appbar.dart';
import '../../../component/default_appbar.dart';
import '../../../component/theme/color.dart';
import '../../../local/entity/month_entity.dart';
import '../../category/item/category_item.dart';
import '../../month/viewmodel/month_viewmodel.dart';
import '../widget/setting_bottom_sheet.dart';
import '../widget/setting_cell.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();

    final categoryViewModel = context.read<CategoryViewmodel>();
    categoryViewModel.getCategoryEntities();

    final monthViewModel = context.read<MonthViewmodel>();
    monthViewModel.getMonthEntities();
  }

  MonthEntity? _getCurrentMonth(MonthViewmodel viewModel) {
    final now = DateTime.now();
    return viewModel.monthEntities.firstWhere(
          (e) => e.date.year == now.year && e.date.month == now.month,
      orElse: () => MonthEntity(amount: 0, date: DateTime(now.year, now.month, 1)),
    );
  }

  void _showMonthBottomSheet(BuildContext context, {MonthEntity? monthEntity}) {
    final viewModel = Provider.of<MonthViewmodel>(context, listen: false);

    if (monthEntity != null) {
      viewModel.setEditingMonth(monthEntity);
    } else {
      viewModel.clearEditingState();
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: HourColors.gray800,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (_) => MonthBottomSheet(viewModel: viewModel),
    );
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    final viewModel = Provider.of<CategoryViewmodel>(context, listen: false);
    viewModel.clearEditingState();

    showModalBottomSheet(
      context: context,
      backgroundColor: HourColors.gray800,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (_) => SettingBottomSheet(
        context: context,
        viewModel: viewModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthViewModel = context.watch<MonthViewmodel>();
    final categoryViewModel = context.watch<CategoryViewmodel>();

    final currentMonth = _getCurrentMonth(monthViewModel);
    final categories = categoryViewModel.categoryEntities;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DefaultAppbar(title: '월별 예산 설정'),
      ),
      backgroundColor: HourColors.staticBlack,
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                color: HourColors.staticBlack,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SettingCell(
                      title: "이번달 예산",
                      amount: currentMonth?.amount ?? 0,
                      onEdit: () {
                        _showMonthBottomSheet(
                          context,
                          monthEntity: currentMonth,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: SubAppbar(
                title: '카테고리',
                onPlusClick: () => _showAddCategoryBottomSheet(context),
              ),
            ),
            Expanded(
              child: categories.isEmpty
                  ? const Center(
                child: Text(
                  '카테고리가 없습니다.\n추가 버튼을 눌러 카테고리를 만들어보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HourColors.gray500),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryItem(
                    title: category.title,
                    amount: category.amount,
                    icon: category.icon,
                    onDelete: () {
                      categoryViewModel.removeEntity(category.id!);
                    },
                    onEdit: () {
                      categoryViewModel.setEditingCategory(category);
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: HourColors.gray800,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        isScrollControlled: true,
                        builder: (_) => SettingBottomSheet(
                          context: context,
                          viewModel: categoryViewModel,
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