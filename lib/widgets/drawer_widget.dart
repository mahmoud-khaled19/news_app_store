import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/view_model/app_state.dart';
import 'package:news_app_store/widgets/default_custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/global_methods.dart';
import '../view/bookmarks_screen.dart';
import 'list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  color: Theme.of(context).splashColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                          child: DefaultCustomText(
                        text: 'News Drawer',
                      )),
                    ],
                  ),
                ),
              ),
              ListTileWidget(
                text: AppStrings.drawerHome,
                function: () {
                  Navigator.pop(context);
                },
                icon: Icons.home,
              ),
              const Divider(
                thickness: 3,
              ),
              ListTileWidget(
                text: cubit.isDark ? AppStrings.lightMode : AppStrings.darkMode,
                function: () {
                  cubit.changeTheme();
                },
                icon: cubit.isDark ? Icons.brightness_4 : Icons.dark_mode,
              ),
              const Divider(
                thickness: 3,
              ),
              ListTileWidget(
                text: AppStrings.drawerBookMark,
                function: () {
                  GlobalMethods.navigateTo(context, const BookMarksScreen());
                },
                icon: Icons.bookmark,
              ),
              const Divider(
                thickness: 3,
              ),
              ListTileWidget(
                text: 'Contact With Developer',
                function: () {
                  final Uri url = Uri.parse('https://wa.me/+971581077302');
                  launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: Icons.chat,
              ),
            ],
          ),
        );
      },
    );
  }
}
