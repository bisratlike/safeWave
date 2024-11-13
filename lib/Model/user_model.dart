class UserModel {
  String? fullName;
  String? email;
  String? password;

  UserModel({this.fullName, this.email, this.password});

  // Converts a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }

  // Converts a JSON map to a UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
    );
  }
}
