import 'package:flutter/material.dart';

import 'QrUI.dart';

class PaymentSuccessfulUI extends StatelessWidget {
  const PaymentSuccessfulUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary Travel Pass'),
        backgroundColor: Colors.deepPurple, // Change app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Increase font size
                      color: Colors.deepPurple, // Change text color
                    ),
                  ),
                  Text(
                    'Payment Successful',
                    style: TextStyle(
                      fontSize: 20, // Increase font size
                      color: Colors.deepPurple, // Change text color
                    ),
                  ),
                ],
              ),
            ),
      SizedBox(height: 30),

          Center( // Wrap the ElevatedButton with Center
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRScreen(),
                  ),
                );
              },
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
