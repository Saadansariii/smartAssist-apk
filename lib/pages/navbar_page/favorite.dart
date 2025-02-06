import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/utils/storage.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http; 

class FavoritePage extends StatefulWidget {
  final String leadId;
  const FavoritePage({super.key, required this.leadId});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedButtonIndex = 0;
  List<Map<String, dynamic>> followupData = [];
  List<Map<String, dynamic>> appointmentData = [];
  List<Map<String, dynamic>> testDriveData = [];
  List<Map<String, dynamic>> opportunityData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load initial data for followups
    fetchFollowupData();
  }

  Future<void> fetchFollowupData() async {
    setState(() => isLoading = true);
    try {
      // Replace with your actual API endpoint
      final response = await fetchData('favourites/follow-ups/all');
      setState(() {
        followupData = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching followup data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchAppointmentData() async {
    setState(() => isLoading = true);
    try {
      final response = await fetchData('/favourites/events/test-drives/all');
      setState(() {
        appointmentData = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching appointment data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchTestDriveData() async {
    setState(() => isLoading = true);
    try {
      final response = await fetchData('/favourites/events/test-drives/all');
      setState(() {
        testDriveData = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching test drive data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchOpportunityData() async {
    setState(() => isLoading = true);
    try {
      final response = await fetchData('/api/opportunities/favorite');
      setState(() {
        opportunityData = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching opportunity data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildDataList(List<Map<String, dynamic>> data) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(
              item['subject'] ?? 'No Subject',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status: ${item['status'] ?? 'N/A'}',
                  style: GoogleFonts.poppins(),
                ),
                Text(
                  'Priority: ${item['priority'] ?? 'N/A'}',
                  style: GoogleFonts.poppins(),
                ),
                Text(
                  'Due Date: ${item['due_date'] ?? 'N/A'}',
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FlexibleButton(
                      title: 'Followups',
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 0;
                          fetchFollowupData();
                        });
                      },
                      decoration: BoxDecoration(
                        border: _selectedButtonIndex == 0
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: GoogleFonts.poppins(
                        color: _selectedButtonIndex == 0
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 3),
                    FlexibleButton(
                      title: 'Appointments',
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 1;
                          fetchAppointmentData();
                        });
                      },
                      decoration: BoxDecoration(
                        border: _selectedButtonIndex == 1
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: GoogleFonts.poppins(
                        color: _selectedButtonIndex == 1
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 3),
                    FlexibleButton(
                      title: 'Test Drive',
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 2;
                          fetchTestDriveData();
                        });
                      },
                      decoration: BoxDecoration(
                        border: _selectedButtonIndex == 2
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: GoogleFonts.poppins(
                        color: _selectedButtonIndex == 2
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 3),
                    FlexibleButton(
                      title: 'Opportunity',
                      onPressed: () {
                        setState(() {
                          _selectedButtonIndex = 3;
                          fetchOpportunityData();
                        });
                      },
                      decoration: BoxDecoration(
                        border: _selectedButtonIndex == 3
                            ? Border.all(color: Colors.blue)
                            : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: GoogleFonts.poppins(
                        color: _selectedButtonIndex == 3
                            ? Colors.blue
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildDataList(_selectedButtonIndex == 0
                ? followupData
                : _selectedButtonIndex == 1
                    ? appointmentData
                    : _selectedButtonIndex == 2
                        ? testDriveData
                        : opportunityData),
          ],
        ),
      ),
    );
  }
}

// Helper function to fetch data from API
 
Future<List<dynamic>> fetchData(String endpoint) async {
  final token = await Storage.getToken();
  if (token == null) {
    throw Exception("No token found. Please login.");
  }

  final response = await http.get(
    Uri.parse('https://api.smartassistapp.in/api/$endpoint'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data != null &&
        data is Map<String, dynamic> &&
        data.containsKey('rows')) {
      return data['rows'] as List<dynamic>;
    } else {
      throw Exception("Invalid response format");
    }
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}

class FlexibleButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final BoxDecoration decoration;
  final TextStyle textStyle;

  const FlexibleButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.decoration,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: decoration,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xffF3F9FF),
          padding: EdgeInsets.symmetric(horizontal: 10),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
