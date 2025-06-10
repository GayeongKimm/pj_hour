import 'package:flutter/material.dart';
import 'package:hour/component/appbar.dart';
import 'package:hour/component/default_appbar.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:hour/feature/setting/widget/setting_bottom_sheet.dart';
import 'package:hour/feature/setting/widget/setting_cell.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void _showAddCategoryBottomSheet(BuildContext context) {
    final viewModel = Provider.of<CategoryViewmodel>(context, listen: false);
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
          ],
        ),
      ),
    );
  }
}

Widget _loading(bool isLoading) {
  if (isLoading) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          backgroundColor: HourColors.staticWhite,
          color: HourColors.primary300,
        ),
      ),
    );
  } else {
    return SizedBox();
  }
}
