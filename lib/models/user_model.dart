class User {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final String? phone;
  final String? bloodGroup;
  final String? userType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.password,
    this.email,
    this.phone,
    this.bloodGroup,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
      userType: json['userType'],
      bloodGroup: json["bloodGroup"] ?? "A+",
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'userType': userType,
      "bloodGroup": bloodGroup,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
