import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/analytic/widget/analytic_category_cell.dart';
import 'package:provider/provider.dart';

import '../../category/viewmodel/category_viewmodel.dart';

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
        SizedBox(width: 5),
        Text(
          label,
          style: HourStyles.label2.copyWith(
            color: HourColors.staticWhite,
          ),
        ),
        Spacer(flex: 1),
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "통계",
                style:
                HourStyles.title1.copyWith(color: HourColors.staticWhite),
              ),
              SizedBox(height: 20),
              Container(
                color: HourColors.darkBlack,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "카테고리별 지출",
                        style: HourStyles.body2
                            .copyWith(color: HourColors.staticWhite),
                      ),
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
                            children: List.generate(categories.length, (index) {
                              final category = categories[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _pieChartDataItem(
                                  color: HourColors.orange500,
                                  label: category.title,
                                  amount: category.amount,
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "이번 달 최고 카테고리",
                style:
                HourStyles.title1.copyWith(color: HourColors.staticWhite),
              ),
              SizedBox(height: 12),
              if (categories.isEmpty)
                const Center(
                  child: Text(
                    '카테고리가 없습니다.\n추가 버튼을 눌러 카테고리를 만들어보세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HourColors.gray500),
                  ),
                )
              else
                ...categories.map((category) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AnalyticCategoryCell(
                    title: category.title,
                    item: category.title,
                    content: category.amount,
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}