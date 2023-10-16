import 'package:flutter/material.dart';

class TopUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TopUpScreen(),
    );
  }
}

class TopUpScreen extends StatefulWidget {
  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  TextEditingController _topUpController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Up"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Credits", style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text("LKR. 250.35", style: TextStyle(color: Colors.white, fontSize: 24)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4, // Add elevation for a card-like appearance
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _topUpController,
                      decoration: InputDecoration(labelText: "Top up Amount"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: "Name on card"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _cardNumberController,
                      decoration: InputDecoration(labelText: "Card number"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _expiryController,
                      decoration: InputDecoration(labelText: "Exp. Date"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _cvvController,
                      decoration: InputDecoration(labelText: "CVV"),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle top-up logic here
              },
              child: Text("TOP UP"),
            ),
          ],
        ),
      ),
    );
  }
}
