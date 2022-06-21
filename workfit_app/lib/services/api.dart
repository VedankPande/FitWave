import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:workfit_app/services/userData.dart';

class RestApi {
  final String uid = getUserData()['uid'];
  final String domain = 'http://192.168.29.230:80/';

  getRequest(uri) async {
    try {
      final url = Uri.parse(uri);
      var response = await http.get(url).timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          Fluttertoast.showToast(msg: 'Server Timeout');
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
      log(response.toString());
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  postRequest(uri, body) async {
    try {
      final url = Uri.parse(uri);
      final header = <String, String>{
        'Content-Type': 'application/json',
      };
      log(body.toString());
      var response = await http
          .post(
        url,
        headers: header,
        body: body,
      )
          .timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          Fluttertoast.showToast(msg: 'Server Timeout');
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  fetchWorkout() async {
    final uri = '${domain}workout/$uid';
    final data = await getRequest(uri);
    if (data != null) {
      updateWorkouts(data);
      return data;
    }
    return [];
  }

  fetchExercises() async {
    final uri = '${domain}exercise-data/';
    final data = await getRequest(uri);
    return data ?? [];
  }

  fetchFoods() async {
    final uri = '${domain}calorie-tracker/food/';
    final data = await getRequest(uri);
    return data ?? [];
  }

  postWorkoutSet(workoutName) async {
    final uri = '${domain}workout/';
    final body = jsonEncode(<String, String>{
      'owner': uid.toString(),
      'name': workoutName.toString(),
    });
    final data = await postRequest(uri, body);
    return data ?? [];
  }

  postExercise(workoutId, exerciseId) async {
    final uri = '${domain}exercise-add/';
    final body = jsonEncode(<String, String>{
      'sets': '2',
      'reps': '10',
      'workout_id': workoutId.toString(),
      'exercise_id': exerciseId.toString(),
    });
    final data = await postRequest(uri, body);
    return data ?? [];
  }
}
