part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLogin extends UserState {}

class UserLoggingIn extends UserState {}

class UserLoggedIn extends UserState {
  final String token;
  UserLoggedIn(this.token);
}

class UserLoginError extends UserState {
  final String msg;
  UserLoginError(this.msg);
}

class UserSignUp extends UserState {}

class UserSigningUp extends UserState {}

class UserSignUpError extends UserState {
  final String msg;
  UserSignUpError(this.msg);
}

class UserLogout extends UserState {}
