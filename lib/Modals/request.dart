import 'dart:convert'; // For handling JSON data
import 'package:http/http.dart' as http;


class Request {
  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('http://api.weatherapi.com/v1/current.json?key=84280640b77b400d9e9190354231612&q=maharashtra&aqi=no&days=5'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      var data = jsonDecode(response.body);
      print(data.runtimeType);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
