class Ticket {
  final String? id;
  final String eventId;
  final int quantity;
  final String? status;

  Ticket({this.id, required this.eventId, required this.quantity, this.status});

  static Ticket fromJson(Map json) => Ticket(
      id: json["_id"],
      eventId: json["exhibition_id"],
      quantity: json["quantity"] as int,
      status: json["status"].toString());

  static Map toJson(Ticket ticket) =>
      {"exhibition_id": ticket.eventId, "quantity": ticket.quantity};
}
