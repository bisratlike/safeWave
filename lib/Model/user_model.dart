class UserModel {
  String username;
  String email;
  String phone;
  String password;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  // Create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
