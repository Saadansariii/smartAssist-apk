import 'dart:convert';
import 'package:http/http.dart' as http;

class LeadsSrv {
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

   
}
