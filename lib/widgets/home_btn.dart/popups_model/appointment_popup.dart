import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class AppointmentPopup extends StatefulWidget {
  const AppointmentPopup({super.key});

  @override
  State<AppointmentPopup> createState() => _AppointmentPopupState();
}

class _AppointmentPopupState extends State<AppointmentPopup> {
  // final PageController _pageController = PageController();
  List<Map<String, String>> dropdownItems = [];
  bool isLoading = false;
  int _currentStep = 0;

  bool _isLoadingSearch = false;
  String _query = '';
  String? selectedLeads;
  String _selectedSubject = '';
  String? selectedLeadsName;
  String? selectedPriority;

  List<dynamic> _searchResults = [];

  final TextEditingController _searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // fetchDropdownData();
  }

  /// Fetch search results from API
  Future<void> _fetchSearchResults(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isLoadingSearch = true;
    });

    final token = await Storage.getToken();

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.smartassistapp.in/api/search/global?query=$query'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _searchResults = data['suggestions'] ?? [];
        });
      }
    } catch (e) {
      showErrorMessage(context, message: 'Something went wrong..!');
    } finally {
      setState(() {
        _isLoadingSearch = false;
      });
    }
  }

  void _onSearchChanged() {
    final newQuery = _searchController.text.trim();
    if (newQuery == _query) return;

    _query = newQuery;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_query == _searchController.text.trim()) {
        _fetchSearchResults(_query);
      }
    });
  }

  // Future<void> fetchDropdownData() async {
  //   const String apiUrl = "https://api.smartassistapp.in/api/leads/all";
  //   final token = await Storage.getToken();
  //   if (token == null) return;

  //   try {
  //     final response = await http
  //         .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final rows = data['rows'] as List;
  //       setState(() {
  //         dropdownItems = rows
  //             .map((row) => {"name": row['lead_name'], "id": row['lead_id']})
  //             .toList();
  //         isLoading = false;
  //       });
  //     } else {
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     setState(() => isLoading = false);
  //     print("Error fetching dropdown data: $e");
  //   }
  // }

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

  // void _nextStep() {
  //   if (_currentStep == 0) {
  //     if (selectedLeads == null ||
  //         selectedPriority == null ||
  //         _selectedSubject == null ||
  //         startDateController.text.isEmpty) {
  //       showErrorMessage(context,
  //           message: 'Please Fill all fields before Proceeding.');
  //       return;
  //     }
  //     // _pageController.nextPage(
  //     //     duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  //     setState(() => _currentStep = 1);
  //   } else {
  //     submitForm();
  //   }
  // }

  // Future<void> submitForm() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final spId = prefs.getString('user_id');
  //   final leadId = selectedLeads;

  //   if (spId == null || leadId == null) {
  //     showErrorMessage(context,
  //         message: 'User ID or Lead ID not found. Please log in again.');
  //     return;
  //   }

  //   final appointmentData = {
  //     'start_date': startDateController.text,
  //     'end_date': endDateController.text,
  //     'priority': selectedPriority,
  //     'subject': selectedSubject,
  //     'sp_id': spId,
  //   };

  //   final success = await LeadsSrv.submitAppoinment(appointmentData, leadId);

  //   if (success && context.mounted) {
  //     Navigator.pop(context, true);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Form Submit Successful.')));
  //   } else {
  //     showErrorMessage(context, message: 'Failed to submit appointment.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Create Appointment',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      label: 'Start Date',
                      controller: startDateController,
                      onTap: () => _pickDate(isStartDate: true),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Space between the two date pickers
                  Expanded(
                    child: _buildDatePicker(
                      label: 'End Date',
                      controller: endDateController,
                      onTap: () => _pickDate(isStartDate: false),
                    ),
                  ),
                ],
              ),
              // _buildDatePicker(
              //     label: 'Start Date',
              //     controller: startDateController,
              //     onTap: () => _pickDate(isStartDate: true)),
              // _buildDatePicker(
              //     label: 'End Date',
              //     controller: endDateController,
              //     onTap: () => _pickDate(isStartDate: false)),
              const SizedBox(height: 10),
              _buildButtons(
                options: {
                  "Meeting": "Meeting",
                  "Test Drive": "Test Drive",
                  "Showroom appointment": "Showroom appointment",
                },
                groupValue: _selectedSubject,
                label: 'Action:',
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 10),
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
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: AppFont.buttons(context))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorsBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: submitForm,
                  child: Text("Create", style: AppFont.buttons(context)),
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.black,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(5))),
          //         onPressed: () {
          //           if (_currentStep == 0) {
          //             // If on the first step, close the modal
          //             Navigator.pop(context);
          //           } else {
          //             // If on the second step, go back to the first step

          //             setState(() {
          //               _currentStep = 0;
          //             });
          //           }
          //         },
          //         child: Text(_currentStep == 0 ? "Cancel" : "Back",
          //             style: GoogleFonts.poppins(color: Colors.white)),
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     Expanded(
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             backgroundColor: AppColors.colorsBlue,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(5))),
          //         onPressed: _nextStep,
          //         child: Text(_currentStep == 0 ? "Continue" : "Submit",
          //             style: GoogleFonts.poppins(color: Colors.white)),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Lead', style: AppFont.dropDowmLabel(context)),
        const SizedBox(height: 5),
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          child: TextField(
            controller: _searchController,
            onTap: () => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              filled: true,
              alignLabelWithHint: true,
              fillColor: AppColors.containerBg,
              hintText: selectedLeadsName ?? 'Select New Leads',
              hintStyle: AppFont.dropDown(context),
              prefixIcon:
                  const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        if (_isLoadingSearch) const Center(child: CircularProgressIndicator()),
        if (_searchResults.isNotEmpty)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Material(
              elevation: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                // margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          selectedLeads = result['lead_id'];
                          selectedLeadsName = result['lead_name'];
                          _searchController.clear();
                          _searchResults.clear();
                        });
                      },
                      title: Text(result['lead_name'] ?? 'No Name',
                          style: const TextStyle(
                            color: AppColors.fontBlack,
                          )),
                      // subtitle: Text(result['email'] ?? 'No Email'),
                      leading: const Icon(Icons.person),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildButtons({
    required Map<String, String> options, // ✅ Short display & actual value
    required String groupValue,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 5),
            child: Text(label, style: AppFont.dropDowmLabel(context)),
          ),
        ),
        const SizedBox(height: 5),

        // ✅ Wrap ensures buttons move to next line when needed
        Wrap(
          spacing: 10, // Space between buttons
          runSpacing: 10, // Space between lines
          children: options.keys.map((shortText) {
            bool isSelected =
                groupValue == options[shortText]; // ✅ Compare actual value

            return GestureDetector(
              onTap: () {
                onChanged(
                    options[shortText]!); // ✅ Pass actual value on selection
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.black,
                    width: .5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color:
                      isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
                ),
                child: Text(
                  shortText, // ✅ Only show short text
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 5),
      ],
    );
  }

  // Widget _buildDropdown({
  //   required String label,
  //   required String? value,
  //   required List<dynamic> items,
  //   required ValueChanged<String?> onChanged,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 5.0),
  //         child: Text(
  //           label,
  //           style: GoogleFonts.poppins(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //               color: AppColors.fontBlack),
  //         ),
  //       ),
  //       Container(
  //         height: 45,
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(5),
  //           color: AppColors.containerPopBg,
  //         ),
  //         child: DropdownButton<String>(
  //           value: value,
  //           hint: Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               "Select",
  //               style: GoogleFonts.poppins(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.grey),
  //             ),
  //           ),
  //           icon: const Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Icon(Icons.keyboard_arrow_down_sharp, size: 30),
  //           ),
  //           isExpanded: true,
  //           underline: const SizedBox.shrink(),
  //           items: items.map((item) {
  //             return DropdownMenuItem<String>(
  //               value: item is String ? item : item['id'].toString(),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 10.0),
  //                 child: Text(
  //                   item is String ? item : item['name'].toString(),
  //                   style: GoogleFonts.poppins(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w500,
  //                       color: Colors.black),
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: onChanged,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildDatePicker(
  //     {required String label,
  //     required TextEditingController controller,
  //     required VoidCallback onTap}) {
  //   return GestureDetector(
  //       onTap: onTap,
  //       child: TextField(
  //           controller: controller,
  //           readOnly: true,
  //           decoration: InputDecoration(labelText: label)));
  // }

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
              color: const Color.fromARGB(255, 248, 247, 247),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? "Select" : controller.text,
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
                  color: AppColors.fontBlack,
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
      'subject': _selectedSubject,
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
