part of 'ticket_cubit.dart';

@immutable
abstract class TicketState {}

class TicketInitial extends TicketState {}

class TicketStart extends TicketState {}

class UserLoginPrompt extends TicketState {}

class TicketProcessing extends TicketState {}

class TicketProcessed extends TicketState {
  Ticket? ticket;
  TicketProcessed(this.ticket);
}

class TicketError extends TicketState {}
