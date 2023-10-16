import 'package:flutter/material.dart';



class QRCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Screen"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'MY QR Code',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/images/qrCode.png', width: 200, height: 200),
                const SizedBox(height: 20),
                const Text('Here is your QR code'),
                const SizedBox(height: 40),
              ],
            ),
            const Positioned(
              bottom: 30, // Adjust this value to change the vertical position of the download icon
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.download, // You can use any download icon of your choice
                    color: Colors.deepPurple, // Customize the color as needed
                    size: 30,
                  ),
                  Text(
                    'Download QR',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
