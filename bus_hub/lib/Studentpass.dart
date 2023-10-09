import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Studentpass(),
  ));
}

class Studentpass extends StatefulWidget {
  @override
  _StudentpassState createState() => _StudentpassState();
}

class _StudentpassState extends State<Studentpass> {
  DateTime? startDate;
  DateTime? endDate;
  String selectedRoute = '138 (Maharagama - Pettah)';
  List<String> routeOptions = [
    '138 (Maharagama - Pettah)',
    '138 (Kottawa - Pettah)',
    '138 (Homagama - Pettah)',
    '122 (Awissawella - Pettah)',
    '177 (Kaduwela - Kollupitiya)'
  ];

  Future<void> _selectStartDate(BuildContext context) async {
    final pickedStartDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedStartDate != null && pickedStartDate != startDate) {
      setState(() {
        startDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final pickedEndDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedEndDate != null && pickedEndDate != endDate) {
      setState(() {
        endDate = pickedEndDate;
      });
    }
  }

  void _navigateToPaymentPage(BuildContext context) {
    // Push a new route to the PaymentPage
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Existing White Card (Bottom 40%)
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).size.height * 0.6,
                  child: Container(
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
                                fontWeight: FontWeight.bold,
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
                ),

                // New White Card (Bottom 40%) for Student Pass Form
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).size.height * 0.09,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
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
                          InkWell(
                            onTap: () {
                              _selectStartDate(context);
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                hintText: 'Select Start Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              child: Text(
                                startDate != null
                                    ? "${startDate!.toLocal()}".split(' ')[0]
                                    : 'Select Start Date',
                                style: TextStyle(fontSize: 16.0),
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
                          InkWell(
                            onTap: () {
                              _selectEndDate(context);
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                hintText: 'Select End Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              child: Text(
                                endDate != null
                                    ? "${endDate!.toLocal()}".split(' ')[0]
                                    : 'Select End Date',
                                style: TextStyle(fontSize: 16.0),
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
                          // DropdownButton for selecting a route
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

                          SizedBox(height: 32.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the PaymentPage
                                _navigateToPaymentPage(context);
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Make Payment'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Details',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Cardholder Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Expiration Date (MM/YY)',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add your logic to process the payment here
                        },
                        child: Text('Make Payment'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


