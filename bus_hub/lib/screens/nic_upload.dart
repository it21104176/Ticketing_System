import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/authservice.dart';

class NICUpload extends StatefulWidget {
  final String email;
  final String password;
  final String nic;

  NICUpload({
    required this.email,
    required this.password,
    required this.nic,
  });

  @override
  _NICUploadState createState() => _NICUploadState();
}

class _NICUploadState extends State<NICUpload> {
  final picker = ImagePicker();
  XFile? _image; // Change PickedFile to XFile
  bool isUploading = false;
  final _auth = AuthService();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future uploadImage() async {
    if (_image == null) {
      // Handle the case where no image is selected.
      return;
    }

    setState(() {
      isUploading = true;
    });

    final firebaseStorage = FirebaseStorage.instance;
    final user = FirebaseAuth.instance.currentUser;
    final ref =
        firebaseStorage.ref().child('user_images/${user!.uid}/nic_image.jpg');

    await ref.putFile(File(_image!.path));

    final imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'nic_image_url': imageUrl,
    });

    dynamic result = await _auth.registerWithEmailAndPassword(
      widget.email,
      widget.password,
      widget.nic,
      imageUrl,
    );

    if (result != null) {
      // Registration successful
      // Navigate to the next screen or perform any other actions.
    } else {
      // Registration failed, handle the error.
      setState(() {
        isUploading = false;
      });
      // You can display an error message or handle the failure as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload NIC Photo"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Upload a photo of ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "your NIC card",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "please upload a clear image",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
              SizedBox(height: 20),
              if (_image != null)
                Image.file(
                  File(_image!.path),
                  width: 200,
                  height: 200,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => pickImage(),
                child: Text("Pick Image"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => uploadImage(),
                child: isUploading
                    ? CircularProgressIndicator()
                    : Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
