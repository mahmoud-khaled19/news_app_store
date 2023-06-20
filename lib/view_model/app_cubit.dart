import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/models/news_model.dart';
import 'package:news_app_store/utils/api_constance.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  NewsModel? model;

  static AppCubit get(context) => BlocProvider.of(context);
  int chosenIndex = 0;

  void nextNewsPage() {
    if (chosenIndex < 4) {
      chosenIndex++;
      emit(NextNewsPage());
      getAllNews();
    }
  }

  void previousNewsPage() {
    if (chosenIndex > 0) {
      chosenIndex--;
      emit(NextNewsPage());
      getAllNews();
    }
  }
    Future getAllNews() async {
      emit(AllNewsLoadingState());
      await Dio().get(ApiConstance.getAllNews, queryParameters: {
        'pageSize': 20,
        'page': chosenIndex+1,
      }).then((value) {
        model = NewsModel.fromJson(value.data);
         emit(AllNewsSuccessState());
      }).catchError((error) {
         emit(AllNewsErrorState());
        print(error.toString());
      });
    }
  late final WebViewController controller;

}
