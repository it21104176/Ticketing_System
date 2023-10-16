import 'package:flutter/material.dart';
import 'package:bus_hub/screens/auth/login.dart';
import 'package:bus_hub/screens/auth/register.dart';
import 'package:bus_hub/screens/Studentpass.dart';

class UserTypeSelection extends StatefulWidget {
  @override
  _UserTypeSelectionState createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection> {
  String? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select User Type"),
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "User type",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: Container(),
                    value: selectedUserType,
                    items: [
                      DropdownMenuItem(
                        child: Text("Local"),
                        value: "Local",
                      ),
                      DropdownMenuItem(
                        child: Text("Foreigner"),
                        value: "Foreigner",
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedUserType = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                      },
                      child: Text("Back"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedUserType == "Local") {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                        } else if (selectedUserType == "Foreigner") {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => Studentpass(),
                          ));
                        }
                      },
                      child: Text("Next"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
