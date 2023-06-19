import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_store/utils/strings_manager.dart';
import 'package:news_app_store/view/empty_screen.dart';
import '../view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import 'news_Item.dart';
import 'news_loading_widget.dart';

class NewsWidget extends StatelessWidget {
  NewsWidget({Key? key}) : super(key: key);
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    log('NewsWidget');
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        if (state is AllNewsLoadingState) {
          widget == const NewsLoadingWidget();
        } else if (state is AllNewsSuccessState) {
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
                );
              },
              itemCount: cubit.model!.articles?.length,
            ),
          );
        } else {
          widget ==
              const EmptyScreen(
                  text: AppStrings.noDataFound,
                  image: 'assets/images/no_news.png');
        }
        return widget ??
            const  NewsLoadingWidget();
      },
    );
  }
}
