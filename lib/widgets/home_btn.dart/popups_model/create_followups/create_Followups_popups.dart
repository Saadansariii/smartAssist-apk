import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
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
  List<dynamic> _searchResults = [];
  bool _isLoadingSearch = false;
  String _query = '';
  final PageController _pageController = PageController();
  bool isLoading = false;
  int _currentStep = 0;
  String? selectedLeads;
  String? selectedLeadsName;
  String _selectedSubject = '';
  String? selectedStatus;
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
          _selectedSubject.isEmpty ||
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Plan a Followup', style: AppFont.popupTitleBlack()),
            ),
            const SizedBox(height: 10),
            _buildDatePicker(
                label: 'Select date:',
                controller: dateController,
                onTap: _pickDate),
            const SizedBox(height: 10),
            _buildSearchField(),
            const SizedBox(height: 10),
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorsBlue),
                    onPressed: _nextStep,
                    child: Text("Submit",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Lead', style: AppFont.dropDowmLabel()),
        const SizedBox(height: 5),
        SizedBox(
          height: 45,
          child: TextField(
            controller: _searchController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.containerBg,
              hintText: selectedLeadsName ?? 'Type to search',
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
            height: 200,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  onTap: () {
                    setState(() {
                      selectedLeads = result['lead_id'];
                      selectedLeadsName = result['lead_name'];
                      _searchController.clear();
                      _searchResults.clear();
                    });
                  },
                  title: Text(result['lead_name'] ?? 'No Name'),
                  subtitle: Text(result['email'] ?? 'No Email'),
                  leading: const Icon(Icons.person),
                );
              },
            ),
          ),
      ],
    );
  }

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
        Wrap(
          spacing: 70,
          runSpacing: 10,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
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
                ),
                const SizedBox(
                    width: 5), // ✅ Space between radio button and text
                Text(
                  option,
                  style: AppFont.dropDowmLabel(),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _SelectedInput({
    required String label,
    required List<String> options,
  }) {
    return Expanded(
      // ✅ Ensures equal space in a Row
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
                constraints: const BoxConstraints(minWidth: 100),
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
          height: 45,
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

  Future<void> submitForm() async {
    if (selectedLeads == null) {
      showErrorMessage(context, message: 'Please select a lead.');
      return;
    }

    final newTaskForLead = {
      'subject': _selectedSubject,
      'status': selectedStatus,
      'due_date': dateController.text,
      'comments': descriptionController.text,
      'lead_id': selectedLeads,
    };

    bool success =
        await LeadsSrv.submitFollowups(newTaskForLead, selectedLeads!);
    if (success) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form Submitted Successfully')));
    }
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
//   final PageController _pageController = PageController();
//   List<Map<String, String>> dropdownItems = [];
//   bool isLoading = false;
//   int _currentStep = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdownData();
//   }

//   Future<void> fetchDropdownData() async {
//     const String apiUrl = "https://api.smartassistapp.in/api/leads/all";
//     final token = await Storage.getToken();
//     if (token == null) {
//       print("No token found. Please login.");
//       return;
//     }

//     try {
//       final response = await http
//           .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final rows = data['rows'] as List;

//         setState(() {
//           dropdownItems = rows.map((row) {
//             return {
//               "name": row['lead_name'] as String,
//               "id": row['lead_id'] as String,
//             };
//           }).toList();
//         });

//         isLoading = false;
//       } else {
//         print("Failed with status code: ${response.statusCode}");
//         throw Exception('Failed to fetch data');
//       }
//     } catch (e) {
//       print("Error fetching dropdown data: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
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

//   // void _nextStep() {
//   //   if (_currentStep == 0) {
//   //     if (selectedLeads == null ||
//   //         selectedSubject == null ||
//   //         selectedStatus == null ||
//   //         descriptionController.text.isEmpty) {
//   //       showErrorMessage(context,
//   //           message: 'Please fill all fields before proceeding.');
//   //       return;
//   //     }
//   //     _pageController.nextPage(
//   //         duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//   //     setState(() {
//   //       _currentStep = 1;
//   //     });
//   //   } else {
//   //     submitForm();
//   //   }
//   // }

//   void _nextStep() {
//     if (_currentStep == 0) {
//       if (selectedLeads == null ||
//           _selectedSubject == '' ||
//           selectedStatus == null ||
//           descriptionController.text.isEmpty) {
//         showErrorMessage(context,
//             message: 'Please fill all fields before proceeding.');
//         submitForm();
//         return;
//       }
//       _pageController.nextPage(
//           duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//       setState(() {
//         _currentStep = 1;
//       });
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
//                 height: height * .51,
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

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(5.0, 10, 0, 5),
//                             child: Text('Choose Lead',
//                                 style: AppFont.dropDowmLabel()),
//                           ),
//                         ),
//                         const SizedBox(height: 1),
//                         SizedBox(
//                           height: 45,
//                           child: TextField(
//                             controller: _searchController,
//                             textAlignVertical: TextAlignVertical.center,
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     5), // Keep border radius small
//                                 borderSide: BorderSide.none,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     5), // Match with enabledBorder
//                                 borderSide: BorderSide.none,
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 10),
//                               filled: true,
//                               fillColor: AppColors.containerBg,
//                               hintText: 'Type to talk',
//                               hintStyle: AppFont.dropDown(),
//                               prefixIcon: const Icon(
//                                 FontAwesomeIcons.magnifyingGlass,
//                                 color: AppColors.fontColor,
//                                 size: 15,
//                               ),
//                               // suffixIcon: const Icon(
//                               //   FontAwesomeIcons.microphone,
//                               //   color: AppColors.fontColor,
//                               //   size: 15,
//                               // ),
//                             ),
//                           ),
//                         ),

//                         if (_isLoadingSearch || _searchResults.isNotEmpty)
//                           Positioned(
//                             top: 50, // Position it below the search bar
//                             left: 20,
//                             right: 20,
//                             child: Material(
//                               elevation: 5,
//                               borderRadius: BorderRadius.circular(5),
//                               child: Container(
//                                 height: 300,
//                                 // padding: const EdgeInsets.symmetric(horizontal: 0),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5),
//                                   // boxShadow: [
//                                   //   BoxShadow(
//                                   //     color: Colors.grey.withOpacity(0.2),
//                                   //     spreadRadius: 1,
//                                   //     blurRadius: 5,
//                                   //   ),
//                                   // ],
//                                 ),
//                                 child: _isLoadingSearch
//                                     ? const Center(
//                                         child: CircularProgressIndicator())
//                                     : ListView.builder(
//                                         itemCount: _searchResults.length,
//                                         itemBuilder: (context, index) {
//                                           final result = _searchResults[index];
//                                           return ListTile(
//                                             onTap: () {
//                                               // Navigate to the new screen with the lead_id
//                                               Get.to(() => SingleLeadsById(
//                                                   leadId: result['lead_id']));
//                                             },
//                                             title: Text(
//                                               result['lead_name'] ?? 'No Name',
//                                               style: AppFont.searchFontTitle(),
//                                             ),
//                                             subtitle: Text(
//                                               result['email'] ?? 'No Email',
//                                               style:
//                                                   AppFont.searchFontSubtitle(),
//                                             ),
//                                             leading: const Icon(Icons.person),
//                                           );
//                                         },
//                                       ),
//                               ),
//                             ),
//                           ),

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

//                         _SelectedInput(
//                           label: "Priority:",
//                           options: ["High"], // Show selectedType
//                         ),
//                         // _buildDropdown(
//                         //     label: 'Leads Name:',
//                         //     value: selectedLeads,
//                         //     items: dropdownItems,
//                         //     onChanged: (val) =>
//                         //         setState(() => selectedLeads = val)),
//                         // _buildDropdown(
//                         //     label: 'Subject:',
//                         //     value: selectedSubject,
//                         //     items: ['Call', 'Provide Quotation', 'Send Email'],
//                         //     onChanged: (val) =>
//                         //         setState(() => selectedSubject = val)),
//                         // _buildDropdown(
//                         //     label: 'Status:',
//                         //     value: selectedStatus,
//                         //     items: ['Not Started', 'In Progress', 'Completed'],
//                         //     onChanged: (val) =>
//                         //         setState(() => selectedStatus = val)),
//                         _buildTextField(
//                             label: 'Comments:',
//                             controller: descriptionController,
//                             hint: 'Enter Comments'),
//                       ],
//                     ),
//                     // Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   children: [
//                     //     _buildDropdown(
//                     //         label: 'Priority:',
//                     //         value: selectedPriority,
//                     //         items: ['High', 'Normal', 'Low'],
//                     //         onChanged: (val) =>
//                     //             setState(() => selectedPriority = val)),
//                     //     _buildDatePicker(
//                     //         label: 'Followup Date:',
//                     //         controller: dateController,
//                     //         onTap: _pickDate),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 5),

//               // Smooth Indicator
//               // SmoothPageIndicator(
//               //   controller: _pageController,
//               //   count: 2,
//               //   effect: const WormEffect(
//               //     activeDotColor: Colors.black,
//               //     spacing: 4.0,
//               //     radius: 10.0,
//               //     dotWidth: 10.0,
//               //     dotHeight: 10.0,
//               //   ),
//               // ),

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

//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<dynamic> items,
//     required ValueChanged<String?> onChanged,
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
//             color: AppColors.containerPopBg,
//           ),
//           child: DropdownButton<String>(
//             value: value,
//             hint: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 "Select",
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey),
//               ),
//             ),
//             icon: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(Icons.keyboard_arrow_down_sharp, size: 30),
//             ),
//             isExpanded: true,
//             underline: const SizedBox.shrink(),
//             items: items.map((item) {
//               return DropdownMenuItem<String>(
//                 value: item is String ? item : item['id'].toString(),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0),
//                   child: Text(
//                     item is String ? item : item['name'].toString(),
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black),
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: onChanged,
//           ),
//         ),
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
