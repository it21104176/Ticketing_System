import 'package:bus_hub/screens/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../../services/authservice.dart';
import '../UserTypeSelection.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String nic = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String error = "";
  File? _image;
  int _currentStep = 0;

  _RegisterState() {
    // Initialize the AuthService and ImagePicker as Singleton instances
    _auth = AuthService();
    _imagePicker = ImagePicker();
  }

  late AuthService _auth;
  late ImagePicker _imagePicker;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageAndRegister() async {
    try {
      // Check if an image is selected
      if (_image != null) {
        // Get a reference to the Firebase Storage bucket
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${nic}_profile.jpg');

        // Upload the image to Firebase Storage
        final UploadTask uploadTask = storageRef.putFile(_image!);

        // Get the download URL of the uploaded image
        final TaskSnapshot taskSnapshot = await uploadTask;
        final String profilePictureUrl =
            await taskSnapshot.ref.getDownloadURL();

        // Register the user with name, email, and profile picture URL
        dynamic result = await _auth.registerWithEmailAndPassword(
            nic, email, password, profilePictureUrl);

        if (result == null) {
          setState(() {
            error = "Please enter valid information.";
          });
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        }
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Stepper(
        type: StepperType.horizontal, // Horizontal stepper
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            // Validate user details and move to the next step if valid
            if (_formKey.currentState?.validate() == true) {
              setState(() {
                _currentStep++;
              });
            }
          } else if (_currentStep == 1) {
            // Upload image and register
            if (password != confirmPassword) {
              setState(() {
                error = "Passwords do not match";
              });
            } else {
              _uploadImageAndRegister();
            }
          }
        },
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--; // Go back to the previous step
            });
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserTypeSelection(),
              ),
            );
          }
        },
        steps: [
          Step(
            title: Text("User Details"),
            content: Column(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email input field
                      TextFormField(
                        decoration: txtInputDeco2.copyWith(labelText: "Email"),
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
                      // NIC input field
                      TextFormField(
                        decoration: txtInputDeco2.copyWith(labelText: "NIC"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your NIC";
                          }
                          // Remove any spaces or non-alphanumeric characters
                          value = value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

                          if (value.length == 12) {
                            // Validate the 12-digit NIC format
                            if (RegExp(r'^\d{12}$').hasMatch(value)) {
                              return null; // Valid 12-digit NIC
                            }
                          } else if (value.length == 10) {
                            // Validate the 10-character NIC format with 'v' or 'V' as the last character
                            if (RegExp(r'^\d{9}[vV]$').hasMatch(value)) {
                              return null; // Valid 9-digit NIC with 'v' or 'V'
                            }
                          }
                          return "Enter a valid NIC (12 digits or 9 digits with 'v' or 'V')";
                        },
                        onChanged: (value) {
                          setState(() {
                            nic = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password input field
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
                      // Confirm Password input field
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
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 0,
          ),
          Step(
            title: Text("Upload NIC Photo"),
            content: Column(
              children: [
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      "Upload a photo of your NIC card",
                      style: descBStyle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      "please upload a clear image",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                // Profile picture upload
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Container(
                          height: 150,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 240, 249),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  size: 50,
                                  color: primary,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Upload document here',
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 150,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: secondary),
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 50),
                // Button Row
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     OutlinedButton(
                //       onPressed: () {
                //         Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => UserTypeSelection(),
                //           ),
                //         );
                //       },
                //       child: const Text(
                //         "Back",
                //         style: TextStyle(
                //           fontSize: 18,
                //           color: primary,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () async {
                //         if (password != confirmPassword) {
                //           setState(() {
                //             error = "Passwords do not match";
                //           });
                //         } else {
                //           _uploadImageAndRegister();
                //         }
                //       },
                //       style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all(primary),
                //       ),
                //       child: const Text(
                //         "Next",
                //         style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.white,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            isActive: _currentStep == 1,
          ),
        ],
      ),
    );
  }
}
