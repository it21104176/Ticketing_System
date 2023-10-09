
import 'package:flutter/material.dart';

import 'Studentpass.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zerone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Studentpass(),
      //home: LoginSignupScreen(),
    );
  }
}