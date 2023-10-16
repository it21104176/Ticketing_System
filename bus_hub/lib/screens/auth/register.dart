import 'package:bus_hub/screens/UserTypeSelection.dart';
import 'package:flutter/material.dart';
import 'package:bus_hub/screens/nic_upload.dart';
import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../../services/authservice.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String nic = "";
  String password = "";
  String confirmPassword = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BUSHUB"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text(
                    "User Details",
                    style: descBStyle,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // email
                      TextFormField(
                        decoration: txtInputDeco2,
                        validator: (value) => value?.isEmpty == true
                            ? "Enter a valid email"
                            : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // NIC field
                      TextFormField(
                        decoration: txtInputDeco2.copyWith(labelText: "NIC"),
                        validator: (value) =>
                            value?.isEmpty == true ? "Enter a valid NIC" : null,
                        onChanged: (value) {
                          setState(() {
                            nic = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // password
                      TextFormField(
                        obscureText: true,
                        decoration:
                            txtInputDeco2.copyWith(labelText: "Password"),
                        validator: (value) =>
                            value!.length < 6 ? "Enter a valid password" : null,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password confirmation field
                      TextFormField(
                        obscureText: true,
                        decoration: txtInputDeco2.copyWith(
                            labelText: "Confirm Password"),
                        validator: (value) =>
                            value != password ? "Passwords do not match" : null,
                        onChanged: (value) {
                          setState(() {
                            confirmPassword = value;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 128.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => UserTypeSelection(),
                                  ));
                                },
                                child: Text("Back"),
                              ),
                              // Next button
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NICUpload(
                                          email: email,
                                          password: password,
                                          nic: nic,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text("Next"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
