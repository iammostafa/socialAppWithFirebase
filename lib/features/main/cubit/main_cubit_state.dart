part of 'main_cubit.dart';

abstract class MainCubitState extends Equatable {
  const MainCubitState();

  @override
  List<Object> get props => [];
}

class MainCubitInitial extends MainCubitState {}

class MainCubitLoading extends MainCubitState {}

class MainCubitSuccess extends MainCubitState {}

class MainCubitIFailed extends MainCubitState {}
