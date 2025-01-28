import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_last.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_second.dart';

class LeadsThird extends StatefulWidget {
  // const LeadsThird({super.key, required firstName});
  final String selectedPurchaseType;
  final String subType;
  final String selectedFuelType;
  final String selectedBrand;
  final String firstName;
  final String lastName;
  final String email;
  final String selectedEnquiryType;
  final String selectedEvent;
  final String selectedSource;
  const LeadsThird({
    super.key,
    required,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.selectedPurchaseType,
    required this.subType,
    required this.selectedFuelType,
    required this.selectedBrand,
    required this.selectedEnquiryType, required this.selectedEvent, required this.selectedSource,
  });

  @override
  State<LeadsThird> createState() => _LeadsThirdState();
}

class _LeadsThirdState extends State<LeadsThird> {
  final Widget _leadSecondStep = const LeadsSecond(
    firstName: '',
    lastName: '',
    email: '',
    selectedPurchaseType: '',
    selectedFuelType: '',
    subType: '',
    selectedBrand: '',
  );
  final Widget _leadLastStep = const LeadsLast(
    firstName: '',
    lastName: '',
    email: '',
    mobile: '',
    selectedPurchaseType: '',
    selectedFuelType: '',
    subType: '',
    selectedBrand: '',
    selectedEnquiryType: '', selectedEvent: '', selectedSource: '', String: null,
  );

  // Declare the selection variables for dropdowns
  String? selectedEvent;
  String? selectedSource;
  String? selectedEnquiryType;
  String? selectedCustomer;

  // Controller for mobile number input
  TextEditingController mobileController = TextEditingController();

  get selectedPurchaseType => null;

  get selectedFuelType => null;

  get selectedBrand => null;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: _buildTitle('Add New Leads')),
                  const SizedBox(height: 5),
                  _buildSectionTitle('Primary Model Input:'),
                  _buildDropdown(
                    label: 'Discovery',
                    value: selectedEvent,
                    items: ['Land Rover', 'Jaguar'],
                    onChanged: (value) {
                      setState(() {
                        selectedEvent = value;
                      });
                      print("Selected Event: $selectedEvent");
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSectionTitle('Source:'),
                  _buildDropdown(
                    label: 'Email',
                    value: selectedSource,
                    items: ['Email', 'Field Visit', 'Referral'],
                    onChanged: (value) {
                      setState(() {
                        selectedSource = value;
                      });
                      print("Selected Source: $selectedSource");
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSectionTitle('Mobile*'),
                  _buildTextField(
                    controller: mobileController,
                    hintText: '0000000000',
                    onChanged: (value) {
                      print("Mobile Number: $value");
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSectionTitle('Enquiry Type:'),
                  _buildDropdown(
                    label: 'KMI',
                    value: selectedEnquiryType,
                    items: ['Generic'],
                    onChanged: (value) {
                      setState(() {
                        selectedEnquiryType = value;
                      });
                      print("Selected Enquiry Type: $selectedEnquiryType");
                    },
                  ),
                  const SizedBox(height: 30),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Title widget
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Section title widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Reusable Dropdown widget
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 243, 238, 238),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            label,
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
        items: items.map((String value) {
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
        onChanged: onChanged,
      ),
    );
  }

  // Reusable TextField widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 243, 238, 238),
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
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }

  // Navigation buttons (Previous and Next)
  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context); // Close the current dialog
              Future.microtask(() {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _leadSecondStep,
                  ),
                );
              });
            },
            child: Text(
              'Previous',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context); // Close the current dialog
              Future.microtask(() {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LeadsLast(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      email: widget.email,
                      mobile: mobileController.text.toString(),
                      selectedPurchaseType:
                          selectedPurchaseType ?? 'Default Value',
                      subType: widget.subType,
                      selectedFuelType: selectedFuelType ?? 'Default Value',
                      selectedBrand: selectedBrand ?? 'Default Value',
                      selectedEnquiryType: selectedEnquiryType ?? 'Default',
                      selectedEvent : selectedEvent ?? 'default',
                      selectedSource : selectedSource ?? 'default', String: null,
                    ),
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
      ],
    );
  }
}
