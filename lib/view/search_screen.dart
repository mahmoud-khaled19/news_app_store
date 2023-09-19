import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/view/empty_screen.dart';
import 'package:news_app_store/view_model/app_cubit.dart';
import 'package:news_app_store/widgets/news_Item.dart';
import 'package:news_app_store/widgets/text_form_field_widget.dart';
import '../view_model/app_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: DefaultTextFormField(
              focusNode: node,
              onSubmittedFunction: () {
                cubit.searchForNews(searchController.text);
              },
              hint: 'type to Search',
              suffixFunction: () {
                searchController.clear();
              },
              suffixIcon: Icons.close,
              controller: searchController,
              validate: (String? value) {
                return null;
              },
            ),
          ),
          body: Column(
            children: [
              if (state is SearchLoadingState)
                const LinearProgressIndicator(
                  color: Colors.blue,
                ),
              cubit.searchModel?.articles != null
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = cubit.searchModel!.articles![index];
                          return NewsItem(
                            image: data.urlToImage ?? '',
                            title: data.title!,
                            description: data.description!,
                            date: data.publishedAt!,
                            url: data.url!,
                          );
                        },
                        itemCount: cubit.searchModel?.articles?.length ?? 2,
                      ),
                    )
                  : const Expanded(
                      child: EmptyScreen(
                          text: 'you did\'t Search yet',
                          image: 'assets/images/no_news.png')),
            ],
          ),
        );
      },
    );
  }
}
