import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class RestApi {
  final String username = 'shantanu';

  fetchWorkout() async {
    try {
      final uri = 'http://10.0.2.2:8000/workout/' + username;
      var url = Uri.parse(uri);
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
      final uri = 'http://10.0.2.2:8000/exercise-data/';
      var url = Uri.parse(uri);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
