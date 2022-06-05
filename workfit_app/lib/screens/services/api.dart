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
      final body = jsonEncode(<String, String>{
        'owner': uid.toString(),
        'name': workoutName.toString(),
      });
      log(body);
      var response = await http.post(
        url,
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
