import 'package:app/models/ticket.dart';
import 'package:app/services/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final UserRepository userRepository;
  TicketCubit(this.userRepository) : super(TicketInitial());

  void buyTicket(Ticket ticket) async {
    if (await userRepository.isLoggedIn() == false) {
      emit(UserLoginPrompt());
    } else {
      emit(TicketProcessing());
      Ticket? confirmedTicket =
          await userRepository.createNewUserTicket(ticket);
      emit(TicketProcessed(confirmedTicket));
    }
  }
}
