import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart'; 

//  class LoginSrv {
//   static Future<Map<String, dynamic>> onLogin(Map body) async {
//     const url = 'https://api.smartassistapp.in/api/login';
//     final uri = Uri.parse(url);

//     try {
//       // Send POST request to the login endpoint
//       final response = await http.post(
//         uri,
//         body: jsonEncode(body),
//         headers: {'Content-Type': 'application/json'},
//       );

//       // Log the response for debugging
//       print('API Status Code: ${response.statusCode}');
//       print('API Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         return {'isSuccess': true, 'data': responseData};
//       } else {
//         final errorData = jsonDecode(response.body);
//         return {'isSuccess': false, 'data': errorData};
//       }
//     } catch (error) {
//       // Log the error and return a failure response
//       print('Error: $error');
//       return {'isSuccess': false, 'error': error.toString()};
//     }
//   }
// }
  

class LoginSrv {
  static Future<Map<String, dynamic>> onLogin(Map body) async {
    const url = 'https://api.smartassistapp.in/api/login';
    final uri = Uri.parse(url);

    try {
      // Send POST request to the login endpoint
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      // Log the response for debugging
      print('API Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String token =
            responseData['token']; // Assuming the token is in the 'token' field

        // Save token in Storage (Hive or SharedPreferences)
        await Storage.saveToken(token);

        return {'isSuccess': true, 'token': token};
      } else {
        final errorData = jsonDecode(response.body);
        return {'isSuccess': false, 'data': errorData};
      }
    } catch (error) {
      // Log the error and return a failure response
      print('Error: $error');
      return {'isSuccess': false, 'error': error.toString()};
    }
  }
}
