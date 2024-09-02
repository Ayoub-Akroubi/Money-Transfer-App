class UserModel {
  final int userId;
  final String token;
  final String role;

  UserModel({required this.userId, required this.token, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      token: json['token'],
      role: json['role']
    );
  }

  UserModel copyWith({
    int? userId,
    String? email,
    String? token,
    String? role,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }
}
