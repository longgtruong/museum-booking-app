class Ticket {
  final int eventId;
  final int userId;
  final int quantity;
  final String? status;

  Ticket(
      {required this.eventId,
      required this.userId,
      required this.quantity,
      this.status});

  static Ticket fromJson(Map json) => Ticket(
      eventId: json["event_id"],
      userId: json["user_id"],
      quantity: json["quantity" as int],
      status: json["status"]);

  static Map toJson(Ticket ticket) => {
        "event_id": ticket.eventId,
        "user_id": ticket.userId,
        "quantity": ticket.quantity
      };
}
