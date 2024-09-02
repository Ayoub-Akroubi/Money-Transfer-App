class UserRegistrationModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;

  UserRegistrationModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
    };
  }
}
