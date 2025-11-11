import 'user.dart';

class UserModel {
  User? user;
  String? token;

  UserModel({this.user, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {'user': user?.toJson(), 'token': token};
}
