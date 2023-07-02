import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/view/search_screen.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/news_widget.dart';
import '../widgets/pagination_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
/// make search screen
  ///  make trends screen

  @override
  Widget build(BuildContext context) {
    log(' build Home screen');
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return  SearchScreen();
                }));
              },
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
               NewsWidget(),
            ],
          ),
        )
    );
  }
}
