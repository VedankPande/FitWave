import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:workfit_app/services/authentication.dart';

Map userData = {};

getUserData() {
  return userData;
}

updateUserData(uid) async {
  final ref = FirebaseDatabase.instance.ref().child('users').child(uid);
  DatabaseEvent event = await ref.once();
  final res = event.snapshot.value;
  userData = jsonDecode(jsonEncode(res));
  userData['uid'] = uid;
  log(userData['username'].toString());
}
