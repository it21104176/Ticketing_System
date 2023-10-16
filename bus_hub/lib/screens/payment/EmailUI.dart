
import 'package:bus_hub/screens/payment/paymentUI.dart';
import 'package:flutter/material.dart';

class EmailUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary Travel Pass'),
        backgroundColor: Colors.deepPurple, // Change app bar color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: List.generate(5, (index) {
                return Expanded(
                  child: Container(
                    height: 20,
                    color: index == 3 ? Colors.deepPurple : Colors.grey[300],
                  ),
                );
              }),
            ),
            SizedBox(height: 40),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 28, // Increase font size
                fontWeight: FontWeight.bold, // Apply bold font style
              ),
            ),
            SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email address',
                hintText: 'example@example.com', // Add a hint text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Add border radius
                ),
              ),
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remove Navigator.pop for the "BACK" button
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'BACK',
                    style: TextStyle(
                      fontSize: 16, // Adjust font size
                      fontWeight: FontWeight.bold, // Apply bold font style
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentUI(),
                      ),
                    );
                  },
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16, // Adjust font size
                      fontWeight: FontWeight.bold, // Apply bold font style
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Set the background color to deepPurple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
