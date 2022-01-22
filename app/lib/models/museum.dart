/*
 * Museum data model constructor
*/
class Museum {
  final String? id;
  final String name;
  final String city;
  final double latitude;
  final double longitude;

  Museum(
      {this.id,
      required this.name,
      required this.city,
      required this.latitude,
      required this.longitude});

  static Museum fromJson(Map json) => Museum(
      id: json["_id"],
      name: json["name"],
      city: json["city"],
      latitude: json["latitude"],
      longitude: json["longitude"]);
}
