// // import 'package:bus_hub/screens/auth/login.dart';
// import 'package:bus_hub/screens/auth/register.dart';
// import 'package:bus_hub/screens/home.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import '../../constants/colors.dart';
// import '../../constants/styles.dart';
// import '../../services/authservice.dart';

// class NewScreen extends StatefulWidget {
//   const NewScreen({Key? key}) : super(key: key);

//   @override
//   State<NewScreen> createState() => _NewScreenState();
// }

// class _NewScreenState extends State<NewScreen> {
//   final AuthService _auth = AuthService();
//   String nic = "";
//   String email = "";
//   String password = "";
//   String confirmPassword = "";
//   String error = "";
//   File? _image;

//   // Function to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadImageAndRegister() async {
//     try {
//       // Check if an image is selected
//       if (_image != null) {
//         // Get a reference to the Firebase Storage bucket
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('profile_pictures/${nic}_profile.jpg');

//         // Upload the image to Firebase Storage
//         final UploadTask uploadTask = storageRef.putFile(_image!);

//         // Get the download URL of the uploaded image
//         final TaskSnapshot taskSnapshot = await uploadTask;
//         final String profilePictureUrl =
//             await taskSnapshot.ref.getDownloadURL();

//         // Register the user with name, email, and profile picture URL
//         dynamic result = await _auth.registerWithEmailAndPassword(
//             nic, email, password, profilePictureUrl);

//         if (result == null) {
//           setState(() {
//             error = "Please enter valid information.";
//           });
//         } else {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Home(),
//             ),
//           );
//         }
//       }
//     } catch (error) {
//       print(error.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload NIC Card"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 child: const Text(
//                   "Upload a photo of your NIC card",
//                   style: descBStyle,
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 child: const Text(
//                   "please upload a clear image",
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               ),
//             ),
//             // Profile picture upload
//             const SizedBox(height: 50),
//             GestureDetector(
//               onTap: _pickImage,
//               child: _image == null
//                   ? Container(
//                       height: 150,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 222, 240, 249),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.cloud_upload,
//                               size: 50,
//                               color: primary,
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Upload document here',
//                               style: TextStyle(
//                                 color: primary,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : Container(
//                       height: 150,
//                       width: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(width: 2, color: secondary),
//                         image: DecorationImage(
//                           image: FileImage(_image!),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//             ),
//             const SizedBox(height: 50),
//             // Button Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => Register(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "Back",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: primary,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (password != confirmPassword) {
//                       setState(() {
//                         error = "Passwords do not match";
//                       });
//                     } else {
//                       _uploadImageAndRegister();
//                     }
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(primary),
//                   ),
//                   child: const Text(
//                     "Next",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
