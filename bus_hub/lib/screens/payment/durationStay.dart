import 'package:flutter/material.dart';
import 'chooseTravelPass.dart';

class DurationOfStayUI extends StatefulWidget {
  @override
  _DurationOfStayUIState createState() => _DurationOfStayUIState();
}

class _DurationOfStayUIState extends State<DurationOfStayUI> {
  DateTime? arrivalDate;
  DateTime? departureDate;
  String duration = '';

  TextEditingController arrivalDateController = TextEditingController();
  TextEditingController departureDateController = TextEditingController();

  // Function to calculate the duration between arrival and departure dates
  void calculateDuration() {
    if (arrivalDate != null && departureDate != null) {
      final difference = departureDate!.difference(arrivalDate!);
      setState(() {
        duration = '${difference.inDays} days';
      });
    } else {
      setState(() {
        duration = '';
      });
    }
  }

  @override
  void dispose() {
    arrivalDateController.dispose();
    departureDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary Travel Pass'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            SizedBox(height: 40),
            Text(
              'Duration of Stay',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            // Text fields with borders and date icons for arrival and departure
            buildDateField(
              controller: arrivalDateController,
              labelText: 'Arrival Date',
              icon: Icons.date_range,
              onTap: () => selectDate((date) {
                setState(() {
                  arrivalDate = date;
                  arrivalDateController.text =
                  "${date.toLocal()}".split(' ')[0];
                  calculateDuration();
                });
              }),
            ),
            SizedBox(height: 30),
            buildDateField(
              controller: departureDateController,
              labelText: 'Departure Date',
              icon: Icons.date_range,
              onTap: () => selectDate((date) {
                setState(() {
                  departureDate = date;
                  departureDateController.text =
                  "${date.toLocal()}".split(' ')[0];
                  calculateDuration();
                });
              }),
            ),
            SizedBox(height: 20),
            // Colorful box for duration
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Duration: $duration',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseTravelPassUI(),
                      ),
                    );
                  },
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Widget buildDateField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required void Function() onTap,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      onTap: onTap,
    );
  }

  Future<void> selectDate(void Function(DateTime date) onDateSelected) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      onDateSelected(selectedDate);
    }
  }
}
