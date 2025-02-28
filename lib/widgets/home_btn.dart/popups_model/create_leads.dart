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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateLeads extends StatefulWidget {
  const CreateLeads({super.key});

  @override
  State<CreateLeads> createState() => _CreateLeadsState();
}

class _CreateLeadsState extends State<CreateLeads> {
  final PageController _pageController = PageController();
  List<Map<String, String>> dropdownItems = [];
  bool isLoading = false;
  int _currentStep = 0;

  String? selectedLeads;
  String? selectedSubject;
  String? selectedPriority;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetchDropdownData();
  }

  // Future<void> fetchDropdownData() async {
  //   const String apiUrl = "https://api.smartassistapp.in/api/leads/all";

  //   final token = await Storage.getToken();
  //   if (token == null) {
  //     print("No token found. Please login.");
  //     return;
  //   }

  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final rows = data['rows'] as List;

  //       setState(() {
  //         dropdownItems = rows.map((row) {
  //           return {
  //             "name": row['lead_name'] as String,
  //             "id": row['lead_id'] as String,
  //           };
  //         }).toList();
  //       });

  //       isLoading = false;
  //     } else {
  //       print("Failed with status code: ${response.statusCode}");
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     print("Error fetching dropdown data: $e");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> _pickDate({required bool isStartDate}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
        String formattedDateTime =
            DateFormat('dd/MM/yyyy hh:mm a').format(combinedDateTime);
        setState(() {
          if (isStartDate) {
            startDateController.text = formattedDateTime;
          } else {
            endDateController.text = formattedDateTime;
          }
        });
      }
    }
  }

  void _nextStep() {
    if (_currentStep == 0) {
      // if (selectedLeads == null ||
      //     selectedPriority == null ||
      //     selectedSubject == null ||
      //     startDateController.text.isEmpty) {
      //   showErrorMessage(context,
      //       message: 'Please Fill all fields before Proceeding.');
      //   return;
      // }
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentStep = 1);
    } else {
      submitForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Add New lead', style: AppFont.popupTitle()),
          ),

          SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const WormEffect(
                activeDotColor: AppColors.fontBlack,
                spacing: 4.0,
                radius: 10.0,
                dotWidth: 10.0,
                dotHeight: 10.0,
              )),
          // const SizedBox(height: 5),
          SizedBox(
            height: 350,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                        label: 'First Name',
                        controller: firstNameController,
                        hintText: 'first name',
                        isRequired: true,
                        onChanged: (value) {
                          print("firstName : $value");
                        }),
                    _buildTextField(
                        isRequired: true,
                        label: 'Last Name',
                        controller: lastNameController,
                        hintText: 'Last name',
                        onChanged: (value) {
                          print("lastName : $value");
                        }),
                    _buildTextField(
                        isRequired: true,
                        label: 'Email',
                        controller: emailController,
                        hintText: 'Email',
                        onChanged: (value) {
                          print("email : $value");
                        }),
                    _buildTextField(
                        isRequired: true,
                        label: 'Mobile No',
                        controller: mobileController,
                        hintText: '+91',
                        onChanged: (value) {
                          print("mobile : $value");
                        }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDatePicker(
                        label: 'End Date',
                        controller: endDateController,
                        onTap: () => _pickDate(isStartDate: false)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // SmoothPageIndicator(
          //     controller: _pageController,
          //     count: 2,
          //     effect: const WormEffect(
          //       activeDotColor: Colors.black,
          //       spacing: 4.0,
          //       radius: 10.0,
          //       dotWidth: 10.0,
          //       dotHeight: 10.0,
          //     )),
          // const SizedBox(height: 10),
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
                  child: Text(_currentStep == 0 ? "Continue" : "Submit",
                      style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
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
    required TextEditingController controller,
    required String hintText,
    required String label,
    required ValueChanged<String> onChanged,
    bool isRequired = false, // ✅ Add a flag to indicate if field is required
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.fontBlack,
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  const TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
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
            controller: controller, // Assign the controller
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        )
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
    // Retrieve sp_id from SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    final spId = prefs.getString('user_id');

    // Use the lead id from the dropdown selection.
    if (selectedLeads == null) {
      showErrorMessage(context, message: 'Please select a lead.');
      return;
    }
    final leadId = selectedLeads!;

    // Parse and format the selected dates/times.
    final startDateTime =
        DateFormat('dd/MM/yyyy hh:mm a').parse(startDateController.text);
    final endDateTime =
        DateFormat('dd/MM/yyyy hh:mm a').parse(endDateController.text);
    final formattedStartTime = DateFormat('hh:mm a').format(startDateTime);
    final formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

    if (spId == null || leadId.isEmpty) {
      showErrorMessage(context,
          message: 'User ID or Lead ID not found. Please log in again.');
      return;
    }

    // Prepare the appointment data.
    final appointmentData = {
      'start_date': startDateController.text,
      'end_date': endDateController.text,
      'priority': selectedPriority,
      'start_time': formattedStartTime,
      'end_time': formattedEndTime,
      'subject': selectedSubject,
      'sp_id': spId,
    };

    // Call the service to submit the appointment.
    final success = await LeadsSrv.submitAppoinment(appointmentData, leadId);

    if (success) {
      if (context.mounted) {
        Navigator.pop(context, true); // Close the modal on success.
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submit Successful.')),
      );
    } else {
      showErrorMessage(context, message: 'Failed to submit appointment.');
    }
  }
}
