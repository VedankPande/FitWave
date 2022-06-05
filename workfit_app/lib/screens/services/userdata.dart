import 'package:workfit_app/screens/services/authentication.dart';

String username = '';
Map<String, String> userData = {
  'username': '',
  'uid': '',
};

String getUsername() {
  return userData['username'].toString();
}

updateUsername(username) async {
  userData['username'] = username;
}

String getUid() {
  return userData['uid'].toString();
}

updateUid(uid) async {
  userData['uid'] = uid;
}
