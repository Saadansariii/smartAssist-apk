import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/utils/storage.dart';

class LeadsAll extends StatefulWidget {
  const LeadsAll({super.key});

  @override
  State<LeadsAll> createState() => _LeadsAllState();
}

class _LeadsAllState extends State<LeadsAll> {
  bool isLoading = true;
  List<dynamic> leadsList = [];

  @override
  void initState() {
    super.initState();
    fetchLeadsData();
  }

  Future<void> fetchLeadsData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/leads/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          leadsList = data['rows'] ?? []; // Check if 'rows' key exists
          isLoading = false;
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Leads List',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader
          : leadsList.isEmpty
              ? const Center(
                  child: Text(
                    "No Leads Available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : _buildLeadsList(),
    );
  }

  Widget _buildLeadsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: leadsList.length,
      itemBuilder: (context, index) {
        var lead = leadsList[index];
        return _buildLeadItem(lead);
      },
    );
  }

  Widget _buildLeadItem(dynamic lead) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: const Icon(FontAwesomeIcons.user, color: Colors.blue),
        ),
        title: Text(
          lead['name'] ?? 'Unknown',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  lead['due_date'] ?? 'No Date',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.directions_car, size: 14, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  lead['vehicle'] ?? 'Unknown Vehicle',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          // if (lead['lead_id'] != null) {
          //   Navigator.pushNamed(
          //     context,
          //     '/followup-details',
          //     arguments: lead['lead_id'],
          //   );
          // }
        },
      ),
    );
  }
}
