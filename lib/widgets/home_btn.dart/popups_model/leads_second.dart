import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_first.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_third.dart';

class LeadsSecond extends StatefulWidget {
  final String selectedPurchaseType;
  final String subType;
  final String selectedFuelType;
  final String selectedBrand;
  final String firstName;
  final String lastName;
  final String email; 
  const LeadsSecond({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.selectedPurchaseType,
    required this.selectedFuelType,
    required this.subType,
    required this.selectedBrand,
  });

  @override
  State<LeadsSecond> createState() => _LeadsSecondState();
}

class _LeadsSecondState extends State<LeadsSecond> {
  // final Widget _leadSecondStep = const LeadsSecond(
  //   firstName: '',
  //   lastName: '',
  //   email: '',
  //   selectedPurchaseType: '',
  //   selectedFuelType: '',
  //   subType: '',
  //   selectedBrand: '',
  // );
  TextEditingController typeController = TextEditingController();

  // final Widget _leadThirdStep = LeadsThird(
  //   firstName: '',
  //   lastName: '',
  //   email: '',
  //   selectedPurchaseType: '',
  //   subType: '',
  //   selectedFuelType: '',
  //   selectedBrand: '',
  //   selectedEnquiryType: '',
  //   selectedEvent: '',
  //   selectedSource: '',
  // );
  // final Widget _leadFirstStep = const LeadFirstStep(firstName: firstName , lastName: lastName,);

  String? selectedPurchaseType;
  String? selectedFuelType;
  String? selectedBrand;
  String subType = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Center(
              child: Text(
                'Add New Leads',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Purchase Type Dropdown
            _buildDropdown(
              label: 'Purchase Type:',
              hint: 'Select Purchase Type',
              value: selectedPurchaseType,
              items: ['New Vehicle', 'Used Vehicle'],
              onChanged: (value) {
                setState(() {
                  selectedPurchaseType = value;
                });
                print("Selected Purchase Type: $selectedPurchaseType");
              },
            ),

            // Fuel Type Dropdown
            _buildDropdown(
              label: 'Type:',
              hint: 'Select Fuel Type',
              value: selectedFuelType,
              items: ['Petrol', 'Diesel', 'EV'],
              onChanged: (value) {
                setState(() {
                  selectedFuelType = value;
                });
                print("Selected Fuel Type: $selectedFuelType");
              },
            ),

            // Sub Type Input
            _buildTextField(
              label: 'Sub Type:',
              hintText: 'Retail',
              onChanged: (value) {
                setState(() {
                  subType = value;
                });
                print("Sub Type: $subType");
              },
            ),

            // Brand Dropdown
            _buildDropdown(
              label: 'Brand:',
              hint: 'Select Brand',
              value: selectedBrand,
              items: ['Land Rover', 'Jaguar'],
              onChanged: (value) {
                setState(() {
                  selectedBrand = value;
                });
                print("Selected Brand: $selectedBrand");
              },
            ),

            const SizedBox(height: 30),

            // Navigation Buttons
            Row(
              children: [
                // Previous Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
                            child: LeadFirstStep(
                               firstName: widget.firstName,
                              lastName: widget.lastName,
                            ), // Your second modal widget
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

                // Next Button
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
                              child: LeadsThird(
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                email: widget.email,
                                subType: typeController.text,
                                selectedPurchaseType: selectedPurchaseType!,
                                selectedFuelType: selectedFuelType!,
                                selectedBrand: selectedBrand!,
                                selectedEnquiryType: '',
                                selectedEvent: '',
                                selectedSource: '',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Validation
  bool _validateFields() {
    return selectedPurchaseType != null &&
        selectedFuelType != null &&
        selectedBrand != null &&
        subType.isNotEmpty;
  }

  void _showValidationError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Error'),
        content: const Text('Please fill in all required fields.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Reusable Dropdown Builder
  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 243, 238, 238),
          ),
          child: DropdownButton<String>(
            value: value,
            hint: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                hint,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    item,
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
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Reusable TextField Builder
  Widget _buildTextField({
    required String label,
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 243, 238, 238),
          ),
          child: TextField(
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
