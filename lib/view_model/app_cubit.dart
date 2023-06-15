import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_store/models/news_model.dart';
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
    }
  }

  void previousNewsPage() {
    if (chosenIndex > 0) {
      chosenIndex--;
      emit(NextNewsPage());
    }
  }

  Future getAllNews() async {
    emit(AllNewsLoadingState());
    await Dio()
        .get('https://newsapi.org/v2/everything?q=bitcoin&apiKey=b57d9b1784c443c7955c0941978f7b11')
        .then((value) {
      model = NewsModel.fromJson(value.data);
      print(model);
      emit(AllNewsSuccessState());
    }).catchError((error){
      emit(AllNewsErrorState());
      print(error.toString());
    });
  }
}
