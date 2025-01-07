import 'dart:convert';

import 'package:http/http.dart' as http;

const socketEndPoint = 'http://192.168.10.12:5000/api/';

Future<Map<String, dynamic>> fetch(String url) async {
  String URL = socketEndPoint + url;
  final response = await http.get(Uri.parse(URL));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to get data");
  }
}

Future<void> postAPI({
  required String url,
  required Map<String, dynamic> body,
  onSuccess,
  onFailure,
}) async {
  print("Inside the post API function");
  String URL = socketEndPoint + url;
  try {
    final response = await http.post(
      Uri.parse(URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      onSuccess(responseData);
    } else {
      print("Error: ${response.statusCode}, ${response.body}");
      if (onFailure) {
        onFailure();
      } else {
        throw Exception("Failed to get data: ${response.statusCode}");
      }
    }
  } catch (e) {
    print("Error occurred: $e");
    // throw Exception("An error occurred while calling the API: $e");
  }
}
