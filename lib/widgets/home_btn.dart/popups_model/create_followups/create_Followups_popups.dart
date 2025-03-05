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
              child: Text('Plan a Follow-up',
                  style: AppFont.popupTitleBlack(context)),
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
            _buildButtons(
              label: 'Action:',
              // options: ['Call', 'Provide Quotation', 'Send Email'],
              options: {
                "Call": "Call",
                'Provide Quotation': "Provide Quotation",
                "Send Email": "Send Email"
              },
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
                    child: Text("Submit", style: AppFont.buttons(context)),
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
            child: Text(label, style: AppFont.dropDowmLabel(context)),
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
                child: Text(option, style: AppFont.dropDown(context)),
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
                border: Border.all(color: Colors.black, width: .5)),
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
                  Icons.calendar_month,
                  color: AppColors.fontBlack,
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
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
}
