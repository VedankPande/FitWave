import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:workfit_app/screens/services/userdata.dart';

class RestApi {
  final String uid = getUid();
  final String domain = 'http://10.0.2.2:8000/';

  fetchWorkout() async {
    try {
      final uri = '${domain}workout/' + uid;
      final url = Uri.parse(uri);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  fetchExercises() async {
    try {
      final uri = '${domain}exercise-data/';
      final url = Uri.parse(uri);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  postWorkoutSet(workoutName) async {
    try {
      final uri = '${domain}workout/';
      final url = Uri.parse(uri);
      final header = <String, String>{
        'Content-Type': 'application/json',
      };
      final body = jsonEncode(<String, String>{
        'owner': uid.toString(),
        'name': workoutName.toString(),
      });
      log(body.toString());
      var response = await http.post(
        url,
        headers: header,
        body: body,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  postExercise(workoutId, exerciseId) async {
    try {
      final uri = '${domain}exercise-add/';
      final url = Uri.parse(uri);
      final header = <String, String>{
        'Content-Type': 'application/json',
      };
      final body = jsonEncode(<String, String>{
        'sets': '2',
        'reps': '10',
        'workout_id': workoutId.toString(),
        'exercise_id': exerciseId.toString(),
      });
      log(body.toString());
      var response = await http.post(
        url,
        headers: header,
        body: body,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
