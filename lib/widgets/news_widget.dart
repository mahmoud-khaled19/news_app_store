import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/view/empty_screen.dart';
import '../view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import 'news_Item.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      AppCubit cubit = BlocProvider.of(context);
      switch (state.runtimeType) {
        case AllNewsLoadingState:
          return const Center(child: CircularProgressIndicator());
        case AllNewsSuccessState:
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var data = cubit.model!.articles![index];
                DateTime date =
                    DateFormat('yyyy-MM-dd').parse(data.publishedAt!);
                String formattedDate = DateFormat('MMM dd, yyyy').format(date);
                return NewsItem(
                  title: data.title!,
                  description: data.description!,
                  date: formattedDate,
                  image: data.urlToImage ?? '',
                  url: data.url!,
                );
              },
              itemCount: cubit.model?.articles?.length,
            ),
          );
        case AllNewsErrorState:
          return const EmptyScreen(
              text: AppStrings.errorMessage,
              image: 'assets/images/no_news.png');
        default:
          return const CircularProgressIndicator();
      }
    });
  }
}
