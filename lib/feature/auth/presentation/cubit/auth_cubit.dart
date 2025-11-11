import 'dart:developer';
import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  // Controllers & Form Keys
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var verifyCodeController = TextEditingController();
  var newPasswordController = TextEditingController();
  var newPasswordConfirmController = TextEditingController();

  // ========== Register ==========
  register() async {
    emit(AuthLoadingState());

    var params = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    var res = await AuthRepo.register(params);
    if (res != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Registration failed!'));
    }
  }

  // ========== Login ==========
  login() async {
    emit(AuthLoadingState());

    var params = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );

    var res = await AuthRepo.login(params);
    if (res != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Login failed!'));
    }
  }

  // ========== Forget Password ==========
 /* forgetPassword() async {
    emit(AuthLoadingState());

    var email = emailController.text;

    var res = await AuthRepo.forgetPassword(email);
    if (res) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Failed to send reset code!'));
    }
  }*/
  forgetPassword() async {
  emit(AuthLoadingState());
  var email = emailController.text;

  var otp = await AuthRepo.forgetPassword(email);
  if (otp != null) {
    log("OTP received: $otp"); // اطبعه مؤقتًا في الـ console
    emit(AuthSuccessState());
  } else {
    emit(AuthErrorState(message: 'Failed to send reset code!'));
  }
}


  // ========== Check Forget Password ==========
  checkForgetPassword() async {
    emit(AuthLoadingState());

    var email = emailController.text;
    var code = verifyCodeController.text;

    var res = await AuthRepo.checkForgetPassword(
      email: email,
      verifyCode: code,
    );

    if (res) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Invalid or expired verification code!'));
    }
  }

  // ========== Reset Password ==========
  resetPassword() async {
    emit(AuthLoadingState());

    var code = verifyCodeController.text;
    var newPassword = newPasswordController.text;
    var confirmNewPassword = newPasswordConfirmController.text;

    var res = await AuthRepo.resetPassword(
      verifyCode: code,
      newPassword: newPassword,
      newPasswordConfirmation: confirmNewPassword,
    );

    if (res) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Failed to reset password!'));
    }
  }
}
