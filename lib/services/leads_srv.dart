import 'dart:convert';
import 'package:http/http.dart' as http;
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

  static Future<bool> submitLead(Map<String, dynamic> leadData, leadId) async {
    final token = await Storage.getToken();

    try {
      final response = await http.post(
        Uri.parse('https://api.smartassistapp.in/api/admin/leads/create'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: jsonEncode(leadData),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true; // Successful response
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
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

  static Future<Map<String, dynamic>> fetchLeadsById(String leadId) async {
    const String apiUrl = "https://api.smartassistapp.in/api/leads/";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      throw Exception("No token found. Please login.");
    }

    try {
      // Ensure the actual leadId is being passed correctly
      print('Fetching data for Lead ID: $leadId');
      print(
          'API URL: ${apiUrl + leadId}'); // Concatenate the leadId with the API URL

      final response = await http.get(
        Uri.parse('$apiUrl$leadId'), // Correct URL with leadId appended
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'leadId': leadId
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
}
