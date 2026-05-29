import 'package:flutter/material.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view/splash_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprint1 Sample',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.light,
      home: const SplashView(),
    );
  }
}
