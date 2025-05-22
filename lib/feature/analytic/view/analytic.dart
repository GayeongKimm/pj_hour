import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/analytic/widget/analytic_category_cell.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  final TextEditingController _reasonTextFieldController =
  TextEditingController();

  final dummyData = [
    {'value': 60.0, 'color': HourColors.orange500},
    {'value': 30.0, 'color': HourColors.orange600},
    {'value': 10.0, 'color': HourColors.orange700},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "통계",
                  style:
                  HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
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
                              .copyWith(color: HourColors.staticWhite
                          ),
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
                                  sections: dummyData.map((data) {
                                    return PieChartSectionData(
                                      color: data['color'] as Color,
                                      value: data['value'] as double,
                                      radius: 35,
                                      title: '',
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: HourColors.orange500,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "음식",
                                      style: HourStyles.label2.copyWith(
                                          color: HourColors.staticWhite
                                      ),
                                    ),
                                    Spacer(flex: 1),
                                    Text(
                                      "₩145,000",
                                      style: HourStyles.label2.copyWith(
                                          color: HourColors.staticWhite
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: HourColors.orange500,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "쇼핑",
                                      style: HourStyles.label2.copyWith(
                                          color: HourColors.staticWhite
                                      ),
                                    ),
                                    Spacer(flex: 1),
                                    Text(
                                      "₩112,000",
                                      style: HourStyles.label2.copyWith(
                                          color: HourColors.staticWhite
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: HourColors.orange500,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "엔터테인먼트",
                                      style: HourStyles.label2.copyWith(
                                          color: HourColors.staticWhite),
                                    ),
                                    Spacer(flex: 1),
                                    Text(
                                      "₩52000",
                                      style: HourStyles.label2.copyWith(
                                          color: HourColors.staticWhite),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                  HourStyles.title1.copyWith(
                      color: HourColors.staticWhite
                  ),
                ),
                Column(
                  children: [
                    AnalyticCategoryCell(
                        title: "음식",
                        item: "shonnting",
                        content: 38200
                    ),
                    SizedBox(height: 10),
                    AnalyticCategoryCell(
                        title: "음식",
                        item: "shonnting",
                        content: 38200
                    ),
                    SizedBox(height: 10),
                    AnalyticCategoryCell(
                        title: "음식",
                        item: "shonnting",
                        content: 38200
                    ),
                    SizedBox(height: 10),
                    AnalyticCategoryCell(
                        title: "음식",
                        item: "shonnting",
                        content: 38200
                    ),
                    SizedBox(height: 10),
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
