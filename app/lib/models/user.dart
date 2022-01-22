class User {
  final String username;
  final String firstName;
  final String lastName;
  final String? password;

  User(
      {required this.username,
      required this.firstName,
      required this.lastName,
      this.password});

  static User fromJson(Map json) => User(
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name']);

  static Map toJson(User user) => {
        "username": user.username,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "password": user.password ?? user.password
      };
}
