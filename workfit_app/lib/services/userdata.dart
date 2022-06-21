import 'dart:convert';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:workfit_app/services/api.dart';

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
  var workoutResponse = await RestApi().fetchWorkout();
  userData['workouts'] = workoutResponse ?? [];
  log(userData['username'].toString());
}

updateWorkouts(data) {
  userData['workouts'] = data ?? [];
}
