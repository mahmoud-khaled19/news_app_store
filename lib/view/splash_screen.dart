import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/view/home_screen.dart';
import 'package:news_app_store/widgets/default_custom_text.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 800,
      duration: 3000,
      splash: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_2LdLki.json'),
            SizedBox(
              height: AppSize.s20,
            ),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                   DefaultCustomText(text: 'Developed By : Mahmoud Khaled')
                ] )
          ],
        ),
      ),
      nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
