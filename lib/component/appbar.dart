import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class DefaultAppbar extends StatelessWidget {
  final String title;
  final Function() onPlusClick;
  final Color colors;

  const DefaultAppbar({
    super.key,
    required this.title,
    required this.onPlusClick,
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
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: HourStyles.title1.copyWith(
                    color: HourColors.staticWhite
                ),
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: InkWell(
                    onTap: onPlusClick,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        "assets/images/ic_plus.png",
                        color: colors,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
