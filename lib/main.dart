import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/theme_manager.dart';
import 'package:news_app_store/view/home_screen.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit()..getAllNews(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App Store',
            theme: getLightApplicationTheme(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
