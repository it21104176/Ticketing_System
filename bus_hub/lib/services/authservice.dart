import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_hub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a user from firebase user with uid
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null
        ? UserModel(uid: user.uid, nic: '', email: '', profilePictureUrl: '')
        : null;
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
  Future registerWithEmailAndPassword(String nic, String email, String password,
      String profilePictureUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'nic': nic,
          'profilePicture': profilePictureUrl,
        });

        return _userWithFirebaseUserUid(user);
      }
    } catch (error) {
      print(error.toString());
      return null;
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
