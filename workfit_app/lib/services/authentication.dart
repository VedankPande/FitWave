import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:workfit_app/services/userData.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  get uid => user.uid;
  get ref => FirebaseDatabase.instance.ref().child('users').child(uid);

  //User Authentication Handler
  Future handleAuth() async {
    try {
      log('user: ' + user.toString());
      if (user != null) {
        await updateUserData(uid);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return false;
    }
  }

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await updateUserData(uid);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }
}
