// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_assist/config/component/color/colors.dart';
// import 'package:smart_assist/config/component/font/font.dart';
// import 'package:smart_assist/utils/storage.dart';
// import 'package:smart_assist/services/leads_srv.dart';
// import 'package:smart_assist/utils/snackbar_helper.dart';

// class CreateFollowupsPopups extends StatefulWidget {
//   const CreateFollowupsPopups({super.key});

//   @override
//   State<CreateFollowupsPopups> createState() => _CreateFollowupsPopupsState();
// }

// class _CreateFollowupsPopupsState extends State<CreateFollowupsPopups> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _searchResults = [];
//   bool _isLoadingSearch = false;
//   String _query = '';
//   final PageController _pageController = PageController();
//   bool isLoading = false;
//   int _currentStep = 0;
//   String? selectedLeads;
//   String? selectedLeadsName;
//   String _selectedSubject = '';
//   String? selectedStatus;
//   TextEditingController dateController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchSearchResults(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults.clear();
//       });
//       return;
//     }

//     setState(() {
//       _isLoadingSearch = true;
//     });

//     final token = await Storage.getToken();

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api.smartassistapp.in/api/search/global?query=$query'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         setState(() {
//           _searchResults = data['suggestions'] ?? [];
//         });
//       }
//     } catch (e) {
//       showErrorMessage(context, message: 'Something went wrong..!');
//     } finally {
//       setState(() {
//         _isLoadingSearch = false;
//       });
//     }
//   }

//   void _onSearchChanged() {
//     final newQuery = _searchController.text.trim();
//     if (newQuery == _query) return;

//     _query = newQuery;
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (_query == _searchController.text.trim()) {
//         _fetchSearchResults(_query);
//       }
//     });
//   }

//   Future<void> _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//       });
//     }
//   }

//   void _nextStep() {
//     if (_currentStep == 0) {
//       if (selectedLeads == null ||
//           // _selectedSubject.isEmpty ||
//           // selectedStatus == null ||
//           descriptionController.text.isEmpty) {
//         showErrorMessage(context,
//             message: 'Please fill all fields before proceeding.');
//         submitForm();
//         return;
//       }
//       // _pageController.nextPage(
//       //     duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//       // setState(() {
//       //   _currentStep = 1;
//       // });
//     } else {
//       submitForm();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text('Plan a Followup', style: AppFont.popupTitleBlack()),
//             ),
//             const SizedBox(height: 10),
//             _buildDatePicker(
//                 label: 'Select date:',
//                 controller: dateController,
//                 onTap: _pickDate),
//             const SizedBox(height: 10),
//             _buildSearchField(),
//             // const SizedBox(height: 10),
//             // _SelectedInput(
//             //   label: "Priority:",
//             //   options: ["High"], // Show selectedType
//             // ),
//             const SizedBox(height: 10),
//             _buildRadioGroup(
//               label: 'Action:',
//               options: ['Call', 'Provide Quotation', 'Send Email'],
//               groupValue: _selectedSubject,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedSubject = value;
//                 });
//               },
//             ),
//             _buildTextField(
//                 label: 'Comments:',
//                 controller: descriptionController,
//                 hint: 'Enter Comments'),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                     onPressed: () => Navigator.pop(context),
//                     child: Text("Cancel",
//                         style: GoogleFonts.poppins(color: Colors.white)),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.colorsBlue),
//                     onPressed: _nextStep,
//                     child: Text("Submit",
//                         style: GoogleFonts.poppins(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Choose Lead', style: AppFont.dropDowmLabel()),
//         const SizedBox(height: 5),
//         SizedBox(
//           height: 45,
//           child: TextField(
//             controller: _searchController,
//             textAlignVertical: TextAlignVertical.center,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: AppColors.containerBg,
//               hintText: selectedLeadsName ?? 'Type to search',
//               hintStyle: AppFont.dropDown(),
//               prefixIcon:
//                   const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide.none),
//             ),
//           ),
//         ),
//         if (_isLoadingSearch) const Center(child: CircularProgressIndicator()),
//         if (_searchResults.isNotEmpty)
//           Container(
//             height: 200,
//             margin: const EdgeInsets.only(top: 5),
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(5)),
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = _searchResults[index];
//                 return ListTile(
//                   onTap: () {
//                     setState(() {
//                       selectedLeads = result['lead_id'];
//                       selectedLeadsName = result['lead_name'];
//                       _searchController.clear();
//                       _searchResults.clear();
//                     });
//                   },
//                   title: Text(result['lead_name'] ?? 'No Name'),
//                   subtitle: Text(result['email'] ?? 'No Email'),
//                   leading: const Icon(Icons.person),
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildRadioGroup({
//     required List<String> options,
//     required String groupValue,
//     required String label,
//     required ValueChanged<String> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 10),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
//             child: Text(label, style: AppFont.dropDowmLabel()),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Wrap(
//           spacing: 70,
//           runSpacing: 10,
//           children: options.map((option) {
//             return Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: Radio(
//                     activeColor: AppColors.colorsBlue,
//                     value: option,
//                     groupValue: groupValue,
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     visualDensity: VisualDensity.compact,
//                     onChanged: (value) {
//                       if (value != null) {
//                         onChanged(value);
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   option,
//                   style: AppFont.dropDowmLabel(),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 5),
//       ],
//     );
//   }

//   Widget _SelectedInput({
//     required String label,
//     required List<String> options,
//   }) {
//     return Expanded(
//       // ✅ Ensures equal space in a Row
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 5),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
//             child: Text(label, style: AppFont.dropDowmLabel()),
//           ),
//           const SizedBox(height: 3),
//           Wrap(
//             alignment: WrapAlignment.start,
//             spacing: 10,
//             runSpacing: 10,
//             children: options.map((option) {
//               return Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 constraints: const BoxConstraints(minWidth: 100),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: AppColors.containerBg,
//                 ),
//                 child: Text(option, style: AppFont.dropDown()),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDatePicker({
//     required String label,
//     required TextEditingController controller,
//     required VoidCallback onTap,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // const SizedBox(height: 1),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
//           child: Text(
//             label,
//             style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.fontBlack),
//           ),
//         ),
//         // const SizedBox(height: 2),
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             height: 45,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 // color: AppColors.containerPopBg,
//                 border: Border.all(color: Colors.black)),
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     controller.text.isEmpty ? "DD / MM / YY" : controller.text,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: controller.text.isEmpty
//                           ? AppColors.fontColor
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//                 const Icon(
//                   Icons.calendar_month_outlined,
//                   color: AppColors.iconGrey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Text(
//             label,
//             style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.fontBlack),
//           ),
//         ),
//         Container(
//           height: 45,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: AppColors.containerBg,
//           ),
//           child: TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey),
//               contentPadding: const EdgeInsets.only(left: 10),
//               border: InputBorder.none,
//             ),
//             style: GoogleFonts.poppins(
//                 fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }

//   // Future<void> submitForm() async {
//   //   String description = descriptionController.text;
//   //   String date = dateController.text;

//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String? spId = prefs.getString('user_id');
//   //   // String? leadId = prefs.getString('lead_id');
//   //   String? leadId = selectedLeads!;

//   //   print('Retrieved sp_id: $spId');
//   //   // print('Retrieved lead_id: $leadId');

//   //   if (spId == null || leadId.isEmpty) {
//   //     showErrorMessage(context,
//   //         message: 'User ID or Lead ID not found. Please log in again.');
//   //     return;
//   //   }

//   //   // Prepare the lead data
//   //   final newTaskForLead = {
//   //     'subject': _selectedSubject,
//   //     'status': selectedStatus,
//   //     'priority': 'High',
//   //     'due_date': dateController.text,
//   //     'comments': descriptionController.text,
//   //     'sp_id': spId,
//   //   };

//   //   print('Lead Data: $newTaskForLead');

//   //   // Pass the leadId to the submitFollowups function
//   //   bool success = await LeadsSrv.submitFollowups(newTaskForLead, leadId);

//   //   if (success) {
//   //     print('Lead submitted successfully!');

//   //     // Close modal if submission is successful
//   //     if (context.mounted) {
//   //       Navigator.pop(context, true); // Closes the modal
//   //     }

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Form Submit Successful.')),
//   //     );
//   //   } else {
//   //     print('Failed to submit lead.');
//   //   }
//   // }

//   Future<void> submitForm() async {
//     if (selectedLeads == null) {
//       showErrorMessage(context, message: 'Please select a lead.');
//       return;
//     }

//     final newTaskForLead = {
//       'subject': _selectedSubject,
//       'status': selectedStatus,
//       'due_date': dateController.text,
//       'comments': descriptionController.text,
//       'lead_id': selectedLeads,
//     };

//     bool success =
//         await LeadsSrv.submitFollowups(newTaskForLead, selectedLeads!);
//     if (success) {
//       Navigator.pop(context, true);
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Form Submitted Successfully')));
//     }
//   }
// }

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

class CreateFollowupsPopups extends StatefulWidget {
  const CreateFollowupsPopups({super.key});

  @override
  State<CreateFollowupsPopups> createState() => _CreateFollowupsPopupsState();
}

class _CreateFollowupsPopupsState extends State<CreateFollowupsPopups> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<dynamic> _searchResults = [];
  bool _isLoadingSearch = false;
  String _query = '';
  String? selectedLeads;
  String? selectedLeadsName;
  String _selectedSubject = '';
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  /// Handle search input change
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

  /// Open date picker
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

  /// Submit form
  Future<void> submitForm() async {
    if (selectedLeads == null ||
        _selectedSubject.isEmpty ||
        selectedStatus == '' ||
        dateController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      showErrorMessage(context, message: 'All fields are required.');
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spId = prefs.getString('user_id');

    if (spId == null) {
      showErrorMessage(context,
          message: 'User ID not found. Please log in again.');
      return;
    }

    final newTaskForLead = {
      'subject': _selectedSubject,
      'status': 'Not Started',
      'priority': 'High',
      'due_date': dateController.text,
      'comments': descriptionController.text,
      'sp_id': spId,
      'lead_id': selectedLeads,
    };

    bool success =
        await LeadsSrv.submitFollowups(newTaskForLead, selectedLeads!);

    if (success) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Follow-up submitted successfully!')),
      );
    } else {
      showErrorMessage(context, message: 'Submission failed. Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Plan a Follow-up', style: AppFont.popupTitleBlack()),
            ),
            const SizedBox(height: 10),
            _buildDatePicker(
                label: 'Select date:',
                controller: dateController,
                onTap: _pickDate),
            const SizedBox(height: 10),
            _buildSearchField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _selectedInput(
                  label: "Priority:",
                  options: ["High"],
                ),
              ],
            ),
            _buildRadioGroup(
              label: 'Action:',
              options: ['Call', 'Provide Quotation', 'Send Email'],
              groupValue: _selectedSubject,
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value;
                });
              },
            ),
            _buildTextField(
                label: 'Comments:',
                controller: descriptionController,
                hint: 'Enter Comments'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel", style: AppFont.buttons())),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorsBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: submitForm,
                    child: Text("Submit", style: AppFont.buttons()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _selectedInput({
  //   required String label,
  //   required List<String> options,
  // }) {
  //   return Expanded(
  //     // ✅ Ensures equal space in a Row
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SizedBox(height: 5),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
  //           child: Text(label, style: AppFont.dropDowmLabel()),
  //         ),
  //         const SizedBox(height: 3),
  //         Wrap(
  //           alignment: WrapAlignment.start,
  //           spacing: 10,
  //           runSpacing: 10,
  //           children: options.map((option) {
  //             return Container(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //               constraints: const BoxConstraints(minWidth: 100),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //                 color: AppColors.containerBg,
  //               ),
  //               child: Text(option, style: AppFont.dropDown()),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRadioGroup({
    required List<String> options,
    required String groupValue,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
            child: Text(label, style: AppFont.dropDowmLabel()),
          ),
        ),
        const SizedBox(height: 5),

        // Wrap inside Column for row-wise layout
        Column(
          children: [
            // First row (Two radio buttons)
            Row(
              children: [
                _buildRadioOption(options[0], groupValue, onChanged),
                const SizedBox(
                    width: 20), // Space between first and second button
                _buildRadioOption(options[1], groupValue, onChanged),
              ],
            ),

            // Second row (Third radio button)
            if (options.length > 2) // Show only if there's a third option
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10), // Space before third button
                  child: _buildRadioOption(options[2], groupValue, onChanged),
                ),
              ),
          ],
        ),

        const SizedBox(height: 5),
      ],
    );
  }

  /// Helper function to create each radio button
  Widget _buildRadioOption(
      String option, String groupValue, ValueChanged<String> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          activeColor: AppColors.colorsBlue,
          value: option,
          groupValue: groupValue,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
        const SizedBox(width: 5), // Space between radio and text
        Text(
          option,
          style: AppFont.dropDowmLabel(),
        ),
      ],
    );
  }

  Widget _selectedInput({
    required String label,
    required List<String> options,
  }) {
    return Flexible(
      // Use Flexible instead of Expanded
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
            child: Text(label, style: AppFont.dropDowmLabel()),
          ),
          const SizedBox(height: 3),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: options.map((option) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                constraints: const BoxConstraints(minWidth: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.containerBg,
                ),
                child: Text(option, style: AppFont.dropDown()),
              );
            }).toList(),
          ),
        ],
      ),
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
        // const SizedBox(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.fontBlack),
          ),
        ),
        // const SizedBox(height: 2),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: AppColors.containerPopBg,
                border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? "DD / MM / YY" : controller.text,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: controller.text.isEmpty
                          ? AppColors.fontColor
                          : Colors.black,
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
          height: MediaQuery.of(context).size.height * .055,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.containerBg,
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

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Lead', style: AppFont.dropDowmLabel()),
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
              hintText: selectedLeadsName ?? 'Type to talk',
              hintStyle: AppFont.dropDown(),
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
          Container(
            height: MediaQuery.of(context).size.height * .2,
            // margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
      ],
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:smart_assist/config/component/color/colors.dart';
// import 'package:smart_assist/config/component/font/font.dart';
// import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
// import 'package:smart_assist/utils/storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_assist/services/leads_srv.dart';
// import 'package:smart_assist/utils/snackbar_helper.dart';

// class CreateFollowupsPopups extends StatefulWidget {
//   const CreateFollowupsPopups({super.key});

//   @override
//   State<CreateFollowupsPopups> createState() => _CreateFollowupsPopupsState();
// }

// class _CreateFollowupsPopupsState extends State<CreateFollowupsPopups> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _searchResults = [];
//   bool _isLoadingSearch = false;
//   String _query = '';
//   String selectedLeadsName = '';
//   final PageController _pageController = PageController();
//   List<Map<String, String>> dropdownItems = [];
//   bool isLoading = false;
//   int _currentStep = 0;

//   @override
//   void initState() {
//     super.initState(); 
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchSearchResults(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults.clear();
//       });
//       return;
//     }

//     setState(() {
//       _isLoadingSearch = true;
//     });

//     final token = await Storage.getToken();

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api.smartassistapp.in/api/search/global?query=$query'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         setState(() {
//           _searchResults = data['suggestions'] ?? [];
//         });
//       }
//     } catch (e) {
//       showErrorMessage(context, message: 'Something went wrong..!');
//     } finally {
//       setState(() {
//         _isLoadingSearch = false;
//       });
//     }
//   }

//   void _onSearchChanged() {
//     final newQuery = _searchController.text.trim();
//     if (newQuery == _query) return;

//     _query = newQuery;
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (_query == _searchController.text.trim()) {
//         _fetchSearchResults(_query);
//       }
//     });
//   }

  

//   String? selectedLeads;
//   String _selectedSubject = '';
//   String? selectedStatus;
//   String? selectedPriority;
//   TextEditingController dateController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   Future<void> _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//       });
//     }
//   }

//   void _nextStep() {
//     if (_currentStep == 0) {
//       if (selectedLeads == null ||
//           _selectedSubject == '' ||
//           selectedStatus == null ||
//           descriptionController.text.isEmpty) {
//         showErrorMessage(context,
//             message: 'Please fill all fields before proceeding.');

//         return;
//       }
//     } else {
//       submitForm();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height * 1;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text(
//                     'Plan a Followup',
//                     style: AppFont.popupTitleBlack(),
//                   ),
//                 ),
//               ),
//               // const SizedBox(height: 6),

//               // PageView for smooth transition
//               SizedBox(
//                 height: height * .59,
//                 child: PageView(
//                   controller: _pageController,
//                   physics:
//                       const NeverScrollableScrollPhysics(), // Disable swipe
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildDatePicker(
//                             label: 'Select date:',
//                             controller: dateController,
//                             onTap: _pickDate),

//                         const SizedBox(height: 10),
//                         _buildSearchField(),
//                         // const SizedBox(height: 10),

//                         _buildRadioGroup(
//                           label: 'Action:',
//                           options: ['Call', 'Provide Quotation', 'Send Email'],
//                           groupValue: _selectedSubject,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedSubject = value;
//                             });
//                           },
//                         ),

//                         _selectedInput(
//                           label: "Priority:",
//                           options: ["High"], // Show selectedType
//                         ),

//                         _buildTextField(
//                             label: 'Comments:',
//                             controller: descriptionController,
//                             hint: 'Enter Comments'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 5),

//               // Buttons (Next or Submit)
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5))),
//                       onPressed: () {
//                         if (_currentStep == 0) {
//                           // If on the first step, close the modal
//                           Navigator.pop(context);
//                         } else {
//                           // If on the second step, go back to the first step
//                           _pageController.previousPage(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut);
//                           setState(() {
//                             _currentStep = 0;
//                           });
//                         }
//                       },
//                       child: Text(_currentStep == 0 ? "Cancel" : "Back",
//                           style: GoogleFonts.poppins(color: Colors.white)),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.colorsBlue,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5))),
//                       onPressed: _nextStep,
//                       child: Text("Submit",
//                           style: GoogleFonts.poppins(color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Choose Lead', style: AppFont.dropDowmLabel()),
//         const SizedBox(height: 5),
//         SizedBox(
//           height: 45,
//           child: TextField(
//             controller: _searchController,
//             textAlignVertical: TextAlignVertical.center,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: AppColors.containerBg,
//               hintText: selectedLeadsName ?? 'Type to search',
//               hintStyle: AppFont.dropDown(),
//               prefixIcon:
//                   const Icon(FontAwesomeIcons.magnifyingGlass, size: 15),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide.none),
//             ),
//           ),
//         ),
//         if (_isLoadingSearch) const Center(child: CircularProgressIndicator()),
//         if (_searchResults.isNotEmpty)
//           Container(
//             height: 200,
//             margin: const EdgeInsets.only(top: 5),
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(5)),
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = _searchResults[index];
//                 return ListTile(
//                   onTap: () {
//                     setState(() {
//                       selectedLeads = result['lead_id'];
//                       selectedLeadsName = result['lead_name'];
//                       _searchController.clear();
//                       _searchResults.clear();
//                     });
//                   },
//                   title: Text(result['lead_name'] ?? 'No Name'),
//                   subtitle: Text(result['email'] ?? 'No Email'),
//                   leading: const Icon(Icons.person),
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildRadioGroup({
//     required List<String> options,
//     required String groupValue,
//     required String label,
//     required ValueChanged<String> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 10),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
//             child: Text(label, style: AppFont.dropDowmLabel()),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Wrap(
//           spacing: 70,
//           runSpacing: 10,
//           children: options.map((option) {
//             return Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: Radio(
//                     activeColor: AppColors.colorsBlue,
//                     value: option,
//                     groupValue: groupValue,
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     visualDensity: VisualDensity.compact,
//                     onChanged: (value) {
//                       if (value != null) {
//                         onChanged(value);
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                     width: 5), // ✅ Space between radio button and text
//                 Text(
//                   option,
//                   style: AppFont.dropDowmLabel(),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 5),
//       ],
//     );
//   }

//   Widget _selectedInput({
//     required String label,
//     required List<String> options,
//   }) {
//     return Expanded(
//       // ✅ Ensures equal space in a Row
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 5),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
//             child: Text(label, style: AppFont.dropDowmLabel()),
//           ),
//           const SizedBox(height: 3),
//           Wrap(
//             alignment: WrapAlignment.start,
//             spacing: 10,
//             runSpacing: 10,
//             children: options.map((option) {
//               return Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 constraints: const BoxConstraints(minWidth: 100),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: AppColors.containerBg,
//                 ),
//                 child: Text(option, style: AppFont.dropDown()),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Text(
//             label,
//             style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.fontBlack),
//           ),
//         ),
//         Container(
//           height: 45,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: AppColors.containerBg,
//           ),
//           child: TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey),
//               contentPadding: const EdgeInsets.only(left: 10),
//               border: InputBorder.none,
//             ),
//             style: GoogleFonts.poppins(
//                 fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget _buildDatePicker({
//   //   required String label,
//   //   required TextEditingController controller,
//   //   required VoidCallback onTap,
//   // }) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Padding(
//   //         padding: const EdgeInsets.symmetric(vertical: 5.0),
//   //         child: Text(
//   //           label,
//   //           style: GoogleFonts.poppins(
//   //               fontSize: 14,
//   //               fontWeight: FontWeight.w500,
//   //               color: AppColors.fontBlack),
//   //         ),
//   //       ),
//   //       GestureDetector(
//   //         onTap: onTap,
//   //         child: Container(
//   //           height: 45,
//   //           width: double.infinity,
//   //           decoration: BoxDecoration(
//   //             borderRadius: BorderRadius.circular(8),
//   //             color: AppColors.containerPopBg,
//   //           ),
//   //           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//   //           child: Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               Expanded(
//   //                 child: Text(
//   //                   controller.text.isEmpty ? "Select Date" : controller.text,
//   //                   style: GoogleFonts.poppins(
//   //                     fontSize: 14,
//   //                     fontWeight: FontWeight.w500,
//   //                     color:
//   //                         controller.text.isEmpty ? Colors.grey : Colors.black,
//   //                   ),
//   //                 ),
//   //               ),
//   //               const Icon(
//   //                 Icons.calendar_month_outlined,
//   //                 color: AppColors.iconGrey,
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _buildDatePicker({
//     required String label,
//     required TextEditingController controller,
//     required VoidCallback onTap,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // const SizedBox(height: 1),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
//           child: Text(
//             label,
//             style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.fontBlack),
//           ),
//         ),
//         // const SizedBox(height: 2),
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             height: 45,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 // color: AppColors.containerPopBg,
//                 border: Border.all(color: Colors.black)),
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     controller.text.isEmpty ? "DD / MM / YY" : controller.text,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: controller.text.isEmpty
//                           ? AppColors.fontColor
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//                 const Icon(
//                   Icons.calendar_month_outlined,
//                   color: AppColors.iconGrey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> submitForm() async {
//     String description = descriptionController.text;
//     String date = dateController.text;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? spId = prefs.getString('user_id');
//     // String? leadId = prefs.getString('lead_id');
//     String? leadId = selectedLeads!;

//     print('Retrieved sp_id: $spId');
//     print('Retrieved lead_id: $leadId');

//     if (spId == null || leadId.isEmpty) {
//       showErrorMessage(context,
//           message: 'User ID or Lead ID not found. Please log in again.');
//       return;
//     }

//     // Prepare the lead data
//     final newTaskForLead = {
//       'subject': _selectedSubject,
//       'status': selectedStatus,
//       'priority': 'High',
//       'due_date': dateController.text,
//       'comments': descriptionController.text,
//       'sp_id': spId,
//     };

//     print('Lead Data: $newTaskForLead');

//     // Pass the leadId to the submitFollowups function
//     bool success = await LeadsSrv.submitFollowups(newTaskForLead, leadId);

//     if (success) {
//       print('Lead submitted successfully!');

//       // Close modal if submission is successful
//       if (context.mounted) {
//         Navigator.pop(context, true); // Closes the modal
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Form Submit Successful.')),
//       );
//     } else {
//       print('Failed to submit lead.');
//     }
//   }
// }
