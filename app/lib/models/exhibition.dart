class Exhibition {
  final String? id;
  final String title;
  final int length;
  final String description;
  final String author;
  final String? imageUrl;
  final String museumId;
  final num price;
  final DateTime date;

  Exhibition(
      {this.id,
      required this.title,
      required this.length,
      required this.description,
      required this.author,
      this.imageUrl,
      required this.date,
      required this.museumId,
      required this.price});

  static Exhibition fromJson(Map json) => Exhibition(
      id: json["_id"],
      title: json["title"].toString(),
      length: json["length"] as int,
      description: json["description"].toString(),
      author: json["author"].toString(),
      date: DateTime.parse(json["date"]),
      imageUrl: json["image_url"].toString(),
      museumId: json["museum_id"].toString(),
      price: (json["price"] as num));
}
