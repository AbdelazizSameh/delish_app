class UserModel {
  final String name;
  final String email;

  const UserModel({required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(name: map['name'], email: map['email']);
  }
}
