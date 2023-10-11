import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class Studentpass extends StatefulWidget {
  @override
  _StudentpassState createState() => _StudentpassState();
}


class _StudentpassState extends State<Studentpass> {
  final TextEditingController _StartdateController = TextEditingController();
  final TextEditingController _EnddateController = TextEditingController();
  final TextEditingController _CardNameController = TextEditingController();
  final TextEditingController _CardNoController = TextEditingController();
  final TextEditingController _ExpDController = TextEditingController();
  final TextEditingController _CvvController = TextEditingController();


  String selectedRoute = '138 (Maharagama - Pettah)';
  List<String> routeOptions = [
    '138 (Maharagama - Pettah)',
    '138 (Kottawa - Pettah)',
    '138 (Homagama - Pettah)',
    '122 (Awissawella - Pettah)',
    '177 (Kaduwela - Kollupitiya)',
  ];

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  bool showPaymentCard = false;

  final CollectionReference _poiCollection = FirebaseFirestore.instance.collection('studentpass');

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
        _StartdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
        _EnddateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // Existing White Card (Bottom 40%)
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                  bottom: Radius.circular(40.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Total Payment',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'LKR 600.00',
                        style: TextStyle(
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'This Payment is valid for 30 days only',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            // New White Card (Bottom 40%) for Student Pass Form
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                  bottom: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Student Pass',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    const Text(
                      'Start Date',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _StartdateController,
                      decoration: InputDecoration(
                        labelText: 'Start Date : ',
                        labelStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectStartDate(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    const Text(
                      'End Date',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _EnddateController,
                      decoration: InputDecoration(
                        labelText: 'Start Date : ',
                        labelStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectEndDate(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    const Text(
                      'Route',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedRoute,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRoute = newValue!;
                        });
                      },
                      items: routeOptions.map((String route) {
                        return DropdownMenuItem<String>(
                          value: route,
                          child: Text(route),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),

                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showPaymentCard = true;
                          });
                        },
                      ),
                    ),
                    // Next Button (to show payment card)
                    SizedBox(height: 50.0),
                    // Payment Card (shown when 'showPaymentCard' is true)
                    if (showPaymentCard)
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40.0),
                            bottom: Radius.circular(40.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Payment Details',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.0),
                              const Text(
                                'Cardholder Name',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                controller: _CardNameController,
                                decoration: InputDecoration(
                                  labelText: 'P.B.N.Nawod',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              const Text(
                                'Card Number',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              TextFormField(
                                controller: _CardNoController,
                                decoration: InputDecoration(
                                  labelText: '0300 xxxx xxxx xx',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Exp. Date ',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        TextFormField(
                                          controller: _ExpDController,
                                          decoration: InputDecoration(
                                            labelText: 'Exp Date (MM/YY)',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CVV',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        TextFormField(
                                          controller: _CvvController,
                                          decoration: InputDecoration(
                                            labelText: '7**',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 32.0),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final String sdate = _StartdateController.text;
                                    final String edate = _EnddateController.text;
                                    final String cname = _CardNameController.text;
                                    final String cno = _CardNoController.text;
                                    final String expd = _ExpDController.text;
                                    final String cvv = _CvvController.text;

                                    if (sdate.isNotEmpty) {
                                      await _poiCollection.add({
                                        "SDate": sdate,
                                        "EDate": edate,
                                        "route": selectedRoute,
                                        "CName":cname,
                                        "CNo":cno,
                                        "CVV":cvv,
                                        "ExpD":expd,
                                      });

                                      _StartdateController.text = '';
                                      _EnddateController.text = '';
                                      _CardNameController.text = '';
                                      _CardNoController.text = '';
                                      _ExpDController.text = '';
                                      _CvvController.text = '';

                                      Navigator.of(context).pop();

                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('You have successfully Created !!! '),
                                      ));

                                      _showPaymentSuccessDialog(context);
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40.0,
              ),
              SizedBox(height: 16.0),
              Text(
                'Payment Successful',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Your payment has been successfully processed.',
            style: TextStyle(fontSize: 16.0),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showQrDialog(context);
              },
              child: const Text(
                'Get QR Code',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showQrDialog(BuildContext context) {
    // Generate the QR code data (you can replace 'QR_DATA' with your actual data)
    String qrData = 'QR_DATA';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'QR Code',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200.0, // Adjust the size of the container as needed
                height: 200.0, // Adjust the size of the container as needed
                child: BarcodeWidget(data: qrData ,barcode: Barcode.qrCode()),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Download',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}





