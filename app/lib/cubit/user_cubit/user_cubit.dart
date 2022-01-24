import 'dart:convert';

import 'package:app/models/ticket.dart';
import 'package:app/models/user.dart';
import 'package:app/services/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(UserInitial());

  void login(String username, String password) async {
    emit(UserLoggingIn());
    String token = await userRepository.login(username, password);
    if (token == "") {
      emit(UserLoginError("Login failed"));
      emit(UserLogin());
    } else {
      emit(UserLoggedIn(token));
      await userRepository.persistToken(token);
    }
  }

  void logout() async {
    if (await userRepository.isLoggedIn()) {
      await userRepository.deleteToken();
      emit(UserLogout());
    }
  }

  isLoggedIn() async {
    return await userRepository.isLoggedIn();
  }

  void signUp(User user) async {
    final response = await userRepository.signUp(user);
    if (response["errors"] != null) {
      emit(UserSignUpError("Username has already been used."));
      emit(UserSignUp());
    } else {
      emit(UserSigningUp());
      emit(UserSignUpSuccess());
      emit(UserLogin());
    }
  }

  void getUsersTicket() async {
    if (await userRepository.isLoggedIn()) {
      emit(LoadingTickets());
      List<Ticket> tickets = await userRepository.getUserTickets();
      print(tickets);
      emit(LoadedTickets(tickets));
    }
  }
}
