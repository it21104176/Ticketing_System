import 'package:flutter/material.dart';
import 'EmailUI.dart';

class ChooseTravelPassUI extends StatefulWidget {
  @override
  _ChooseTravelPassUIState createState() => _ChooseTravelPassUIState();
}

class _ChooseTravelPassUIState extends State<ChooseTravelPassUI> {
  int selectedPrice = -1; // Initialize to -1 to indicate no selection

  final List<String> priceOptions = ['10 (USD)', '20 (USD)', '15 (USD)'];
  final List<int> prices = [10, 20, 15];
  final List<int> credits = [3000, 6000, 4500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temporary Travel Pass'),
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
                    color: index == 2 ? Colors.deepPurpleAccent : Colors.grey[300],
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            const Text(
              'Choose Travel Pass',
              style: TextStyle(
                fontSize: 24, // Increase font size
                fontWeight: FontWeight.bold, // Apply bold font style
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(priceOptions.length, (index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  color: selectedPrice == index
                      ? Colors.deepPurple
                      : Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(26),
                    title: Text(
                      priceOptions[index],
                      style: TextStyle(
                        color: selectedPrice == index ? Colors.white : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text(
                      'Description: Add your description here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepPurple
                      ),
                    ),
                    trailing: Text(
                      'Credits: ${credits[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Radio<int>(
                      value: index,
                      groupValue: selectedPrice,
                      onChanged: (value) {
                        setState(() {
                          selectedPrice = value!;
                        });
                      },
                    ),
                  ),
                );
              }),
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
                  onPressed: selectedPrice != -1
                      ? () {
                    int selectedPassPrice = prices[selectedPrice];
                    int selectedPassCredits = credits[selectedPrice];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailUI(
                          // selectedPassPrice: selectedPassPrice,
                          // selectedPassCredits: selectedPassCredits,
                        ),
                      ),
                    );
                  }
                      : null,
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    ),
                    primary: Colors.deepPurple, // Set the background color to deep purple
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
