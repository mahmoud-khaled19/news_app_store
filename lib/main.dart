import 'package:flutter/material.dart';
import 'package:news_app_store/utils/theme_manager.dart';
import 'package:news_app_store/view/home_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App Store',
          theme: getLightApplicationTheme(),
          home:  HomeScreen(),
        );
      },
    );
  }
}
