import 'dart:io';

import 'package:dio/dio.dart';

class AuthParams {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  File? image;

  AuthParams({this.name, this.email, this.password, this.confirmPassword});

  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      confirmPassword: json["password_confirmation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "image": MultipartFile.fromFileSync(
        image!.path,
        filename: image!.path.split('/').last,
      ),
    });
  }
}

// String convertIntoBase64(File file) {
// List<int> imageBytes = file.readAsBytesSync();
// String base64File = base64Encode(imageBytes);
// return base64File;
// }
