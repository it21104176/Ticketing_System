import 'package:bus_hub/screens/Studentpass.dart';
import 'package:bus_hub/services/authservice.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  final AuthService _auth = AuthService();
  final String userName;
  final String userEmail;

  StudentProfile({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/profile.png'), // Add your image
                ),
                SizedBox(height: 20),
                Text('Name: $userName', style: TextStyle(fontSize: 20)),
                Text('Email: $userEmail', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.favorite), // Add your icon here
                  title: Text('Your Favorites'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () {
                    // Navigate to the Your Favorites page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.payment), // Add your icon here
                  title: Text('Payments'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () {
                    // Navigate to the Payments page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.location_on), // Add your icon here
                  title: Text('Manage Address'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () {
                    // Navigate to the Manage Address page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.school), // Add your icon here
                  title: Text('Student Pass'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Studentpass(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications), // Add your icon here
                  title: Text('Notification'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () {
                    // Navigate to the Notification page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info), // Add your icon here
                  title: Text('About'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () {
                    // Navigate to the About page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout), // Add your icon here
                  title: Text('Log Out'),
                  trailing: Icon(Icons.chevron_right), // Arrowhead icon
                  onTap: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
