import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/app/app.router.dart';
import 'package:movie/services/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _navigationService = locator<NavigationService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signUp() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    _firebaseAuthService.signUpWithEmail(email: email, password: password);
    _navigationService.replaceWithHomeView();
  }

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
