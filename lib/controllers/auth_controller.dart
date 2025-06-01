import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:mac_store_app/services/manage_http_response.dart';
import 'package:mac_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:mac_store_app/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      var user = User(
        id: "",
        fullName: fullName,
        email: email,
        state: "",
        city: "",
        locality: "",
        password: password,
        token: "",
      );
      var response = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (!context.mounted) return;
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const LoginScreen(),
            ),
          );
          showSnackBar(context, "Account has been created for you");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (!context.mounted) return;
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (ctx) => const MainScreen(),
            ),
            (route) => false,
          );
          showSnackBar(context, "Logged in");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
