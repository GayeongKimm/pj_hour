import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class DefaultAppbar extends StatelessWidget {
  final String title;
  final Color colors;

  const DefaultAppbar({
    super.key,
    required this.title,
    this.colors = HourColors.gray700,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HourColors.staticBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 6, horizontal: 4
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 12,
                height: 48,
              ),
              Text(
                title,
                style: HourStyles.title1.copyWith(
                    color: HourColors.staticWhite
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
