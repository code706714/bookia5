import 'dart:developer';

import 'package:bookia/core/services/dio/api_endpoints.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/models/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.register,
        data: params.toJson(),
      );
      if (res.statusCode == 201) {
        // Parse Json to object
        var body = res.data;
        var userObj = AuthResponse.fromJson(body);

        SharedPref.saveUserData(userObj.data);
        return userObj;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.login,
        data: params.toJson(),
      );
      if (res.statusCode == 200) {
        // Parse Json to object
        var body = res.data;
        var userObj = AuthResponse.fromJson(body);

        SharedPref.saveUserData(userObj.data);
        return userObj;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
   /* static Future<bool> forgetPassword(String email) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.forgetpassword, // تأكد إن الاسم دا موجود في ApiEndpoints
        data: {
          "email": email,
        },
      );

      if (res.statusCode == 200) {
        // لو الـ API بيرجع success أو message
        log("Forget Password success: ${res.data}");
        return true;
      } else {
        log("Forget Password failed: ${res.statusCode}");
        return false;
      }
    } on Exception catch (e) {
      log("Forget Password error: $e");
      return false;
    }
  }*/
  static Future<String?> forgetPassword(String email) async {
  try {
    var res = await DioProvider.post(
      endpoint: ApiEndpoints.forgetpassword,
      data: {"email": email},
    );

    if (res.statusCode == 200) {
      log("Forget Password success: ${res.data}");
      // استلم كود الـ OTP لو السيرفر بيرجعه
      var otp = res.data['otp']?.toString();
      return otp; // رجع الكود
    } else {
      log("Forget Password failed: ${res.statusCode}");
      return null;
    }
  } on Exception catch (e) {
    log("Forget Password error: $e");
    return null;
  }
}

  static Future<bool> checkForgetPassword({
    required String email,
    required String verifyCode,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.checkForgotPassword,
        data: {
          "email": email,
          "verify_code": verifyCode,
        },
      );

      if (res.statusCode == 200) {
        log("Check Forget Password success: ${res.data}");
        return true;
      } else {
        log("Check Forget Password failed: ${res.statusCode}");
        return false;
      }
    } on Exception catch (e) {
      log("Check Forget Password error: $e");
      return false;
    }
  }
  static Future<bool> resetPassword({
    required String verifyCode,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.resetPassword,
        data: {
          "verify_code": verifyCode,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordConfirmation,
        },
      );

      if (res.statusCode == 200) {
        log("Reset Password success: ${res.data}");
        return true;
      } else {
        log("Reset Password failed: ${res.statusCode}");
        return false;
      }
    } on Exception catch (e) {
      log("Reset Password error: $e");
      return false;
    }
  }

}
