import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/view_model/app_state.dart';
import 'package:news_app_store/widgets/news_Item.dart';
import 'package:sizer/sizer.dart';
import '../widgets/elevated_button_widget.dart';
import '../widgets/suggestions_container_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getAllNews(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
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
            drawer: const Drawer(),
            body: state is AllNewsSuccessState? Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.s30,
                    child: Row(
                      children: [
                        DefaultButton(
                          text: AppStrings.previous,
                          function: () {
                            cubit.previousNewsPage();
                          },
                          context: context,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                  right: 0.5.h,
                                  left: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                    color: cubit.chosenIndex == index
                                        ? Colors.blue
                                        : Theme.of(context).splashColor),
                                child: InkWell(
                                  onTap: () {
                                    cubit.chosenIndex == index;
                                  },
                                  child: Text(
                                    '${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: AppSize.s12),
                                  ),
                                ),
                              );
                            },
                            itemCount: 5,
                          ),
                        ),
                        DefaultButton(
                          text: AppStrings.next,
                          function: () {
                            cubit.nextNewsPage();
                          },
                          context: context,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                  const SuggestionsContainerWidget(),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = cubit.model!.articles![index];
                        return NewsItem(
                          title: data.title!,
                          description: data.description!,
                          date: data.publishedAt!,
                          image: data.urlToImage?? '',
                        );
                      },
                      itemCount:cubit.model!.articles?.length,
                    ),
                  ),
                ],
              ),
            ): const Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}
