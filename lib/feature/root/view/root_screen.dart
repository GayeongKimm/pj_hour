import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hour/component/bottom_navigation_bar.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/core/navigation/app_routes.dart';
import 'package:hour/feature/analytic/view/analytic.dart';
import 'package:hour/feature/history/view/history.dart';
import 'package:hour/feature/home/view/home.dart';
import 'package:hour/feature/setting/view/setting.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AnalyticScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HourColors.staticBlack,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: HourBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
