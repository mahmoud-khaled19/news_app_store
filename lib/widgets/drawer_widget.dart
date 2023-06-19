import 'package:flutter/material.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/widgets/default_custom_text.dart';
import 'list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              color: Theme.of(context).splashColor,
              child: const Center(
                  child: DefaultCustomText(
                text: 'News Drawer',
              )),
            ),
          ),
          ListTileWidget(
            text: AppStrings.lightMode,
            function: () {},
            icon: Icons.dark_mode,
          ),
          const Divider(),
          ListTileWidget(
            text: AppStrings.drawerBookMark,
            function: () {},
            icon: Icons.bookmark,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
