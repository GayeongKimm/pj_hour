import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/home/widget/home_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _reasonTextFieldController =
  TextEditingController();

  void _showHomeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => const HomeBottomSheet(),
    );
  }

  @override
  void dispose() {
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<HomeViewmodel>(builder:
    //     (BuildContext context, HomeViewmodel viewModel, Widget? child) {
    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(60),
        //   child: DefaultAppbar(
        //     title: '이번 달 소비',
        //     onPlusClick: () {
        //       showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return ChangeNotifierProvider.value(
        //             value: viewModel,
        //             child: Consumer<HomeViewmodel>(
        //               builder: (
        //                   BuildContext context,
        //                   HomeViewmodel value,
        //                   Widget? child,
        //                   ) {
        //                 return HomeBottomSheet(context, viewModel);
        //               },
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),

      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '이번달 요약',
                    style: HourStyles.title1.copyWith(
                        color: HourColors.staticWhite
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showHomeBottomSheet(context),
                    child: Image.asset(
                      width: 24,
                      height: 24,
                      "assets/images/ic_plus.png",
                      color: HourColors.gray700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                        Text('이번달 쓴 금액',
                            style: HourStyles.label1.copyWith(
                                color: HourColors.staticWhite
                            )
                        ),
                        Text(
                          '한도: ₩ 400,000',
                          style: HourStyles.label1.copyWith(
                              color: HourColors.staticWhite
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 8
                    ),
                    Text(
                      '₩ 100,000',
                      style: HourStyles.title1.copyWith(
                          color: HourColors.staticWhite
                      ),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Container(
                      height: 8,
                      child: LinearProgressIndicator(
                        value: 0.4,
                        backgroundColor: HourColors.gray600,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          HourColors.primary300,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    const SizedBox(
                        height: 8
                    ),
                    Text(
                      '₩ 300,000원 더 쓸 수 있어요!',
                      style: HourStyles.label2.copyWith(
                          color: HourColors.staticWhite
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 24
              ),
              Text(
                '오늘의 소비',
                style: HourStyles.title1.copyWith(
                    color: HourColors.staticWhite
                ),
              ),
              const SizedBox(
                  height: 12
              ),
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
                        Text(
                            '오늘 쓴 금액',
                            style: HourStyles.label1.copyWith(
                                color: HourColors.staticWhite
                            )
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 8
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₩ 10,000',
                          style: HourStyles.title1.copyWith(
                              color: HourColors.staticWhite
                          ),
                        ),
                        Text('₩ 30,000',
                            style: HourStyles.label1.copyWith(
                                color: HourColors.staticWhite
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 8,
                      child: LinearProgressIndicator(
                        value: 0.4,
                        backgroundColor: HourColors.gray600,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          HourColors.primary300,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SpendingItem(
                icon: 'assets/images/ic_shopping.png',
                title: '용돈',
                subtitle: '한 달 용돈',
                price: '₩ 400,000',
                color: HourColors.primary400,
              ),
              const SpendingItem(
                icon: 'assets/images/ic_shopping.png',
                title: '쇼핑',
                subtitle: '졸업사진 옷',
                price: '₩ 400,000',
                color: HourColors.primary300,
              ),
              const SpendingItem(
                icon: 'assets/images/ic_shopping.png',
                title: '쇼핑',
                subtitle: '졸업사진 옷',
                price: '₩ 400,000',
                color: HourColors.primary300,
              ),
            ],
          ),
        ),
      ),
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
              width: 24,
              height: 24,
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    title,
                    style: HourStyles.label1.copyWith(
                        color: HourColors.staticWhite
                    )
                ),
                Text(
                    subtitle,
                    style: HourStyles.label2.copyWith(
                        color: HourColors.staticWhite
                    )
                ),
              ],
            ),
          ),
          Text(
              price,
              style: HourStyles.label2.copyWith(
                  color: HourColors.staticWhite
              )
          ),
        ],
      ),
    );
  }
}