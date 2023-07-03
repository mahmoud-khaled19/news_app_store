import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/global_methods.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/view/search_screen.dart';
import '../view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/news_widget.dart';
import '../widgets/pagination_list.dart';
import '../widgets/suggestions_container_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
               GestureDetector(
                onTap: (){
                  GlobalMethods.navigateTo(context, SearchScreen());
                },
                child: const Icon(Icons.search),
              ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            AppCubit cubit = BlocProvider.of(context);
            return RefreshIndicator(
              displacement: 4,
              onRefresh: () {
                return cubit.getAllNews();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const PaginationList(),
                    SizedBox(
                      height: AppSize.s4,
                    ),
                     SuggestionsContainerWidget(),
                    SizedBox(
                      height: AppSize.s8,
                    ),
                    NewsWidget(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
