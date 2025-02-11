import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/pages/calenderPages/tasks/task_appointment_pop.dart';
import 'package:smart_assist/pages/calenderPages/tasks/task_followups_pop.dart';
import 'package:smart_assist/pages/navbar_page/leads.dart';
import 'package:smart_assist/utils/storage.dart';

class AddTaskPopup extends StatefulWidget {
  final DateTime? selectedDate;
  const AddTaskPopup({super.key, this.selectedDate});

  @override
  State<AddTaskPopup> createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  String? selectedEvent;
  String? selectedCustomer;

  List<String> dropdownItems = [];
  bool isLoading = false;

  String? selectedLeads;

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
    print('this is the selected widget ${widget.selectedDate}');
  }

  Future<void> fetchDropdownData() async {
    const String apiUrl = "https://api.smartassistapp.in/api/leads/all";

    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rows = data['rows'] as List;

        print("Extracted Rows: $rows"); // Debug: Ensure rows are extracted

        if (rows.isNotEmpty) {
          // Extract the lead_id from the first row (or any row you need)
          String leadId = rows[0]['lead_id'];
          // storeLeadId(leadId);
        }

        setState(() {
          dropdownItems = rows.map<String>((row) {
            String leadName = row['lead_name'] ??
                "${row['fname'] ?? ''} ${row['lname'] ?? ''}".trim();
            return leadName.isNotEmpty ? leadName : "Unknown"; // Default name
          }).toList();

          isLoading = false;
        });

        print(
            "Dropdown Items: $dropdownItems"); // Debug: Ensure dropdown is populated
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching dropdown data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // Set max width
          child: Column(
            mainAxisSize: MainAxisSize.min, // Keeps height to content size
            children: [
              const Text(
                'Add Task / Event',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Dropdown 1 (Event Type)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Select event / task',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: DropdownButton<String>(
                  value: selectedEvent,
                  hint: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Select",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: <String>['Appointment', 'Followup', 'Test Drive']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child:
                            Text(value, style: const TextStyle(fontSize: 16)),
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

              const SizedBox(height: 20),

              // Dropdown 2 (Customer/Client)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Leads Name :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: const Color.fromARGB(255, 243, 238, 238),
              //   ),
              //   child: isLoading
              //       ? const Center(child: CircularProgressIndicator())
              //       : DropdownButton<String>(
              //           value: selectedLeads,
              //           hint: Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Text(
              //               "Select",
              //               style: GoogleFonts.poppins(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           ),
              //           icon: const Icon(Icons.arrow_drop_down),
              //           isExpanded: true,
              //           underline: const SizedBox.shrink(),
              //           items: dropdownItems.map((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Padding(
              //                 padding: const EdgeInsets.only(left: 10.0),
              //                 child: Text(
              //                   value,
              //                   style: GoogleFonts.poppins(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w500,
              //                     color: Colors.black,
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }).toList(),
              //           onChanged: (value) {
              //             setState(
              //               () {
              //                 selectedLeads = value;
              //               },
              //             );
              //           },
              //         ),
              // ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 243, 238, 238),
                ),
                child: GestureDetector(
                  onTap: () async {
                    final selectedLead = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeadsAll(),
                      ),
                    );

                    // if (selectedLead != null) {
                    //   setState(() {
                    //     selectedLeads = selectedLead; // Update selected lead
                    //   });
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedLeads ??
                              "Select", // Show selected lead or default text
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: selectedLeads != null
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                      ],
                    ),
                  ),
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
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the current dialog
                          Future.microtask(() {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: selectedEvent == 'Appointment'
                                    ? TaskAppointmentPop(
                                        selectedDate: widget.selectedDate ??
                                            DateTime.now(),
                                      )
                                    : selectedEvent == 'Test Drive'
                                        ? TaskFollowupsPop(
                                            selectedDate: widget.selectedDate ??
                                                DateTime
                                                    .now()) //add testdrive here in future
                                        : TaskFollowupsPop(
                                            selectedDate: widget.selectedDate ??
                                                DateTime.now(),
                                          ),
                              ),
                            );
                          });
                        },
                        child: const Text('Next',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
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
