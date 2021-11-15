part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFaild extends LoginState {
  final String error;
  LoginFaild(this.error);
}

class LoginGmailLoading extends LoginState {}

class LoginGmailSuccess extends LoginState {}

class LoginGmailFailed extends LoginState {
  final String error;
  LoginGmailFailed(this.error);
}
