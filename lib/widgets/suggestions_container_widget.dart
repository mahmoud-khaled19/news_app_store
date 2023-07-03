import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/utils/values_manager.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/view_model/app_state.dart';

class SuggestionsContainerWidget extends StatelessWidget {
  SuggestionsContainerWidget({Key? key}) : super(key: key);

  final List<String> keyWords = [
    'Business',
    'Sports',
    'Music',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return SizedBox(
          height: AppSize.s40,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: keyWords.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cubit.changeIndexINSuggestionList(index);
                   cubit.getSuggestionNews(keyWords[cubit.currentSuggestIndex]);
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  height: size * 0.05,
                  width: size * 0.12,
                  decoration: BoxDecoration(
                    color: cubit.currentSuggestIndex == index
                        ? Colors.blue
                        : Theme.of(context).cardColor,
                    border: Border.all(color: Theme.of(context).splashColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      keyWords[index],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
