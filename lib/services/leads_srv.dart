// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:smart_assist/pages/login/login_page.dart';
// import 'package:smart_assist/utils/storage.dart';
// import 'package:smart_assist/utils/token_manager.dart';

// class LeadsSrv {
//   static const String _baseUrl = 'https://api.smartassistapp.in/api';

//   /// 🔹 **Reusable API Request Method**
//   static Future<http.Response> _sendRequest(
//     String endpoint, {
//     String method = 'GET',
//     Map<String, dynamic>? body,
//     bool isAuthRequired = true,
//   }) async {
//     final token = isAuthRequired ? await Storage.getToken() : null;
//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null) 'Authorization': 'Bearer $token',
//     };

//     Uri url = Uri.parse("$_baseUrl/$endpoint");

//     print("🔹 API Request: $method $url");
//     if (body != null) print("📤 Request Body: ${jsonEncode(body)}");

//     try {
//       late http.Response response;
//       if (method == 'POST') {
//         response =
//             await http.post(url, headers: headers, body: jsonEncode(body));
//       } else if (method == 'PUT') {
//         response =
//             await http.put(url, headers: headers, body: jsonEncode(body));
//       } else {
//         response = await http.get(url, headers: headers);
//       }

//       print("🔹 API Response (${response.statusCode}): ${response.body}");
//       return response;
//     } catch (error) {
//       print("❌ API Error: $error");
//       throw Exception("Failed to connect to the server.");
//     }
//   }

//   /// ✅ **Verify Email**
//   static Future<Map<String, dynamic>> verifyEmail(Map body) async {
//     final response =
//         await _sendRequest('login/verify-email', method: 'POST', body: body);
//     return _processResponse(response);
//   }

//   /// ✅ **Login API**
//   static Future<Map<String, dynamic>> onLogin(Map body) async {
//     final response = await _sendRequest('login', method: 'POST', body: body);
//     final data = _processResponse(response);

//     if (data['isSuccess']) {
//       await Storage.saveToken(data['token']);
//     }
//     return data;
//   }

//   /// ✅ **Set Password**
//   static Future<Map<String, dynamic>> setPassword(Map body) async {
//     final response =
//         await _sendRequest('login/create-pwd', method: 'PUT', body: body);
//     return _processResponse(response);
//   }

//   /// ✅ **Submit Follow-Ups**
//   static Future<bool> submitFollowups(
//       Map<String, dynamic> followupsData, String leadId) async {
//     final response = await _sendRequest(
//       'admin/leads/$leadId/create-task',
//       method: 'POST',
//       body: followupsData,
//     );
//     return response.statusCode == 201;
//   }

//   /// ✅ **Submit Appointment**
//   static Future<bool> submitAppointment(
//       Map<String, dynamic> appointmentData, String leadId) async {
//     final response = await _sendRequest(
//       'admin/records/$leadId/events/create-appointment',
//       method: 'POST',
//       body: appointmentData,
//     );
//     return response.statusCode == 201;
//   }

//   /// ✅ **Fetch Leads By ID**
//   static Future<Map<String, dynamic>> fetchLeadsById(String leadId) async {
//     final response = await _sendRequest('leads/$leadId');
//     return _processResponse(response);
//   }

//   /// ✅ **Fetch Single Follow-Ups By ID**
//   static Future<Map<String, dynamic>> singleFollowupsById(String leadId) async {
//     final response = await _sendRequest('admin/leads/$leadId');
//     return _processResponse(response);
//   }

//   /// ✅ **Fetch Single Event By ID**
//   static Future<List<Map<String, dynamic>>> singleEventById(
//       String leadId) async {
//     final response = await _sendRequest('admin/leads/events/all/$leadId');
//     return _processResponse(response)['allEvents']['rows'] ?? [];
//   }

//   /// ✅ **Fetch Tasks By ID**
//   static Future<List<Map<String, dynamic>>> singleTasksById(
//       String leadId) async {
//     final response = await _sendRequest('admin/leads/tasks/all/$leadId');
//     return _processResponse(response)['allTasks']['rows'] ?? [];
//   }

//   /// ✅ **Fetch Single Appointment By ID**
//   static Future<Map<String, dynamic>> singleAppointmentById(
//       String eventId) async {
//     final response = await _sendRequest('admin/events/$eventId');
//     return _processResponse(response);
//   }

//   /// ✅ **Fetch Appointments**
//   static Future<List<dynamic>> fetchAppointments(DateTime selectedDate) async {
//     final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
//     final response =
//         await _sendRequest('calendar/events/all/asondate?date=$formattedDate');
//     return _processResponse(response)['rows'] ?? [];
//   }

//   /// ✅ **Fetch Tasks**
//   static Future<List<dynamic>> fetchTasks(DateTime selectedDate) async {
//     final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
//     final response =
//         await _sendRequest('calendar/tasks/all/asondate?date=$formattedDate');
//     return _processResponse(response)['rows'] ?? [];
//   }

//   /// ✅ **Fetch Event Counts**
//   static Future<Map<String, int>> fetchCount(DateTime selectedDate) async {
//     final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
//     final response =
//         await _sendRequest('calendar/data-count/asondate?date=$formattedDate');
//     return {
//       'upcomingFollowupsCount': response.body['upcomingFollowupsCount'] ?? 0,
//       'overdueFollowupsCount': response.body['overdueFollowupsCount'] ?? 0,
//       'upcomingAppointmentsCount':
//           response.body['upcomingAppointmentsCount'] ?? 0,
//       'overdueAppointmentsCount':
//           response.body['overdueAppointmentsCount'] ?? 0,
//     };
//   }

//   /// ✅ **Fetch Dashboard Data**
//   static Future<Map<String, dynamic>> fetchDashboardData() async {
//     final response = await _sendRequest('users/dashboard');
//     final data = _processResponse(response);

//     if (response.statusCode == 401) {
//       await TokenManager.clearAuthData();
//       Get.offAll(() => LoginPage(email: '', onLoginSuccess: () {}));
//       throw Exception('Unauthorized. Redirecting to login.');
//     }
//     return data;
//   }

//   /// ✅ **Process API Response (Common)**
//   static Map<String, dynamic> _processResponse(http.Response response) {
//     try {
//       final Map<String, dynamic> data = json.decode(response.body);
//       return response.statusCode == 200
//           ? {'isSuccess': true, 'data': data}
//           : {
//               'isSuccess': false,
//               'message': data['message'] ?? 'Request failed'
//             };
//     } catch (error) {
//       print("❌ Error parsing response: $error");
//       return {'isSuccess': false, 'message': 'Invalid response format'};
//     }
//   }
// }

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:smart_assist/pages/test_drive_pages/verify_otp.dart';
import 'package:smart_assist/services/helper.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/utils/token_manager.dart';

class LeadsSrv {
  final String baseUrl = 'https://api.smartassistapp.in/api/admin';

  // ApiService(this.baseUrl);

  static Future<Map<String, dynamic>> verifyEmail(Map body) async {
    const url = 'https://api.smartassistapp.in/api/login/verify-email';
    final uri = Uri.parse(url);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      // Log the response for debugging
      print('API Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return {'isSuccess': true, 'data': jsonDecode(response.body)};
      } else {
        return {'isSuccess': false, 'data': jsonDecode(response.body)};
      }
    } catch (error) {
      // Log any error that occurs during the API call
      print('Error: $error');
      return {'isSuccess': false, 'error': error.toString()};
    }
  }

  // static Future<Map<String, dynamic>> verifyEmail(Map body) async {
  //   const url = 'https://api.smartassistapp.in/api/login/verify-email';
  //   final uri = Uri.parse(url);

  //   try {
  //     final response = await http.post(
  //       uri,
  //       body: jsonEncode(body),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     // Log the response for debugging
  //     print('API Status Code: ${response.statusCode}');
  //     print('API Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       return {'isSuccess': true, 'data': jsonDecode(response.body)};
  //     } else {
  //       return {'isSuccess': false, 'data': jsonDecode(response.body)};
  //     }
  //   } catch (error) {
  //     // Log any error that occurs during the API call
  //     print('Error: $error');
  //     return {'isSuccess': false, 'error': error.toString()};
  //   }
  // }

  static Future<Map<String, dynamic>> verifyOtp(Map body) async {
    const url = 'https://api.smartassistapp.in/api/login/verify-otp';
    final uri = Uri.parse(url);

    try {
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
        print('Parsed verification response: $responseData');
        return {'isSuccess': true, 'data': responseData};
      } else {
        final errorData = jsonDecode(response.body);
        print('Error verification response: $errorData');
        return {'isSuccess': false, 'data': errorData};
      }
    } catch (error) {
      print('Error during OTP verification: $error');
      return {'isSuccess': false, 'error': error.toString()};
    }
  }
  //   static Future<Map<String, dynamic>> verifyOtp(Map body) async {
  //   const url = 'https://api.smartassistapp.in/api/login/verify-otp';
  //   final uri = Uri.parse(url);

  //   try {
  //     final response = await http.post(
  //       uri,
  //       body: jsonEncode(body),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     // Log the response for debugging
  //     print('API Status Code: ${response.statusCode}');
  //     print('API Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       return {'isSuccess': true, 'data': responseData};
  //     } else {
  //       final errorData = jsonDecode(response.body);
  //       return {'isSuccess': false, 'data': errorData};
  //     }
  //   } catch (error) {
  //     print('Error: $error'); // Log error
  //     return {'isSuccess': false, 'error': error.toString()};
  //   }
  // }

  // login api

  static Future<Map<String, dynamic>> onLogin(Map body) async {
    const url = 'https://api.smartassistapp.in/api/login';
    final uri = Uri.parse(url);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      print('API Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      // Check for success in both HTTP status and response body
      if (response.statusCode == 200 &&
          responseData['status'] == 200 &&
          responseData.containsKey('data')) {
        final data = responseData['data'];
        final String token = data['token'];
        final Map<String, dynamic>? user = data['user'];

        // Save token for subsequent calls.
        await Storage.saveToken(token);

        if (user != null) {
          return {'isSuccess': true, 'token': token, 'user': user};
        } else {
          return {
            'isSuccess': false,
            'message': 'User data missing in response'
          };
        }
      } else {
        // Return the backend error message if available.
        return {
          'isSuccess': false,
          'message': responseData['message'] ?? 'Login failed'
        };
      }
    } catch (error) {
      print('Error: $error');
      return {'isSuccess': false, 'error': error.toString()};
    }
  }

  static Future<Map<String, dynamic>> setPwd(Map body) async {
    const url = 'https://api.smartassistapp.in/api/login/create-pwd';
    final uri = Uri.parse(url);

    try {
      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      // Log the response for debugging
      print('API Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Parsed response data: $responseData');
        return {'isSuccess': true, 'data': responseData};
      } else {
        final errorData = jsonDecode(response.body);
        print('Error response: $errorData');
        return {'isSuccess': false, 'data': errorData};
      }
    } catch (error) {
      // Log any error that occurs during the API call
      print('Error in setPwd: $error');
      return {'isSuccess': false, 'error': error.toString()};
    }
  }

  // static Future<Map<String, dynamic>> setPwd(Map body) async {
  //   const url = 'https://api.smartassistapp.in/api/login/create-pwd';
  //   final uri = Uri.parse(url);

  //   try {
  //     final response = await http.put(
  //       uri,
  //       body: jsonEncode(body),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     // Log the response for debugging
  //     print('API Status Code: ${response.statusCode}');
  //     print('API Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       print(responseData);
  //       return {'isSuccess': true, 'data': responseData};
  //     } else {
  //       final errorData = jsonDecode(response.body);
  //       return {'isSuccess': false, 'data': errorData};
  //     }
  //   } catch (error) {
  //     // Log any error that occurs during the API call
  //     print('Error: $error');
  //     return {'isSuccess': false, 'error': error.toString()};
  //   }
  // }

  static Future<List?> loadFollowups(Map body) async {
    const url = 'https://api.smartassistapp.in/api/admin/leads/all';

    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else {
      return null;
    }
  }

  // lead model api

  static Future<List<String>> fetchDropdownOptions() async {
    const url = 'https://api.smartassistapp.in/api/admin/users/all';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Assuming the API response is a list of strings:
        // Example: { "options": ["Option 1", "Option 2", "Option 3"] }

        return List<String>.from(data['options']);
      } else {
        throw Exception('Failed to fetch options');
      }
    } catch (error) {
      print('Error fetching options: $error');
      return [];
    }
  }

  static Future<Map<String, dynamic>?> submitLead(
      Map<String, dynamic> leadData) async {
    const String apiUrl =
        "https://api.smartassistapp.in/api/admin/leads/create";

    final token = await Storage.getToken();
    if (token == null) {
      return {"error": "No token found. Please login."};
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(leadData),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        return responseData;
      } else {
        return {"error": responseData['error'] ?? "Failed."};
      }
    } catch (e) {
      return {"error": "An error occurred: $e"};
    }
  }

// create followups

  static Future<bool> submitFollowups(
      Map<String, dynamic> followupsData, String leadId) async {
    final token = await Storage.getToken();

    // Debugging: print the headers and body
    print('Headers: ${{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'recordId': leadId,
    }}');

    print('Request body: ${jsonEncode(followupsData)}');

    try {
      final response = await http.post(
        Uri.parse(
            'https://api.smartassistapp.in/api/admin/leads/$leadId/create-task'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'recordId': leadId,
        },
        body: jsonEncode(followupsData),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      //  final followupsData = json.decode(response.body);

      if (response.statusCode == 201) {
        return true; // Task created successfully
      } else {
        // Handle unexpected error responses
        print('Error: ${response.statusCode}');
        print('Error details: ${response.body}');
        return false;
      }
    } catch (e) {
      // Catch any network or other errors
      print('Error: $e');
      return false;
    }
  }

// create appoinment

  static Future<bool> submitAppoinment(
      Map<String, dynamic> followupsData, String leadId) async {
    final token = await Storage.getToken();

    // Debugging: print the headers and body
    print('Headers: ${{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'recordId': leadId,
    }}');
    print('Request body: ${jsonEncode(followupsData)}');

    try {
      final response = await http.post(
        // Uri.parse(
        //     'https://api.smartassistapp.in/api/admin/leads/$leadId/create-appointment'),
        Uri.parse(
            'https://api.smartassistapp.in/api/admin/records/$leadId/events/create-appointment'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'recordId': leadId,
        },
        body: jsonEncode(followupsData),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true; // Task created successfully
      } else {
        // Handle unexpected error responses
        print('Error: ${response.statusCode}');
        print('Error details: ${response.body}');
        return false;
      }
    } catch (e) {
      // Catch any network or other errors
      print('Error: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> fetchLeadsById(String leadId) async {
    const String apiUrl = "https://api.smartassistapp.in/api/leads/";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      throw Exception("No token found. Please login.");
    }

    try {
      // Debug: Print the full URL with leadId
      final fullUrl = Uri.parse('$apiUrl$leadId');
      print('Fetching data from URL: $fullUrl');

      final response = await http.get(
        fullUrl, // Use the full URL
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'leadId':
              leadId, // This header is not needed unless the API requires it
        },
      );

      // Debug: Print response details
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Return the response data
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  static Future<Map<String, dynamic>> singleFollowupsById(String leadId) async {
    const String apiUrl = "https://api.smartassistapp.in/api/admin/leads/";

    final token = await Storage.getToken();
    if (token == null) {
      // print("No token found. Please login.");
      throw Exception("No token found. Please login.");
    }

    try {
      // Ensure the actual leadId is being passed correctly
      // print('Fetching data for Lead ID: $leadId');
      // print(
      //     'API URL: ${apiUrl + leadId}');

      final response = await http.get(
        Uri.parse('$apiUrl$leadId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'leadId': leadId
        },
      );

      // Debug: Print the response status code and body
      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

// history data api

  static Future<List<Map<String, dynamic>>> singleEventById(
      String leadId) async {
    const String apiUrl =
        "https://api.smartassistapp.in/api/admin/leads/events/all/";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      throw Exception("No token found. Please login.");
    }

    try {
      print('Fetching data for Lead ID: $leadId');
      print('API URL: ${apiUrl + leadId}');

      final response = await http.get(
        Uri.parse('$apiUrl$leadId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Handle the nested structure with allEvents.rows
        if (data.containsKey('allEvents') &&
            data['allEvents'] is Map<String, dynamic> &&
            data['allEvents'].containsKey('rows')) {
          return List<Map<String, dynamic>>.from(data['allEvents']['rows']);
        } else {
          return []; // Return empty list if no events found
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> singleTasksById(
      String leadId) async {
    const String apiUrl =
        "https://api.smartassistapp.in/api/admin/leads/tasks/all/";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      throw Exception("No token found. Please login.");
    }

    try {
      print('Fetching data for Lead ID: $leadId');
      print('API URL: ${apiUrl + leadId}');

      final response = await http.get(
        Uri.parse('$apiUrl$leadId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Handle the nested structure with allEvents.rows
        if (data.containsKey('allTasks') &&
            data['allTasks'] is Map<String, dynamic> &&
            data['allTasks'].containsKey('rows')) {
          return List<Map<String, dynamic>>.from(data['allTasks']['rows']);
        } else {
          return []; // Return empty list if no events found
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

//
  static Future<Map<String, dynamic>> singleAppointmentById(
      String eventId) async {
    const String apiUrl = "https://api.smartassistapp.in/api/admin/events/";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      throw Exception("No token found. Please login.");
    }

    try {
      // Ensure the actual leadId is being passed correctly
      print('Fetching data for Lead ID: $eventId');
      print(
          'API URL: ${apiUrl + eventId}'); // Concatenate the leadId with the API URL

      final response = await http.get(
        Uri.parse('$apiUrl$eventId'), // Correct URL with leadId appended
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'eventId': eventId
        },
      );

      // Debug: Print the response status code and body
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Return the response data
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  // Fetch appointments (tasks) for a selected date
  static Future<List<dynamic>> fetchAppointments(DateTime selectedDate) async {
    final DateTime finalDate = selectedDate ?? DateTime.now();
    final String formattedDate = DateFormat('dd-MM-yyyy').format(finalDate);
    final String apiUrl =
        'https://api.smartassistapp.in/api/calendar/events/all/asondate?date=$formattedDate';

    final token = await Storage.getToken();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        print("Error: ${response.statusCode}");
        final Map<String, dynamic> data = json.decode(response.body);
        print("Total Appointments Fetched: ${data['rows']?.length}");
        return data['rows'] ?? [];
      } else {
        print("Error: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error fetching appointments: $error");

      return [];
    }
  }

// fetch tasks change the url calendar

  static Future<List<dynamic>> fetchtasks(DateTime selectedDate) async {
    final DateTime finalDate = selectedDate ?? DateTime.now();
    final String formattedDate = DateFormat('dd-MM-yyyy').format(finalDate);
    final String apiUrl =
        'https://api.smartassistapp.in/api/calendar/tasks/all/asondate?date=$formattedDate';

    final token = await Storage.getToken();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        print("Error: ${response.statusCode}");
        final Map<String, dynamic> data = json.decode(response.body);
        return data['rows'] ?? [];
      } else {
        print("Error: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error fetching appointments: $error");

      return [];
    }
  }

  // Fetch event counts for a selected date
  static Future<Map<String, int>> fetchCount(DateTime selectedDate) async {
    final String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final String apiUrl =
        'https://api.smartassistapp.in/api/calendar/data-count/asondate?date=$formattedDate';
    print("Calling API for count on: $formattedDate");
    final token = await Storage.getToken();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          'upcomingFollowupsCount': data['upcomingFollowupsCount'] ?? 0,
          'overdueFollowupsCount': data['overdueFollowupsCount'] ?? 0,
          'upcomingAppointmentsCount': data['upcomingAppointmentsCount'] ?? 0,
          'overdueAppointmentsCount': data['overdueAppointmentsCount'] ?? 0,
        };
      } else {
        print('API Error: ${response.statusCode}');
        return {};
      }
    } catch (error) {
      print("Error fetching event counts: $error");
      return {};
    }
  }

  static Future<Map<String, dynamic>> fetchDashboardData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // Dashboard data is nested under "data"
        final Map<String, dynamic> data = jsonResponse['data'];
        return data;
      } else {
        // Decode the error response
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to load dashboard data';
        print("Failed to load data: $errorMessage");

        // Check if unauthorized: status 401 or error message includes "unauthorized"
        if (response.statusCode == 401 ||
            errorMessage.toLowerCase().contains("unauthorized")) {
          await TokenManager.clearAuthData();
          // Navigate to the login page using GetX
          Get.offAll(() => LoginPage(email: '', onLoginSuccess: () {}));
          throw Exception('Unauthorized. Redirecting to login.');
        } else {
          throw Exception(errorMessage);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
