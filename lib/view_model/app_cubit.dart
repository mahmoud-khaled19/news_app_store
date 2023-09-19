import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/models/news_model.dart';
import 'package:news_app_store/utils/api_constance.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  NewsModel? model;
  NewsModel? searchModel;

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


}
