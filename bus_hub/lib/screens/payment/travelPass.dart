
import 'package:flutter/material.dart';
import 'durationStay.dart';

class TravelPassUI extends StatefulWidget {
  @override
  _TravelPassUIState createState() => _TravelPassUIState();
}

class _TravelPassUIState extends State<TravelPassUI> {
  String dropdownValue = 'Foreigner'; // Initialize with 'Foreigner'
  List<String> userTypes = ['Foreigner', 'Visitors', 'Local', 'Other'];
  bool isUserTypeSelected = false; // Initially set to false
  bool isSubmitting = false; // Track if the form is being submitted

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            const SizedBox(height: 50),
            const Center(
              child: Text(
                'Travel Pass UI',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 50),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 20,
                    color: index == 1 ? Colors.deepPurpleAccent : Colors.grey[300],
                  ),
                );
              }),
            ),
            const SizedBox(height: 70),
            Container(
              width: 300,
              height: 50, // Set the desired height
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple), // Set the border color
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    isUserTypeSelected = true;
                  });
                },
                items: userTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                icon: const Icon(Icons.arrow_drop_down),
                underline: Container(), // Hide the default underline
              ),
            ),

            const SizedBox(height: 80),
            Image.asset('assets/images/Travelpass.png'),
            const SizedBox(height: 110),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isSubmitting = true;
                });
                await Future.delayed(const Duration(seconds: 2));
                setState(() {
                  isSubmitting = false;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DurationOfStayUI(),
                  ),
                );
              },
              child: Text(
                isSubmitting ? 'Submitting...' : 'NEXT',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (isSubmitting)
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
          ],
        ),
      ),
    );
  }
}
