import 'package:flutter/material.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../component/appbar.dart';
import '../../../component/default_appbar.dart';
import '../../../component/theme/color.dart';
import '../widget/sell_widget.dart';
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
    final viewModel = context.read<CategoryViewmodel>();
    viewModel.getCategoryEntities();
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    final viewModel = Provider.of<CategoryViewmodel>(context, listen: false);

    viewModel.clearEditingState();

    showModalBottomSheet(
      context: context,
      backgroundColor: HourColors.gray800,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)
        ),
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
    final categoryViewModel = context.watch<CategoryViewmodel>();
    final categories = categoryViewModel.categoryEntities;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DefaultAppbar(
          title: '월별 예산 설정',
        ),
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
                      budget: 200000,
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
                  return CategoryCell(
                    title: category.title,
                    amount: category.amount,
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