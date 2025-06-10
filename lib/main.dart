import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';
import 'package:hour/feature/analytic/view/analytic.dart';
import 'package:hour/feature/category/viewmodel/category_viewmodel.dart';
import 'package:hour/feature/home/view/home.dart';
import 'package:hour/feature/root/view/root_screen.dart';
import 'package:provider/provider.dart';

import 'core/navigation/app_routes.dart';
import 'feature/history/viewmodel/history_create_viewmodel.dart';
import 'feature/history/viewmodel/history_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting();

  // final database = LocalDatabase();
  // GetIt.I.registerSingleton<LocalDatabase>(database);
  //
  // final repository = ScheduleRepository();
  // final scheduleProvider = ScheduleProvider(repository: repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoryViewmodel()),
        ChangeNotifierProvider(create: (_) => CategoryViewmodel()),
        ChangeNotifierProvider(create: (_) => HistoryCreateViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      // providers: [
      // ChangeNotifierProvider(create: (_) => ()),
      // ],
      create: (BuildContext context) {},
      child: MaterialApp(
        title: "hour",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Pretendard",
          scaffoldBackgroundColor: HourColors.staticWhite,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: _NoAnimationTransition(),
              TargetPlatform.iOS: _NoAnimationTransition(),
            },
          ),
        ),
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (context) => SplashScreen(),
          AppRoutes.root: (context) => RootScreen(),
          AppRoutes.home: (context) => HomeScreen(),
          AppRoutes.analytic: (context) => AnalyticScreen(),
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacementNamed(context, AppRoutes.root);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: HourColors.staticBlack,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/ic_logo.svg',
                  width: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  "HOUR",
                  style: HourStyles.title1
                      .copyWith(fontSize: 30, color: HourColors.staticWhite),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoAnimationTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
