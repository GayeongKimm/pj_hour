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
    this.colors = HourColors.primary300,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HourColors.staticWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: HourStyles.title1,
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
                        "assets/images/ic_setting.png",
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
