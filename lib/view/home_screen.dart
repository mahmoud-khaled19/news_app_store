import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/utils/values_manager.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/news_widget.dart';
import '../widgets/pagination_list.dart';
import '../widgets/suggestions_container_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(' build Home screen');
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        drawer: const  DrawerWidget(),
        body:  Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const PaginationList(),
              SizedBox(
                height: AppSize.s8,
              ),
              const SuggestionsContainerWidget(),
               NewsWidget(),
            ],
          ),
        )
    );
  }
}
