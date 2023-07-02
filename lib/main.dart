import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/theme_manager.dart';
import 'package:news_app_store/view/splash_screen.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/view_model/app_state.dart';
import 'package:news_app_store/view_model/bloc%20observer.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getAllNews(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              AppCubit cubit = BlocProvider.of(context);
              return MaterialApp(
                builder: (context, child) {
                  return ResponsiveBreakpoints.builder(
                    child: child!,
                    breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 800, name: TABLET),
                      const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                      const Breakpoint(
                          start: 1921, end: double.infinity, name: '4K'),
                    ],
                  );
                },
                debugShowCheckedModeBanner: false,
                title: 'News App',
                theme: cubit.isDark
                    ? getLightApplicationTheme()
                    : getDarkApplicationTheme(),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
