part of 'app_cubit.dart';

abstract class AppcubitState extends Equatable {
  const AppcubitState();

  @override
  List<Object> get props => [];
}

class AppcubitInitial extends AppcubitState {}
class AppcubitChangeTheme extends AppcubitState {}
