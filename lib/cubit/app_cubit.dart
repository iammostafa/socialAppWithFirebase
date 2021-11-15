import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppcubitState> {
  AppCubit() : super(AppcubitInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  changeTheme() {
    emit(AppcubitInitial());
    isDark = !isDark;
    print(isDark);
    emit(AppcubitChangeTheme());
  }
}
