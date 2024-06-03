import 'package:flutter/material.dart';
import 'package:movie/app/app.locator.dart';
import 'package:movie/app/app.router.dart';
import 'package:movie/services/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signIn() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    _firebaseAuthService.signInWithEmail(email: email, password: password);
    _navigatorService.replaceWithHomeView();
  }

  navigateToSignUpView() {
    _navigatorService.navigateToSignUpView();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
