

import 'package:bus_hub/screens/payment/paymentSucessful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import 'constants.dart';


class PaymentUI extends StatelessWidget {
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
                    color: index == 4 ? Colors.deepPurple : Colors.grey[300],
                  ),
                );
              }),
            ),
            SizedBox(height: 40),
            Text(
              'Payment',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        // Add border to the container
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Name on card',
                          border: InputBorder.none, // Remove the default border
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Card number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Exp. Date',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentSuccessfulUI(),
                          ),
                        );
                      },
                      child: Text(
                        'PAY NOW',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        // Set the background color to deepPurple
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the radius as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'BACK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator
                        .of(context)
                        .push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UsePaypal(
                                sandboxMode: true,
                                clientId: Constants.clientId,
                                secretKey: Constants.secretKey,
                                returnURL: Constants.returnURL,
                                cancelURL: Constants.cancelURL,
                                transactions: const [
                                  {
                                    "amount": {
                                      "total": '10.12',
                                      "currency": "USD",
                                      "details": {
                                        "subtotal": '10.12',
                                        "shipping": '0',
                                        "shipping_discount": 0,
                                      },
                                    },
                                    "description": "The payment transaction description.",
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "A demo product",
                                          "quantity": 1,
                                          "price": '10.12',
                                          "currency": "USD",
                                        },
                                      ],
                                      "shipping_address": {
                                        "recipient_name": "Jane Foster",
                                        "line1": "Travis County",
                                        "line2": "",
                                        "city": "Austin",
                                        "country_code": "US",
                                        "postal_code": "73301",
                                        "phone": "+00000000",
                                        "state": "Texas",
                                      },
                                    },
                                  },
                                ],
                                note: "Contact us for any questions on your order.",
                                onSuccess: (Map params) async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaymentSuccessfulUI(),
                                    ),
                                  );
                                },
                                onError: (error) {
                                  print("onError: $error");
                                },
                                onCancel: (params) {
                                  print('cancelled: $params');
                                },
                              ),
                        )
                        );
                    },
                  child: Text(
                    'Pay With PayPal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
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

