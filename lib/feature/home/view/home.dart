import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/history/viewmodel/history_viewmodel.dart';
import 'package:hour/feature/home/widget/home_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../component/appbar.dart';
import '../../history/item/history_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _reasonTextFieldController = TextEditingController();

  void _showHomeBottomSheet(BuildContext context) {
    final viewModel = Provider.of<HistoryViewmodel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      backgroundColor: HourColors.gray800,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (_) => HomeBottomSheet(
        context: context,
        viewModel: viewModel,
      ),
    );
  }

  @override
  void dispose() {
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryViewmodel>(
      builder: (context, viewModel, _) {
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: HourColors.gray800,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('이번달 쓴 금액', style: HourStyles.label1.copyWith(color: HourColors.staticWhite)),
                            Text('한도: ₩ 400,000', style: HourStyles.label1.copyWith(color: HourColors.staticWhite)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('₩ 100,000', style: HourStyles.title1.copyWith(color: HourColors.staticWhite)),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: LinearProgressIndicator(
                            value: 0.4,
                            backgroundColor: HourColors.gray600,
                            valueColor: const AlwaysStoppedAnimation<Color>(HourColors.primary300),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('₩ 300,000원 더 쓸 수 있어요!', style: HourStyles.label2.copyWith(color: HourColors.staticWhite)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SpendingItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final String price;
  final Color color;

  const SpendingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HourColors.gray800,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HourColors.gray600,
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: HourStyles.label1.copyWith(color: HourColors.staticWhite)),
                Text(subtitle, style: HourStyles.label2.copyWith(color: HourColors.staticWhite)),
              ],
            ),
          ),
          Text(price, style: HourStyles.label2.copyWith(color: HourColors.staticWhite)),
        ],
      ),
    );
  }
}