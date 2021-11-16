part of 'call_cubit.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

class CallInitial extends CallState {}
