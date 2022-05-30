import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  get uid => user.uid;
  get ref => FirebaseDatabase.instance.ref().child('users').child(uid);
  String username = '';

  Future getUsername() async {
    if (username == '') {
      DatabaseEvent event =
          await AuthenticationHelper().ref.child('username').once();
      username = event.snapshot.value.toString();
    }
    return username;
  }

  Future handleAuth() async {
    try {
      print('user: ' + user.toString());
      if (user != null) {
        await getUsername();
        print(username);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.message);
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
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
