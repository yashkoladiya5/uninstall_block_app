class UserModel {
  String? name;
  String? email;
  String? phone;
  String? status;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phoneNumber'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phone,
      "status": status
    };
  }
}
