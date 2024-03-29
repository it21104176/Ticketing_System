import 'package:bus_hub/screens/auth/login.dart';
import 'package:bus_hub/screens/auth/register.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool signInPage = true;

  // toggle pages
  void switchPages() {
    setState(() {
      signInPage = !signInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signInPage == true) {
      return Login();
    } else {
      return Register();
    }
  }
}
