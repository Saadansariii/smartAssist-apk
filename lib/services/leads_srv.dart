import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/utils/storage.dart';

class LeadsSrv {
  final String baseUrl = 'https://api.smartassistapp.in/api/admin';

  // ApiService(this.baseUrl);

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

  // lead assign dropdown service

  // Future<List<String>> fetchDropdownItems() async {
  //   final url = Uri.parse("https://api.smartassistapp.in/api/admin/users/all");
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return List<String>.from(data['items']);
  //   } else {
  //     throw Exception("Failed to load dropdown items");
  //   }
  // }

  // static Future<bool> submitLead(Map<String, dynamic> leadData, leadId) async {
  //   final token = await Storage.getToken();

  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://api.smartassistapp.in/api/admin/leads/create'),
  //       headers: {
  //         'Authorization': 'Bearer $token', // Add the token to the headers
  //         'Content-Type': 'application/json', // Specify JSON content type
  //       },
  //       body: jsonEncode(leadData),
  //     );

  //     print('API Response Status: ${response.statusCode}');
  //     print('API Response Body: ${response.body}');

  //     if (response.statusCode == 201) {
  //       return true; // Successful response
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return false;
  //   }
  // }

  static Future<Map<String, dynamic>?> submitLead(
      Map<String, dynamic> leadData) async {
    const String apiUrl =
        "https://api.smartassistapp.in/api/admin/leads/create";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      return null;
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

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data; // Return the full API response
      } else {
        return null;
      }
    } catch (e) {
      print('Error submitting lead: $e');
      return null;
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

  // single leadsid

  // static Future<Map<String, dynamic>> fetchLeadsById(String leadId) async {
  //   const String apiUrl = "https://api.smartassistapp.in/api/leads/";

  //   final token = await Storage.getToken();
  //   if (token == null) {
  //     print("No token found. Please login.");
  //     throw Exception("No token found. Please login.");
  //   }

  //   try {
  //     // Ensure the actual leadId is being passed correctly
  //     print('Fetching data for Lead ID: $leadId');

  //     final response = await http.get(
  //       Uri.parse('$apiUrl$leadId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //         'leadId': leadId
  //       },
  //     );

  //     // Debug: Print the response status code and body
  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     print('this is the url $Uri');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return data; // Return the response data
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

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

  // static Future<Map<String, dynamic>> singleFollowupsById(String leadId) async {
  //   const String apiUrl = "https://api.smartassistapp.in/api/admin/leads/";

  //   final token = await Storage.getToken();
  //   if (token == null) {
  //     // print("No token found. Please login.");
  //     throw Exception("No token found. Please login.");
  //   }

  //   try {
  //     // Ensure the actual leadId is being passed correctly
  //     // print('Fetching data for Lead ID: $leadId');
  //     // print(
  //     //     'API URL: ${apiUrl + leadId}');

  //     final response = await http.get(
  //       Uri.parse('$apiUrl$leadId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //         'leadId': leadId
  //       },
  //     );

  //     // Debug: Print the response status code and body
  //     // print('Response status code: ${response.statusCode}');
  //     // print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return data;
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

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

  // static Future<List<Map<String, dynamic>>> singleEventById(
  //     String leadId) async {
  //   const String apiUrl =
  //       "https://api.smartassistapp.in/api/admin/leads/events/all/"; //tasks for tasks

  //   final token = await Storage.getToken();
  //   if (token == null) {
  //     print("No token found. Please login.");
  //     throw Exception("No token found. Please login.");
  //   }

  //   try {
  //     print('Fetching data for Lead ID: $leadId');
  //     print('API URL: ${apiUrl + leadId}');

  //     final response = await http.get(
  //       Uri.parse('$apiUrl$leadId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       // ✅ Return the full "rows" array instead of just the first event
  //       if (data.containsKey('rows') && data['rows'] is List) {
  //         return List<Map<String, dynamic>>.from(data['rows']);
  //       } else {
  //         throw Exception("No events found for this Lead ID.");
  //       }
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     throw Exception('Error fetching data: $e');
  //   }
  // }

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

// fetch tasks

  static Future<List<dynamic>> fetchtasks(DateTime selectedDate) async {
    final DateTime finalDate = selectedDate ?? DateTime.now();
    final String formattedDate = DateFormat('dd-MM-yyyy').format(finalDate);
    final String apiUrl =
        'https://api.smartassistapp.in/api/calendar/tasks/all/asondate?date=$formattedDate';
    // https: //api.smartassistapp.in/api/calendar/tasks/all/asondate?date=13-02-2025

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

  // Fetch dashboard data (initial load)
  static Future<Map<String, int>> fetchDashboardData() async {
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
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          'upcomingFollowupsCount': data['upcomingFollowupsCount'] ?? 0,
          'overdueFollowupsCount': data['overdueFollowupsCount'] ?? 0,
          'upcomingAppointmentsCount': data['upcomingAppointmentsCount'] ?? 0,
          'overdueAppointmentsCount': data['overdueAppointmentsCount'] ?? 0,
        };
      } else {
        print("Failed to load dashboard data: ${response.statusCode}");
        return {};
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
      return {};
    }
  }
}
