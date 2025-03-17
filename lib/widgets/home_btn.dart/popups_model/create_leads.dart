import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateLeads extends StatefulWidget {
  const CreateLeads({super.key});

  @override
  State<CreateLeads> createState() => _CreateLeadsState();
}

class _CreateLeadsState extends State<CreateLeads> {
  final PageController _pageController = PageController();
  List<Map<String, String>> dropdownItems = [];
  final _formKey = GlobalKey<FormState>(); 
  bool isLoading = false;
  int _currentStep = 0;

  // Form error tracking
  Map<String, String> _errors = {};

  String _selectedBrand = '';
  String _selectedType = 'Product';
  String _selectedFuel = '';
  String _selectedPurchaseType = '';
  String _selectedEnquiryType = '';

  // Define constants
  final double _minValue = 4000000; // 40 lakhs
  final double _maxValue = 20000000; // 200 lakhs (2 crore)

  // Initialize range values within min-max bounds
  late RangeValues _rangeAmount;

  // String  selectedLeads = '';
  // String selectedPurchaseType = 'New Vehicle';
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
    _rangeAmount = RangeValues(_minValue, _maxValue);
    // fetchDropdownData();
  }

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

  void _nextStep() {
    if (_currentStep < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    } else {
      _submitForm(); // ✅ Calls the submit function when on the last step
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Add New lead', style: AppFont.popupTitleBlack(context)),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                // Step indicators with line
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Step 1 indicator column
                      Column(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _currentStep == 0
                                  ? AppColors.colorsBlue
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: _currentStep == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Contact Details',
                            style: TextStyle(
                              fontSize: 12,
                              color: _currentStep == 0
                                  ? AppColors.colorsBlue
                                  : Colors.grey,
                              fontWeight: _currentStep == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),

                      // Connector line
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 17), // Move line up to align with circles
                          height: 2,
                          color: _currentStep == 1
                              ? Colors.grey.shade300
                              : Colors.grey.shade300,
                        ),
                      ),

                      // Step 2 indicator column
                      Column(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _currentStep == 1
                                  ? AppColors.colorsBlue
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: _currentStep == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Vehicle Details',
                            style: TextStyle(
                              fontSize: 12,
                              color: _currentStep == 1
                                  ? AppColors.colorsBlue
                                  : Colors.grey,
                              fontWeight: _currentStep == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .57,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                label: 'First Name',
                                controller: firstNameController,
                                hintText: 'first name',
                                isRequired: true,
                                onChanged: (value) {
                                  print("firstName : $value");
                                }),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                                isRequired: true,
                                label: 'Last Name',
                                controller: lastNameController,
                                hintText: 'Last name',
                                onChanged: (value) {
                                  print("lastName : $value");
                                }),
                          )
                        ],
                      ),
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
                      const SizedBox(
                        height: 5,
                      ),
                      _buildButtons(
                        label: 'Lead Source',
                        options: {"Email": "Email", "Online Add": "Online Add"},
                        groupValue: _selectedType,
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                      ),
                      _buildAmountRange(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _buildButtonsFloat(
                          options: {
                            "Jaguar": "Jaguar",
                            "Land Rover": "Land Rover",
                            // "Range Rover": "Range Rover",
                            // "Discovery": "Discovery"
                          },
                          groupValue: _selectedBrand,
                          label: 'Brand',
                          onChanged: (value) {
                            setState(() {
                              _selectedBrand = value;
                            });
                          }),
                      const SizedBox(height: 10),

                      _buildButtonFuel(
                          options: {
                            // "EV": "EV",
                            "Petrol": "Petrol",
                            "Diesel": "Diesel",
                          },
                          groupValue: _selectedFuel,
                          label: 'Fuel Type',
                          onChanged: (value) {
                            setState(() {
                              _selectedFuel = value;
                            });
                          }),
                      const SizedBox(height: 10),
                      _buildPurchaseType(
                          options: {
                            "New": "New Vehicle",
                            "Old": "Old",
                          },
                          groupValue: _selectedPurchaseType,
                          label: 'Purchase Type',
                          onChanged: (value) {
                            setState(() {
                              _selectedPurchaseType = value;
                            });
                          }),
                      const SizedBox(height: 10),
                      _buildEnquiryType(
                          options: {
                            "KMI": "KMI",
                            "Generic":
                                "(Generic) Purchase intent within 90 days",
                          },
                          groupValue: _selectedEnquiryType,
                          label: 'Enquiry Type',
                          onChanged: (value) {
                            setState(() {
                              _selectedEnquiryType = value;
                            });
                          }),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('Primary Model Intrest',
                              style: AppFont.dropDowmLabel(context)),
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
                            hintText: 'Select Lead',
                            hintStyle: AppFont.dropDown(context),
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
                      _buildDatePicker(
                          label: 'Expected purchase date',
                          controller: endDateController,
                          onTap: () => _pickDate(isStartDate: false)),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ Updated Button Row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (_currentStep == 0) {
                        Navigator.pop(context); // ✅ Closes if on first page
                      } else {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _currentStep--);
                      }
                    },
                    child: Text(
                      _currentStep == 0 ? "Cancel" : "Go Back",
                      style: AppFont.buttons(context),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorsBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: _nextStep,
                    child: Text(
                      _currentStep == 1
                          ? "Create"
                          : "Continue", // ✅ Corrected step check
                      style: AppFont.buttons(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String label,
    required ValueChanged<String> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
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
              color: const Color.fromARGB(255, 248, 247, 247)),
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
                border: Border.all(color: Colors.black, width: 0.5)),
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
                  color: AppColors.fontBlack,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsFloat({
    required Map<String, String> options,
    required String groupValue,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    List<String> optionKeys = options.keys.toList();

    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // ✅ Aligns label and buttons properly
              children: [
                // 🔹 Brand Label (Left Side, Vertically Centered)
                SizedBox(
                  child: Align(
                    alignment:
                        Alignment.centerRight, // ✅ Ensures proper alignment
                    child: Text(
                      label,
                      style: AppFont.dropDowmLabel(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // 🔹 Right Side: Brand Options in Two Rows
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align buttons left
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // ✅ Align left
                        children: [
                          _buildOptionButton(
                              optionKeys[0], options, groupValue, onChanged),
                          const SizedBox(width: 5),
                          _buildOptionButton(
                              optionKeys[1], options, groupValue, onChanged),
                        ],
                      ),
                      // const SizedBox(height: 4), // ✅ Space between rows
                      // Row(
                      //   mainAxisAlignment:
                      //       MainAxisAlignment.end, // ✅ Align left
                      //   children: [
                      //     _buildOptionButton(
                      //         optionKeys[2], options, groupValue, onChanged),
                      //     const SizedBox(width: 5),
                      //     _buildOptionButton(
                      //         optionKeys[3], options, groupValue, onChanged),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRange() {
    // Convert to lakhs for display
    final double startLakh = _rangeAmount.start / 100000;
    final double endLakh = _rangeAmount.end / 100000;

    // Format with one decimal place
    final startText = startLakh.toStringAsFixed(1);
    final endText = endLakh.toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),

        Text(
          "Budget",
          style: AppFont.dropDowmLabel(context),
        ),

        const SizedBox(height: 5),

        // 🔹 Show Selected Range as Text
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "₹$startText lakh - ₹$endText lakh",
            style: AppFont.smallText(context),
          ),
        ),

        // const SizedBox(height: 5),

        // 🔹 Range Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.colorsBlue,
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            thumbColor: AppColors.colorsBlue,
            overlayColor: Colors.blue.withOpacity(0.2),
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: RangeSlider(
            values: _rangeAmount,
            min: _minValue,
            max: _maxValue,
            divisions: 180, // (200-40) increments of 1 lakh each
            labels: RangeLabels(
              "₹${startText}L",
              "₹${endText}L",
            ),
            onChanged: (RangeValues values) {
              // Round to nearest lakh
              final double newStart = (values.start / 100000).round() * 100000;
              final double newEnd = (values.end / 100000).round() * 100000;

              // Ensure values are within bounds
              final clampedStart = newStart.clamp(_minValue, _maxValue);
              final clampedEnd = newEnd.clamp(_minValue, _maxValue);

              setState(() {
                _rangeAmount = RangeValues(clampedStart, clampedEnd);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButtonFuel({
    required Map<String, String> options,
    required String groupValue,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    List<String> optionKeys = options.keys.toList();

    return Container(
      height: MediaQuery.of(context).size.height * .06,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // ✅ Aligns label and buttons properly
              children: [
                // 🔹 Brand Label (Left Side, Vertically Centered)
                SizedBox(
                  // width: 80, // ✅ Fixed width to align properly
                  child: Align(
                    alignment:
                        Alignment.centerRight, // ✅ Ensures proper alignment
                    child: Text(
                      label,
                      style: AppFont.dropDowmLabel(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // 🔹 Right Side: Brand Options in Two Rows
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align buttons left
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // ✅ Align left
                        children: [
                          _buildOptionFuel(
                              optionKeys[0], options, groupValue, onChanged),
                          const SizedBox(width: 5),
                          _buildOptionFuel(
                              optionKeys[1], options, groupValue, onChanged),
                          // const SizedBox(width: 5),
                          // _buildOptionFuel(
                          //     optionKeys[2], options, groupValue, onChanged),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// ✅ Button Builder Function
  Widget _buildOptionButton(String shortText, Map<String, String> options,
      String groupValue, ValueChanged<String> onChanged) {
    bool isSelected = groupValue == options[shortText];

    return GestureDetector(
      onTap: () {
        onChanged(options[shortText]!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.colorsBlue : Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color:
              isSelected ? AppColors.colorsBlue.withOpacity(0.2) : Colors.white,
        ),
        child: Center(
          child: Text(
            shortText,
            style: TextStyle(
              color: isSelected ? AppColors.colorsBlue : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnquiryType({
    required Map<String, String> options,
    required String groupValue,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    List<String> optionKeys = options.keys.toList();

    return Container(
      height: MediaQuery.of(context).size.height * .06,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // ✅ Aligns label and buttons properly
              children: [
                // 🔹 Brand Label (Left Side, Vertically Centered)
                SizedBox(
                  // width: 80, // ✅ Fixed width to align properly
                  child: Align(
                    alignment:
                        Alignment.centerRight, // ✅ Ensures proper alignment
                    child: Text(
                      label,
                      style: AppFont.dropDowmLabel(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // 🔹 Right Side: Brand Options in Two Rows
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align buttons left
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // ✅ Align left
                        children: [
                          _buildOptionButtonEnquiry(
                              optionKeys[0], options, groupValue, onChanged),
                          const SizedBox(width: 5),
                          _buildOptionButtonEnquiry(
                              optionKeys[1], options, groupValue, onChanged),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseType({
    required Map<String, String> options,
    required String groupValue,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    List<String> optionKeys = options.keys.toList();

    return Container(
      height: MediaQuery.of(context).size.height * .06,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // ✅ Aligns label and buttons properly
              children: [
                // 🔹 Brand Label (Left Side, Vertically Centered)
                SizedBox(
                  // width: 80, // ✅ Fixed width to align properly
                  child: Align(
                    alignment:
                        Alignment.centerRight, // ✅ Ensures proper alignment
                    child: Text(
                      label,
                      style: AppFont.dropDowmLabel(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // 🔹 Right Side: Brand Options in Two Rows
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align buttons left
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // ✅ Align left
                        children: [
                          _buildOptionButtonPurchase(
                              optionKeys[0], options, groupValue, onChanged),
                          const SizedBox(width: 5),
                          _buildOptionButtonPurchase(
                              optionKeys[1], options, groupValue, onChanged),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionFuel(String shortText, Map<String, String> options,
      String groupValue, ValueChanged<String> onChanged) {
    bool isSelected = groupValue == options[shortText];

    return GestureDetector(
      onTap: () {
        onChanged(options[shortText]!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.colorsBlue : Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color:
              isSelected ? AppColors.colorsBlue.withOpacity(0.2) : Colors.white,
        ),
        child: Center(
          child: Text(
            shortText,
            style: TextStyle(
              color: isSelected ? AppColors.colorsBlue : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButtonEnquiry(
      String shortText,
      Map<String, String> options,
      String groupValue,
      ValueChanged<String> onChanged) {
    bool isSelected = groupValue == options[shortText];

    return GestureDetector(
      onTap: () {
        onChanged(options[shortText]!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.colorsBlue : Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color:
              isSelected ? AppColors.colorsBlue.withOpacity(0.2) : Colors.white,
        ),
        child: Center(
          child: Text(
            shortText,
            style: TextStyle(
              color: isSelected ? AppColors.colorsBlue : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButtonPurchase(
      String shortText,
      Map<String, String> options,
      String groupValue,
      ValueChanged<String> onChanged) {
    bool isSelected = groupValue == options[shortText];

    return GestureDetector(
      onTap: () {
        onChanged(options[shortText]!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.colorsBlue : Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color:
              isSelected ? AppColors.colorsBlue.withOpacity(0.2) : Colors.white,
        ),
        child: Center(
          child: Text(
            shortText,
            style: TextStyle(
              color: isSelected ? AppColors.colorsBlue : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

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
            child: Text(label, style: AppFont.dropDowmLabel(context)),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: options.keys.map((shortText) {
            bool isSelected = groupValue == options[shortText];

            return GestureDetector(
              onTap: () {
                onChanged(options[shortText]!);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                margin: const EdgeInsets.only(
                    right: 10), // Adds spacing between buttons
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.colorsBlue : Colors.black,
                    width: .5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: isSelected
                      ? AppColors.colorsBlue.withOpacity(0.2)
                      : Colors.white,
                ),
                child: Text(
                  shortText, // ✅ Only show short text
                  style: TextStyle(
                    color: isSelected ? AppColors.colorsBlue : Colors.black,
                    fontSize: 12,
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
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? spId = prefs.getString('user_id');

      if (spId == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('User ID not found. Please log in again.')),
          );
        }
        print("Error: User ID not found."); // ✅ Print error in console
        return;
      }

      final leadData = {
        'fname': firstNameController.text,
        'lname': lastNameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
        'purchase_type': _selectedPurchaseType,
        'brand': _selectedBrand,
        'type': 'Product',
        'sub_type': selectedSubType,
        'sp_id': spId,
        'PMI': 'Range rover',
        'expected_date_purchase': endDateController.text,
        'fuel_type': _selectedFuel,
        'enquiry_type': _selectedEnquiryType,
        'lead_source': _selectedType,
      };

      print(
          "Submitting lead data: $leadData"); // ✅ Print lead data before submission

      Map<String, dynamic>? response = await LeadsSrv.submitLead(leadData);

      if (response != null) {
        print("Response received: $response"); // ✅ Print full response

        if (response.containsKey('newLead')) {
          String leadId = response['newLead']['lead_id'];
          print(
              "Lead Created Successfully: Lead ID - $leadId"); // ✅ Log success

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleLeadsById(leadId: leadId),
              ),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form Submit Successful.')),
          );
        } else if (response.containsKey('error')) {
          String errorMsg = response['error'];
          print("API Error: $errorMsg"); // ✅ Log API error

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
          );
        }
      } else {
        print("Error: API response is null"); // ✅ Log null response
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to submit lead. Please try again.')),
        );
      }
    } catch (e, stackTrace) {
      print("Exception Occurred: $e"); // ✅ Log any unexpected exceptions
      print("Stack Trace: $stackTrace"); // ✅ Print stack trace for debugging

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An unexpected error occurred. Please try again.')),
      );
    }
  }
}
