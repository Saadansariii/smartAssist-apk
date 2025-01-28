import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_second.dart';
import 'package:smart_assist/utils/storage.dart';

class LeadFirstStep extends StatefulWidget {
  const LeadFirstStep({Key? key}) : super(key: key);
  @override
  _LeadFirstStepState createState() => _LeadFirstStepState();
}

class _LeadFirstStepState extends State<LeadFirstStep> {
  final Widget _leadSecondStep = const LeadsSecond();
  String? selectedEvent;
  List<String> dropdownItems = [];
  bool isLoading = true;
  // const LeadsSecond({Key? key}) : super(key: key);

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    const String apiUrl = "https://api.smartassistapp.in/api/admin/users/all";

    // Retrieve the token from storage (use the imported method)
    final token =
        await Storage.getToken(); // Assuming getToken is in the Storage class

    if (token == null) {
      print("No token found. Please login.");
      return; // Handle token absence appropriately (e.g., prompt user to log in)
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rows = data['rows'] as List;

        setState(() {
          dropdownItems = rows.map((row) => row['name'] as String).toList();
          isLoading = false;
        });
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print("Error fetching dropdown data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      'Add New Leads',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    textAlign: TextAlign.start,
                    'Assign to',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton<String>(
                        value: selectedEvent,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Select",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: dropdownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                value,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedEvent = value;
                          });
                        },
                      ),
              ),
              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('First name*',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Alex', // Placeholder text
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12), // Padding inside the TextField
                    border: InputBorder.none, // Remove border for custom design
                  ),
                  onChanged: (value) {
                    // Handle text change (optional)
                    print(value);
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Last name*',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity, // Full width text field
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Carter',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: 12), // Placeholder text
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12), // Padding inside the TextField
                    border: InputBorder.none, // Remove border for custom design
                  ),
                  onChanged: (value) {
                    // Handle text change (optional)
                    print(value);
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Email*',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity, // Full width text field
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'AlexCarter@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12), // Padding inside the TextField
                    border: InputBorder.none, // Remove border for custom design
                  ),
                  onChanged: (value) {
                    // Handle text change (optional)
                    print(value);
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Row with Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black, // Cancel button color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close modal on cancel
                        },
                        child: Text('Cancel',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Submit button color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Close the current dialog and open the second dialog
                          Navigator.pop(context); // Close the first dialog
                          Future.microtask(() {
                            // Immediately queue the second dialog to open after the first closes
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                    _leadSecondStep, // Your second modal widget
                              ),
                            );
                          });
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
