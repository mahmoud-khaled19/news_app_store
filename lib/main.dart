import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/theme_manager.dart';
import 'package:news_app_store/view/splash_screen.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/view_model/app_state.dart';
import 'package:news_app_store/view_model/bloc%20observer.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
