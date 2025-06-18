import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:provider/provider.dart';

import '../../../component/default_appbar.dart';
import '../../../local/entity/category_entity.dart';
import '../../category/viewmodel/category_viewmodel.dart';
import '../item/analytic_category_item.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  @override
  void initState() {
    super.initState();
    final categoryViewModel = context.read<CategoryViewmodel>();
    categoryViewModel.getCategoryEntities();
  }

  final categoryColors = [
    const Color(0xFFD96536),
    const Color(0xFFC8512B),
    const Color(0xFFB83D1F),
    const Color(0xFFA02F15),
    const Color(0xFF701F10),
  ];

  Widget _pieChartDataItem({
    required Color color,
    required String label,
    required int amount,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: HourStyles.label2.copyWith(
            color: HourColors.staticWhite,
          ),
        ),
        const Spacer(),
        Text(
          '₩${amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
          style: HourStyles.label2.copyWith(
            color: HourColors.staticWhite,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = context.watch<CategoryViewmodel>();
    final categories = categoryViewModel.categoryEntities;

    final total = categories.fold<int>(0, (sum, e) => sum + e.amount);

    final sortedCategories = [...categories]
      ..sort((a, b) => b.amount.compareTo(a.amount));

    final categoryWithColors = sortedCategories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      final color = categoryColors[index % categoryColors.length];
      final percent = total == 0 ? 0.0 : category.amount / total * 100;
      return {
        'category': category,
        'color': color,
        'percent': percent,
      };
    }).toList();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DefaultAppbar(title: '월별 예산 설정'),
      ),
      backgroundColor: HourColors.staticBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: HourColors.staticBlack,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "카테고리별 지출",
                        style: HourStyles.body2
                            .copyWith(color: HourColors.staticWhite
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (categories.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(
                            child: Text(
                              '카테고리가 없습니다.\n추가 버튼을 눌러 카테고리를 만들어보세요.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: HourColors.gray500,
                              ),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 60,
                                  sections: categoryWithColors.map((data) {
                                    return PieChartSectionData(
                                      color: data['color'] as Color,
                                      value: data['percent'] as double,
                                      radius: 35,
                                      title: '',
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Column(
                              children: List.generate(categoryWithColors.length, (index) {
                                final data = categoryWithColors[index];
                                final category = data['category'] as CategoryEntity;
                                final color = data['color'] as Color;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _pieChartDataItem(
                                    color: color,
                                    label: category.title,
                                    amount: category.amount,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
              child: DefaultAppbar(
                  title: '이번 달 최고 카테고리'
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return AnalyticCategoryCell(
                    title: category.title,
                    icon: category.icon,
                    content: category.amount,
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