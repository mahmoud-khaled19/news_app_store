import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/models/news_model.dart';
import 'package:news_app_store/utils/api_constance.dart';
import 'package:news_app_store/utils/global_methods.dart';
import 'package:uuid/uuid.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  NewsModel? model;
  NewsModel? searchModel;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference bookMarks =
      FirebaseFirestore.instance.collection('bookMarks');

  static AppCubit get(context) => BlocProvider.of(context);
  int chosenIndex = 0;
  bool isDark = false;
  bool isBookMark = false;
  int currentSuggestIndex = 0;
  void changeTheme() {
    isDark = !isDark;
    emit(ChangeAppThemeState());
    getAllNews();
  }

  void changeBookMarkedNewsItem() {
    isBookMark != isBookMark;
    emit(ChangeBookMarkedNewsItemState());
  }

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

  changeIndexINSuggestionList(int index){
    currentSuggestIndex = index;
    emit(ChangeIndexINSuggestionList());
  }
  Future getAllNews() async {
    emit(AllNewsLoadingState());
    await Dio().get(ApiConstance.getAllNews, queryParameters: {
      'pageSize': 15,
      'page': chosenIndex + 1,
    }).then((value) {
      model = NewsModel.fromJson(value.data);
      emit(AllNewsSuccessState());
    }).catchError((error) {
      emit(AllNewsErrorState());
      print(error.toString());
    });
  }
  Future getSuggestionNews(String suggestion) async {
    emit(AllNewsLoadingState());
    await Dio().get('${ApiConstance.basicUrl}/everything?q=$suggestion&apiKey=${ApiConstance.basicApi}', queryParameters: {
      'pageSize': 15,
      'page': chosenIndex + 1,
    }).then((value) {
      model = NewsModel.fromJson(value.data);
      emit(AllNewsSuccessState());
    }).catchError((error) {
      emit(AllNewsErrorState());
      print(error.toString());
    });
  }

  Future searchForNews(String text) async {
    emit(SearchLoadingState());
    await Dio()
        .get(
            '${ApiConstance.basicUrl}/everything?q=$text&apiKey=${ApiConstance.basicApi}')
        .then((value) {
      searchModel = NewsModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

  Future<void> addNewsToBookMarkScreen({
    required String title,
    required String description,
    required String image,
    required String url,
    required String date,
    required BuildContext context,
  }) async {
    var newsItemId = const Uuid().v4();

    return await bookMarks.doc(newsItemId).set({
      'title': title,
      'date': date,
      'description': description,
      'image': image,
      'url': url,
      'id': newsItemId,
      'bookMarked':true,
    }).then((value) {
      GlobalMethods.showSnackBar(
          context, 'Added to Bookmarks Successfully', Colors.green);
    }).catchError((error) {
      log("Failed to add user: $error");
    } );
  }
}
