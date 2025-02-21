// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:smart_assist/config/component/color/colors.dart';
// import 'package:smart_assist/config/component/font/font.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_assist/pages/calenderPages/tasks/addTask.dart';
// import 'package:smart_assist/services/leads_srv.dart';
// import 'package:smart_assist/utils/snackbar_helper.dart';

// class TaskAppointmentPop extends StatefulWidget {
//   final DateTime? selectedDate;
//   final String leadId;
//   const TaskAppointmentPop(
//       {super.key, this.selectedDate, required this.leadId});

//   @override
//   State<TaskAppointmentPop> createState() => _TaskAppointmentPopState();
// }

// class _TaskAppointmentPopState extends State<TaskAppointmentPop> {
//   List<String> dropdownItems = [];
//   bool isLoading = false;
//   String? leadId;
//   @override
//   void initState() {
//     super.initState();
//     // fetchDropdownData();
//     leadId = widget.leadId;
//     // if (widget.selectedDate != null) {
//     //   dateController.text =
//     //       DateFormat('dd/MM/yyyy hh:mm a').format(widget.selectedDate!);
//     // }
//   }

//   String? selectedLeads;
//   String? selectedSubject;
//   String? selectedStatus;
//   String? selectedPriority;

//   TextEditingController dateController = TextEditingController();
//   TextEditingController enddateController = TextEditingController();
//   // TextEditingController descriptionController = TextEditingController();

//   // Future<void> _pickDate({required bool isStartDate}) async {
//   //   DateTime now = DateTime.now();
//   //   DateTime? pickedDate = await showDatePicker(
//   //     context: context,
//   //     initialDate: now,
//   //     firstDate: now, // Ensure you can't pick a past date
//   //     lastDate: DateTime(2100), // Allow future dates
//   //   );

//   //   if (pickedDate != null) {
//   //     TimeOfDay? pickedTime = await showTimePicker(
//   //       context: context,
//   //       initialTime: TimeOfDay.now(),
//   //     );

//   //     if (pickedTime != null) {
//   //       DateTime combinedDateTime = DateTime(
//   //         pickedDate.year,
//   //         pickedDate.month,
//   //         pickedDate.day,
//   //         pickedTime.hour,
//   //         pickedTime.minute,
//   //       );

//   //       setState(() {
//   //         String formattedDateTime =
//   //             DateFormat('dd/MM/yyyy hh:mm a').format(combinedDateTime);

//   //         if (isStartDate) {
//   //           startdateController.text = formattedDateTime;
//   //         } else {
//   //           enddateController.text = formattedDateTime;
//   //         }

//   //         print('Selected DateTime: $formattedDateTime'); // Debugging Output
//   //       });
//   //     }
//   //   }
//   // }

//   Future<void> _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         // Format the date as 'dd/MM/yyyy'
//         enddateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//         dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 5.0),
//                       child: Text('Create Appoinment',
//                           style: AppFont.popupTitle()),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               _buildDropdown(
//                 label: 'Priority:',
//                 hint: 'Select',
//                 value: selectedPriority,
//                 items: ['High', 'Normal', 'Low'],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedPriority = value;
//                   });
//                   print("Selected Brand: $selectedPriority ");
//                 },
//               ),

//               _buildDropdown(
//                 label: 'Subject:',
//                 hint: 'Select',
//                 value: selectedSubject,
//                 items: [
//                   'Meeting',
//                   'Test Drive',
//                   'Service Appointment',
//                   'Quotation',
//                   'Trade in Evaluation',
//                   'Showroom appointment',
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedSubject = value;
//                   });
//                   print("Selected Brand: $selectedSubject");
//                 },
//               ),

//               const SizedBox(height: 5),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('End Date', style: AppFont.dropDowmLabel()),
//               ),
//               const SizedBox(height: 10),

//               GestureDetector(
//                 onTap: () => _pickDate(),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: AppColors.containerPopBg,
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         enddateController.text.isEmpty
//                             ? "Select Date"
//                             : enddateController.text,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: enddateController.text.isEmpty
//                               ? Colors.grey
//                               : Colors.black,
//                         ),
//                       ),
//                       const Padding(
//                         padding: const EdgeInsets.only(right: 10.0),
//                         child: Icon(
//                           Icons.calendar_today_outlined,
//                           color: Colors.grey,
//                           size: 20,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),

//               // buttons
//               const SizedBox(height: 30),
//               // Row with Buttons
//               Row(
//                 children: [
//                   // Expanded(
//                   //   child: Container(
//                   //     height: 45,
//                   //     decoration: BoxDecoration(
//                   //       color: Colors.black, // Cancel button color
//                   //       borderRadius: BorderRadius.circular(8),
//                   //     ),
//                   //     child: TextButton(
//                   //       onPressed: () {
//                   //         Navigator.pop(context); // Close modal on cancel
//                   //       },
//                   //       child: Text('Previous', style: AppFont.buttons()),
//                   //     ),
//                   //   ),
//                   // ),

//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();

//                         showDialog(
//                           context: context,
//                           builder: (context) => Dialog(
//                             backgroundColor: Colors.transparent,
//                             insetPadding: EdgeInsets.zero,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: const AddTaskPopup(
//                                 leadId: '',
//                                 leadName: '',
//                                 selectedLeadId: '',
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Previous',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: Container(
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: AppColors.colorsBlue,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           submitForm();
//                         },
//                         child: Text('Submit', style: AppFont.buttons()),
//                       ),
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

//   Future<void> submitForm() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? spId = prefs.getString('user_id');
//     String startDate = widget.selectedDate != null
//         ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!)
//         : dateController.text;

//     if (spId == null || widget.leadId.isEmpty) {
//       showErrorMessage(context, message: 'User ID or Lead ID not found.');
//       return;
//     }

//     // Parse dates safely
//     DateTime startDateTime;
//     if (dateController.text.isNotEmpty) {
//       startDateTime =
//           DateFormat('dd/MM/yyyy hh:mm a').parse(dateController.text);
//     } else {
//       startDateTime = widget.selectedDate ?? DateTime.now();
//     }

//     DateTime endDateTime;
//     if (enddateController.text.isNotEmpty) {
//       endDateTime =
//           DateFormat('dd/MM/yyyy hh:mm a').parse(enddateController.text);
//     } else {
//       // Default endDate to at least startDate
//       endDateTime = startDateTime;
//     }

//     // Ensure endDate is never before startDate
//     if (endDateTime.isBefore(startDateTime)) {
//       endDateTime = startDateTime;
//     }

//     // Format dates
//     String formattedStartDate =
//         DateFormat('dd-MM-yyyy').format(startDateTime.toUtc());
//     String formattedEndDate =
//         DateFormat('dd-MM-yyyy').format(endDateTime.toUtc());

//     String formattedStartTime = DateFormat('hh:mm a').format(startDateTime);
//     String formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

//     final newTaskForLead = {
//       'start_date': formattedStartDate,
//       'end_date': formattedEndDate,
//       'priority': selectedPriority,
//       'start_time': formattedStartTime,
//       'end_time': formattedEndTime,
//       'subject': selectedSubject ?? 'Showroom Appointment',
//       'sp_id': spId,
//     };

//     print('Lead Data: $newTaskForLead');

//     bool success =
//         await LeadsSrv.submitAppoinment(newTaskForLead, widget.leadId);

//     if (success) {
//       print('Lead submitted successfully!');
//       if (context.mounted) {
//         Navigator.pop(context);
//       }
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Form Submit Successful.')));
//     } else {
//       print('Failed to submit lead.');
//     }
//   }

// // Reusable Dropdown Builder
//   Widget _buildDropdown({
//     required String label,
//     required String hint,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           label,
//           style: AppFont.dropDowmLabel(),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: AppColors.containerPopBg,
//           ),
//           child: DropdownButton<String>(
//             value: value,
//             hint: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(hint, style: AppFont.dropDown()),
//             ),
//             icon: const Padding(
//               padding: EdgeInsets.only(right: 10.0),
//               child: Icon(
//                 Icons.keyboard_arrow_down_rounded,
//                 color: Colors.grey,
//               ),
//             ),
//             isExpanded: true,
//             underline: const SizedBox.shrink(),
//             items: items.map((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0),
//                   child: Text(item, style: AppFont.dropDowmLabel()),
//                 ),
//               );
//             }).toList(),
//             onChanged: onChanged,
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/pages/calenderPages/tasks/addTask.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';

class TaskAppointmentPop extends StatefulWidget {
  final DateTime? selectedDate;
  final String leadId;
  final String? selectedEvent;
  TaskAppointmentPop({
    super.key,
    this.selectedDate,
    this.selectedEvent,
    required this.leadId,
  });

  @override
  State<TaskAppointmentPop> createState() => _TaskAppointmentPopState();
}

class _TaskAppointmentPopState extends State<TaskAppointmentPop> {
  String? selectedLeads;
  String? selectedSubject;
  String? selectedStatus;
  String? selectedPriority;

  TextEditingController dateController =
      TextEditingController(); // Start Date (fixed)
  TextEditingController enddateController =
      TextEditingController(); // End Date (editable)

  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null) {
      dateController.text =
          DateFormat('dd/MM/yyyy').format(widget.selectedDate!);
    }
  }

  // Pick End Date (Any date, past or future)
  Future<void> _pickEndDate() async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000), // Allow past dates from 2000
      lastDate: DateTime(2100), // Allow future dates up to 2100
    );

    if (pickedDate != null) {
      setState(() {
        enddateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child:
                      Text('Create Appointment', style: AppFont.popupTitle()),
                ),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: 'Priority:',
                hint: 'Select',
                value: selectedPriority,
                items: ['High', 'Normal', 'Low'],
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value;
                  });
                  print("Selected Priority: $selectedPriority");
                },
              ),
              _buildDropdown(
                label: 'Subject:',
                hint: 'Select',
                value: selectedSubject,
                items: [
                  'Meeting',
                  'Test Drive',
                  'Service Appointment',
                  'Quotation',
                  'Trade in Evaluation',
                  'Showroom appointment',
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                  print("Selected Subject: $selectedSubject");
                },
              ),
              const SizedBox(height: 5),
              // Start Date (Fixed, Non-Editable)
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Start Date', style: AppFont.dropDowmLabel()),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.containerPopBg,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateController.text.isEmpty
                          ? "No Date Selected"
                          : dateController.text,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: dateController.text.isEmpty
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // End Date (Editable)
              Align(
                alignment: Alignment.centerLeft,
                child: Text('End Date', style: AppFont.dropDowmLabel()),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickEndDate,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.containerPopBg,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        enddateController.text.isEmpty
                            ? "Select End Date"
                            : enddateController.text,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: enddateController.text.isEmpty
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Buttons
              Row(
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
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.zero,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AddTaskPopup(
                                leadId: '',
                                leadName: '',
                                selectedLeadId: '',
                                initialEvent: widget.selectedEvent,
                              ),
                            ),
                          ),
                        );
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
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.colorsBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          submitForm();
                        },
                        child: Text('Submit', style: AppFont.buttons()),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spId = prefs.getString('user_id');

    if (spId == null || widget.leadId.isEmpty) {
      showErrorMessage(context, message: 'User ID or Lead ID not found.');
      return;
    }

    // Start Date (Fixed from widget.selectedDate)
    DateTime startDateTime;
    if (widget.selectedDate != null) {
      startDateTime = widget.selectedDate!;
    } else {
      showErrorMessage(context, message: 'Start date is required.');
      return;
    }

    // Parse End Date (User-selected)
    DateTime endDateTime;
    if (enddateController.text.isNotEmpty) {
      endDateTime = DateFormat('dd/MM/yyyy').parse(enddateController.text);
    } else {
      endDateTime = startDateTime; // Default to start date if not provided
    }

    // Validate: End date should not be before start date
    if (endDateTime.isBefore(startDateTime)) {
      showErrorMessage(context,
          message: 'End date cannot be before start date.');
      return;
    }

    // Format dates
    String formattedStartDate =
        DateFormat('dd-MM-yyyy').format(startDateTime.toUtc());
    String formattedEndDate =
        DateFormat('dd-MM-yyyy').format(endDateTime.toUtc());
    String formattedStartTime = DateFormat('hh:mm a').format(startDateTime);
    String formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

    final newTaskForLead = {
      'start_date': formattedStartDate,
      'end_date': formattedEndDate,
      'priority': selectedPriority,
      'start_time': formattedStartTime,
      'end_time': formattedEndTime,
      'subject': selectedSubject ?? 'Showroom Appointment',
      'sp_id': spId,
    };

    print('Lead Data: $newTaskForLead');

    bool success =
        await LeadsSrv.submitAppoinment(newTaskForLead, widget.leadId);

    if (success) {
      print('Lead submitted successfully!');
      if (context.mounted) {
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Form Submit Successful.')));
    } else {
      print('Failed to submit lead.');
    }
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
        Text(label, style: AppFont.dropDowmLabel()),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.containerPopBg,
          ),
          child: DropdownButton<String>(
            value: value,
            hint: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(hint, style: AppFont.dropDown()),
            ),
            icon: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              ),
            ),
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(item, style: AppFont.dropDowmLabel()),
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
}
