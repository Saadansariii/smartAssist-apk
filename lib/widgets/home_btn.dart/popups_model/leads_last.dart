import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/leads_third.dart';

class LeadsLast extends StatefulWidget {
  final String selectedPurchaseType;
  final String subType;
  final String selectedFuelType;
  final String selectedBrand;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String selectedSource;
  final String selectedEvent;
  final String selectedEnquiryType;
  LeadsLast(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.selectedPurchaseType,
      required this.subType,
      required this.selectedFuelType,
      required this.selectedBrand,
      required this.selectedSource,
      required this.selectedEvent,
      required this.selectedEnquiryType});

  @override
  State<LeadsLast> createState() => _LeadsLastState();
}

class _LeadsLastState extends State<LeadsLast> {
  // String selectedSource = '';
  // String? selectedPurchaseType;
  // String? selectedFuelType;
  // String? selectedBrand;
  // String? selectedEvent;
  // String? selectedEnquiryType;
  // String? selectedCustomer;

  // String? selectedFuelType;
  // String? selectedPurchaseType;
  // String? selectedBrand;
  // String? selectedEvent;
  // String? selectedSource;
  // String? selectedEnquiryType;
  // String? selectedCustomer;

  String? selectedFuelType;
  String? selectedPurchaseType;
  String? selectedBrand;
  String? selectedEvent;
  String? selectedSource;
  String? selectedEnquiryType;
  String? selectedCustomer;
  String? subType;
  String? selectedStatus;

  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFuelType = widget.selectedFuelType!;
    selectedPurchaseType = widget.selectedPurchaseType!;
    subType = widget.subType!;
    selectedEnquiryType = widget.selectedEnquiryType!;
    selectedSource = widget.selectedSource!;
    selectedEvent = widget.selectedEvent!;
    selectedBrand = widget.selectedBrand!;
    print(selectedFuelType);
  }

  // Controllers for capturing input
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool get isLoading => false;

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text('Add New Leads',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              textAlign: TextAlign.start,
                              'Assign to',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 243, 238, 238),
                          ),
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownButton<String>(
                                  value: selectedStatus,
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Select",
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
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: "New",
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "New",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "Follow Up",
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "Followup",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "Qualified",
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "Qualified",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "Lost",
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "Lost",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatus =
                                          value!; // Corrected assignment
                                    });

                                    print(
                                        "Selected Status: $selectedStatus"); // Debugging
                                  },
                                ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Description :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: double.infinity, // Full width
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 243, 238, 238),
                          ),
                          child: TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintText: "Description",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.only(left: 10),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Lead code :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: double.infinity, // Full width
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 243, 238, 238),
                          ),
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: "Lead Code",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.only(left: 10),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Calendar :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 243, 238, 238),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Text(
                              dateController.text.isEmpty
                                  ? "Select Date"
                                  : dateController.text,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: dateController.text.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    // Close the current dialog and open the second dialog
                                    Navigator.pop(
                                        context); // Close the first dialog
                                    Future.microtask(() {
                                      // Immediately queue the second dialog to open after the first closes
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: LeadsThird(
                                            firstName: '',
                                            lastName: '',
                                            email: '',
                                            selectedPurchaseType: '',
                                            subType: '',
                                            selectedFuelType: '',
                                            selectedBrand: '',
                                            selectedEnquiryType: '',
                                            selectedEvent: '',
                                            selectedSource: '',
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Text('Previous',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
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
                                    submitForm();
                                  },
                                  child: Text('Submit',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

Future<void> storeLeadId(String leadId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'lead_id', leadId); // Save lead_id in SharedPreferences
    print("Stored lead_id: $leadId"); // Debugging
  }
  // This function will call the API and pass the captured data
  Future<void> submitForm() async {
    String description = descriptionController.text;
    String phone = phoneController.text;
    String date = dateController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spId = prefs.getString('user_id');
   String? leadId = prefs.getString('lead_id');

    print('Retrieved sp_id: $spId'); // Debugging

    if (spId == null) {
      showErrorMessage(context,
          message: 'User ID not found. Please log in again.');
      return;
    }

    // Prepare the lead data
    final leadData = {
      'fname': widget.firstName,
      'lname': widget.lastName,
      'email': widget.email,
      'lead_code': phone,
      'mobile': widget.mobile,
      'purchase_type': selectedPurchaseType,
      'brand': selectedBrand,
      'type': selectedFuelType,
      'sub_type': subType,
      'sp_id': spId,
      'status': selectedStatus,
      'lead_source': selectedSource,
      'PMI': selectedEvent,
      'enquiry_type': selectedEnquiryType,
    };

    print('Lead Data: $leadData');
    bool success = await LeadsSrv.submitLead(leadData , leadId);
    
    if (success) {
      print('Lead submitted successfully!');

      //  String leadId = 'lead_id';
      // Close modal if submission is successful
      if (context.mounted) {
        // Navigator.pop(context);
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SingleLeadsById(leadId: leadId!),  
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submit Successful.')),
      );
    } else {
      print('Failed to submit lead.');
    }
  }
}
