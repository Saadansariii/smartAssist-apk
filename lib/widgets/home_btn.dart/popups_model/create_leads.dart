import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  String _selectedBrand = '';
  String _selectedType = '';
  String _selectedEnquiryType = '';

  // String  selectedLeads = '';
  String selectedPurchaseType = 'New Vehicle';
  String selectedType = 'Product';
  String selectedSubType = 'Retail';
  String selectedTire = 'New';
  // String? selectedSubject;
  // String? selectedPriority;

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
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        if (isStartDate) {
          startDateController.text = formattedDate;
        } else {
          endDateController.text = formattedDate;
        }
      });
    }
  }

  // Future<void> _pickDate({required bool isStartDate}) async {
  //   DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100));
  //   if (pickedDate != null) {
  //     TimeOfDay? pickedTime =
  //         await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //     if (pickedTime != null) {
  //       DateTime combinedDateTime = DateTime(pickedDate.year, pickedDate.month,
  //           pickedDate.day, pickedTime.hour, pickedTime.minute);
  //       String formattedDateTime =
  //           DateFormat('dd/MM/yyyy hh:mm a').format(combinedDateTime);
  //       setState(() {
  //         if (isStartDate) {
  //           startDateController.text = formattedDateTime;
  //         } else {
  //           endDateController.text = formattedDateTime;
  //         }
  //       });
  //     }
  //   }
  // }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentStep++);
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    submitForm();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Add New lead', style: AppFont.popupTitleBlack()),
            ),

            // const SizedBox(height: 5),
            SizedBox(
              height: height * .5,
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
                      _buildRadioGroup(
                        label: 'Brand',
                        options: ["Jaguar", "Land Rover"],
                        groupValue: _selectedBrand,
                        onChanged: (value) {
                          setState(() {
                            _selectedBrand = value;
                          });
                        },
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('Primary Model Intrest',
                              style: AppFont.dropDowmLabel()),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Keep border radius small
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Match with enabledBorder
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            filled: true,
                            fillColor: AppColors.containerBg,
                            hintText: 'Type to talk',
                            hintStyle: AppFont.dropDown(),
                            prefixIcon: const Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: AppColors.fontColor,
                              size: 15,
                            ),
                            // suffixIcon: const Icon(
                            //   FontAwesomeIcons.microphone,
                            //   color: AppColors.fontColor,
                            //   size: 15,
                            // ),
                          ),
                          
                        ),
                      ),
                      // const SizedBox(height: 2),

                      _buildRadioGroup(
                        label: 'Fuel Type',
                        options: ['Petrol', 'Diesel'],
                        groupValue: _selectedType,
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SelectedInput(
                            label: "Purchase Type",
                            options: [
                              "New Vehicle"
                            ], // Show selectedPurchaseType
                          ),
                          _SelectedInput(
                            label: "Type",
                            options: ["Product"], // Show selectedType
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SelectedInput(
                            label: "Sub Type",
                            options: ["Retail"], // Show selectedSubType
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      // _buildButtons(
                      //   label: 'Enquiry Type',
                      //   options: ["KMI", "Generic"],
                      //   groupValue: _selectedEnquiryType,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedEnquiryType = value;
                      //     });
                      //   },
                      // ),
                      _buildButtons(
                        label: 'Enquiry Type',
                        options: {
                          "KMI": "KMI",
                          "Generic": "(Generic) Purchase intent within 90 days",
                        },
                        groupValue: _selectedEnquiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedEnquiryType = value;
                          });
                        },
                      ),

                      _buildDatePicker(
                          label: 'Expected purchase date',
                          controller: endDateController,
                          onTap: () => _pickDate(isStartDate: false)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),

            SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: AppColors.fontBlack,
                  spacing: 4.0,
                  radius: 10.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                )),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      if (_currentStep == 0) {
                        Navigator.pop(context);
                      } else {
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        setState(() {
                          _currentStep--;
                        });
                      }
                    },
                    child: Text(
                      _currentStep == 0 ? "Cancel" : "Go Back",
                      style: AppFont.buttons(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorsBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: _nextStep,
                    child: Text(_currentStep == 2 ? "Create" : "Continue",
                        style: AppFont.buttons()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Reusable Radio Button Widget (One Line)
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
            padding: const EdgeInsets.fromLTRB(0.0, 5, 10, 0),
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

  // Widget _SelectedInput({
  //   required String label,
  //   required List<String> options, // Accept predefined list
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Align(
  //         alignment: Alignment.centerLeft,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
  //           child: Text(label, style: AppFont.dropDowmLabel()),
  //         ),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: options.map((option) {
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
  //             child: Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
  //                 decoration: const BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(3)),
  //                   color: AppColors.containerBg,
  //                 ),
  //                 child: Text(option, style: AppFont.dropDown())),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }

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
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
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
        const SizedBox(
          height: 5,
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
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        const SizedBox(height: 5),
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
        const SizedBox(height: 5),
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

  // Widget _buildButtons({
  //   required List<String> options,
  //   required String groupValue,
  //   required String label,
  //   required ValueChanged<String> onChanged,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Align(
  //         alignment: Alignment.centerLeft,
  //         child: Padding(
  //           padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 5),
  //           child: Text(label, style: AppFont.dropDowmLabel()),
  //         ),
  //       ),
  //       const SizedBox(height: 5),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: options.map((option) {
  //           bool isSelected = groupValue == option; // ✅ Check if selected

  //           return GestureDetector(
  //             onTap: () {
  //               onChanged(option);
  //             },
  //             child: Container(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //               margin: const EdgeInsets.only(
  //                   right: 10), // Adds spacing between buttons
  //               decoration: BoxDecoration(
  //                 border: Border.all(
  //                   color: isSelected ? Colors.blue : Colors.black,
  //                   width: 1,
  //                 ),
  //                 borderRadius: BorderRadius.circular(15),
  //                 color: isSelected
  //                     ? Colors.blue.withOpacity(0.2)
  //                     : Colors.white, // ✅ Optional background change
  //               ),
  //               child: Text(
  //                 option,
  //                 style: TextStyle(
  //                   color: isSelected ? Colors.blue : Colors.black,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //       const SizedBox(height: 5),
  //     ],
  //   );
  // }

  Widget _buildButtons({
    required Map<String, String>
        options, // ✅ Use a Map for short display & actual value
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
            child: Text(label, style: AppFont.dropDowmLabel()),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(
                    right: 10), // Adds spacing between buttons
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.black,
                    width: 1,
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

  Future<void> submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spId = prefs.getString('user_id');

    if (spId == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User ID not found. Please log in again.')),
        );
      }
      return;
    }

    final leadData = {
      'fname': firstNameController.text,
      'lname': lastNameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
      'purchase_type': 'New Vehicle',
      'brand': _selectedBrand,
      'type': 'Product',
      'sub_type': selectedSubType,
      'sp_id': spId,
      'PMI': 'Range rover',
      'expected_date_purchase': endDateController.text,
      'fuel_type': _selectedType,
      'enquiry_type': _selectedEnquiryType,
      // 'lead_code': '12333',
      'lead_source': 'dadf',
    };

    Map<String, dynamic>? response = await LeadsSrv.submitLead(leadData);

    if (response != null) {
      print(leadData);
      if (response.containsKey('newLead')) {
        print(leadData);
        String leadId = response['newLead']['lead_id'];
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleLeadsById(leadId: leadId),
            ),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form Submit Successful.')),
        );
      } else if (response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(response['error']), backgroundColor: Colors.red),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit lead. Please try again.')),
      );
    }
  }
}
