import 'package:bus_hub/models/user.dart';
import 'package:bus_hub/screens/auth/auth.dart';
import 'package:bus_hub/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the user data that the provider provides
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      // If the user is not authenticated
      return const Auth();
    } else {
      // If the user is authenticated
      return const Navigation(
          initialIndex: 0); // Pass the initial index as needed
    }
  }
}
