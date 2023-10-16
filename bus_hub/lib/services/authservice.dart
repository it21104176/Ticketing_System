import 'package:bus_hub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create a user from firebase user with uid
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // create the stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }

  // sign in using anonymous user
  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register using using email & password
  Future registerWithEmailAndPassword(
      String email, String password, String nic, String nicImageUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _createUserProfile(user.uid, email, nic, nicImageUrl);
      }
      return _userWithFirebaseUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future _createUserProfile(
      String uid, String email, String nic, String nicImageUrl) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'nic': nic,
        'nic_image_url': nicImageUrl, // Store the NIC image URL
      });
    } catch (error) {
      print(error.toString());
    }
  }

  // sign in using using email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign up using email & password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
