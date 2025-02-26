import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import Smooth Page Indicator

class CreateFollowupsPopups extends StatefulWidget {
  const CreateFollowupsPopups({super.key});

  @override
  State<CreateFollowupsPopups> createState() => _CreateFollowupsPopupsState();
}

class _CreateFollowupsPopupsState extends State<CreateFollowupsPopups> {
  final PageController _pageController = PageController();
  List<Map<String, String>> dropdownItems = [];
  bool isLoading = false;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    const String apiUrl = "https://api.smartassistapp.in/api/leads/all";
    final token = await Storage.getToken();
    if (token == null) {
      print("No token found. Please login.");
      return;
    }

    try {
      final response = await http
          .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rows = data['rows'] as List;

        setState(() {
          dropdownItems = rows.map((row) {
            return {
              "name": row['lead_name'] as String,
              "id": row['lead_id'] as String,
            };
          }).toList();
        });

        isLoading = false;
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print("Error fetching dropdown data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String? selectedLeads;
  String? selectedSubject;
  String? selectedStatus;
  String? selectedPriority;
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (selectedLeads == null ||
          selectedSubject == null ||
          selectedStatus == null ||
          descriptionController.text.isEmpty) {
        showErrorMessage(context,
            message: 'Please fill all fields before proceeding.');
        return;
      }
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentStep = 1;
      });
    } else {
      submitForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
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
                  child: Text(
                    'Create Followups',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.fontBlack),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // PageView for smooth transition
              SizedBox(
                height: 320, // Adjust height for both steps
                child: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable swipe
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                            label: 'Comments:',
                            controller: descriptionController,
                            hint: 'Enter Comments'),
                        _buildDropdown(
                            label: 'Leads Name:',
                            value: selectedLeads,
                            items: dropdownItems,
                            onChanged: (val) =>
                                setState(() => selectedLeads = val)),
                        _buildDropdown(
                            label: 'Subject:',
                            value: selectedSubject,
                            items: ['Call', 'Provide Quotation', 'Send Email'],
                            onChanged: (val) =>
                                setState(() => selectedSubject = val)),
                        _buildDropdown(
                            label: 'Status:',
                            value: selectedStatus,
                            items: ['Not Started', 'In Progress', 'Completed'],
                            onChanged: (val) =>
                                setState(() => selectedStatus = val)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropdown(
                            label: 'Priority:',
                            value: selectedPriority,
                            items: ['High', 'Normal', 'Low'],
                            onChanged: (val) =>
                                setState(() => selectedPriority = val)),
                        _buildDatePicker(
                            label: 'Followup Date:',
                            controller: dateController,
                            onTap: _pickDate),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // Smooth Indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: const WormEffect(
                  activeDotColor: Colors.black,
                  spacing: 4.0,
                  radius: 10.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                ),
              ),

              const SizedBox(height: 5),

              // Buttons (Next or Submit)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        if (_currentStep == 0) {
                          // If on the first step, close the modal
                          Navigator.pop(context);
                        } else {
                          // If on the second step, go back to the first step
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                          setState(() {
                            _currentStep = 0;
                          });
                        }
                      },
                      child: Text(_currentStep == 0 ? "Cancel" : "Back",
                          style: GoogleFonts.poppins(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorsBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: _nextStep,
                      child: Text(_currentStep == 0 ? "Next" : "Submit",
                          style: GoogleFonts.poppins(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<dynamic> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.fontBlack),
          ),
        ),
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.containerPopBg,
          ),
          child: DropdownButton<String>(
            value: value,
            hint: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Select",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.keyboard_arrow_down_sharp, size: 30),
            ),
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item is String ? item : item['id'].toString(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    item is String ? item : item['name'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.fontBlack),
          ),
        ),
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.containerPopBg,
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              contentPadding: const EdgeInsets.only(left: 10),
              border: InputBorder.none,
            ),
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.fontBlack),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.containerPopBg,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? "Select Date" : controller.text,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          controller.text.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.iconGrey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> submitForm() async {
    String description = descriptionController.text;
    String date = dateController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spId = prefs.getString('user_id');
    // String? leadId = prefs.getString('lead_id');
    String? leadId = selectedLeads!;

    print('Retrieved sp_id: $spId');
    print('Retrieved lead_id: $leadId');

    if (spId == null || leadId.isEmpty) {
      showErrorMessage(context,
          message: 'User ID or Lead ID not found. Please log in again.');
      return;
    }

    // Prepare the lead data
    final newTaskForLead = {
      'subject': selectedSubject,
      'status': selectedStatus,
      'priority': selectedPriority,
      'due_date': dateController.text,
      'comments': descriptionController.text,
      'sp_id': spId,
    };

    print('Lead Data: $newTaskForLead');

    // Pass the leadId to the submitFollowups function
    bool success = await LeadsSrv.submitFollowups(newTaskForLead, leadId);

    if (success) {
      print('Lead submitted successfully!');

      // Close modal if submission is successful
      if (context.mounted) {
        Navigator.pop(context, true); // Closes the modal
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submit Successful.')),
      );
    } else {
      print('Failed to submit lead.');
    }
  }
}
