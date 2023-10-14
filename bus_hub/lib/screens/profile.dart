import 'package:bus_hub/screens/Studentpass.dart';
import 'package:bus_hub/services/authservice.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Studentpass(),
                  ),
                );
              },
              child: const Text('Student Pass'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
