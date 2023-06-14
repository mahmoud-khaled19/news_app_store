import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  int chosenIndex = 0;

  void nextNewsPage() {
    if (chosenIndex < 4) {
      chosenIndex ++;
      emit(NextNewsPage());
    }
  }
  void previousNewsPage() {
    if (chosenIndex > 0) {
      chosenIndex --;
      emit(NextNewsPage());
    }
  }
}
