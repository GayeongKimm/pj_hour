import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';

class HourBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HourBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: HourColors.darkBlack,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildNavItem(
              context,
              icon: 'assets/images/ic_home.png',
              index: 0,
            ),
            _buildNavItem(
              context,
              icon: 'assets/images/ic_chart.png',
              index: 1,
            ),
            _buildNavItem(
              context,
              icon: 'assets/images/ic_history.png',
              index: 2,
            ),
            _buildNavItem(
              context,
              icon: 'assets/images/ic_setting.png',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, {
        required String icon,
        required int index,
      }) {
    final isSelected = index == selectedIndex;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onItemTapped(index),
        child: Center(
          child: Image.asset(
            icon,
            height: isSelected ? 30 : 24,
            width: isSelected ? 30 : 24,
            color: isSelected ? HourColors.primary300 : HourColors.gray500,
          ),
        ),
      ),
    );
  }
}