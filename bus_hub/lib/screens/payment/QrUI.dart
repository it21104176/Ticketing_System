
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart';



class QRScreen extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Screen'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QR Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
        ElevatedButton(
          onPressed: () {
            _showQrDialog(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple, // Set the background color to deepPurple
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            ),
          ),
          child: Text(
            'Show QR Code',
            style: TextStyle(
              fontSize: 16, // Adjust font size
              fontWeight: FontWeight.bold, // Apply bold font style
            ),
          ),
        ),


          ],
        ),
      ),
    );
  }

  void _showQrDialog(BuildContext context) {
    String qrData = 'Your_QR_Data_Here';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'QR Code',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                key: qrKey,
                child: BarcodeWidget(data: qrData, barcode: Barcode.qrCode()),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                String email = 'nisu2195@gmail.com'; // Replace with the recipient's email address
                await _sendEmailWithQR(email, qrData);
                Navigator.of(context).pop();
              },
              child: Center(
                child: const Text(
                  'Send via Email',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendEmailWithQR(String recipient, String qrData) async {
    String username = 'nisurar@gmail.com'; // Your Gmail email
    String password = 'tgxu sbow ksye rhmx'; // Your Gmail app-specific password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'BusHub')
      ..recipients.add(recipient)
      ..subject = 'Your QR code'
      ..html = "<h1>Here is your QR code</h1>\n<p>Check the attachment.</p>";

    File imgFile = await captureQRAsImage(qrKey);
    message.attachments.add(FileAttachment(imgFile));

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Message not sent: ' + e.toString());
    }
  }


  Future<File> captureQRAsImage(GlobalKey key) async {
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List buffer = byteData!.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File imgFile = File('$tempPath/qr_code.png');
    await imgFile.writeAsBytes(buffer);
    return imgFile;
  }
}




