import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import 'news_Item.dart';

class NewsWidget extends StatelessWidget {
  NewsWidget({Key? key}) : super(key: key);
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    log('NewsWidget');
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      AppCubit cubit = BlocProvider.of(context);
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var data = cubit.model!.articles![index];
            DateTime date = DateFormat('yyyy-MM-dd').parse(data.publishedAt!);
            String formattedDate = DateFormat('MMM dd, yyyy').format(date);
            return NewsItem(
              function: () {
                cubit.addNewsToBookMarkScreen(
                    context: context,
                    title: data.title!,
                    description: data.description!,
                    date: formattedDate,
                    image: data.urlToImage ?? '',
                    url: data.url!);
              },
              title: data.title!,
              description: data.description!,
              date: formattedDate,
              image: data.urlToImage ?? '',
              url: data.url!,
              bookMarkIcon: Icons.bookmark_add_outlined,
            );
          },
          itemCount: cubit.model?.articles?.length,
        ),
      );
    });
  }
}
