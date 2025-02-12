// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_assist/utils/bottom_navigation.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:smart_assist/utils/storage.dart';

// class LeadsAll extends StatefulWidget {
//   const LeadsAll({super.key});

//   @override
//   State<LeadsAll> createState() => _LeadsAllState();
// }

// class _LeadsAllState extends State<LeadsAll> {
//   bool isLoading = true;
//   List<dynamic> leadsList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchLeadsData();
//   }

//   Future<void> fetchLeadsData() async {
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.smartassistapp.in/api/leads/all'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           leadsList = data['rows'] ?? []; // Check if 'rows' key exists
//           isLoading = false;
//         });
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BottomNavigation()),
//             );
//           },
//           icon: const Icon(
//             FontAwesomeIcons.angleLeft,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'Leads List',
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue,
//         automaticallyImplyLeading: false,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator()) // Show loader
//           : leadsList.isEmpty
//               ? const Center(
//                   child: Text(
//                     "No Leads Available",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                 )
//               : _buildLeadsList(),
//     );
//   }

//   Widget _buildLeadsList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(10),
//       itemCount: leadsList.length,
//       itemBuilder: (context, index) {
//         var lead = leadsList[index];
//         return _buildLeadItem(lead);
//       },
//     );
//   }

//   Widget _buildLeadItem(dynamic lead) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(12),
//         leading: CircleAvatar(
//           backgroundColor: Colors.blue[100],
//           child: const Icon(FontAwesomeIcons.user, color: Colors.blue),
//         ),
//         title: Text(
//           lead['name'] ?? 'Unknown',
//           style: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 5),
//             Row(
//               children: [
//                 const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
//                 const SizedBox(width: 5),
//                 Text(
//                   lead['due_date'] ?? 'No Date',
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 const Icon(Icons.directions_car, size: 14, color: Colors.grey),
//                 const SizedBox(width: 5),
//                 Text(
//                   lead['vehicle'] ?? 'Unknown Vehicle',
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//         onTap: () {
//           // if (lead['lead_id'] != null) {
//           //   Navigator.pushNamed(
//           //     context,
//           //     '/followup-details',
//           //     arguments: lead['lead_id'],
//           //   );
//           // }
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_assist/utils/bottom_navigation.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:smart_assist/utils/storage.dart';

// class LeadsAll extends StatefulWidget {
//   const LeadsAll({super.key});

//   @override
//   State<LeadsAll> createState() => _LeadsAllState();
// }

// class _LeadsAllState extends State<LeadsAll> {
//   bool isLoading = true;
//   List<dynamic> upcomingTasks = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTasksData();
//   }

//   Future<void> fetchTasksData() async {
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.smartassistapp.in/api/leads/all'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print('this is the leadall $data');
//         setState(() {
//           upcomingTasks = data['rows'] ?? [];
//           isLoading = false;
//         });
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BottomNavigation()),
//             );
//           },
//           icon: const Icon(
//             FontAwesomeIcons.angleLeft,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'Leads List',
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue,
//         automaticallyImplyLeading: false,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTasksList(upcomingTasks),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildTasksList(List<dynamic> tasks) {
//     if (tasks.isEmpty) {
//       return const Center(child: Text('No Leads available'));
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         var task = tasks[index];
//         return TaskItem(
//           // name: "${task['fname'] ?? ''} ${task['lname'] ?? ''}".trim(),
//           name: task['fname'],
//           date: task['expected_date_purchase'] ?? 'No Date',
//           vehicle: task['PMI'] ?? 'Unknown Vehicle',
//           leadId: task['lead_id'] ?? '',
//           taskId: task['task_id'] ?? '',
//           isFavorite: task['favourite'] ?? false,
//           onFavoriteToggled: fetchTasksData,
//         );
//       },
//     );
//   }
// }

// class TaskItem extends StatefulWidget {
//   final String name;
//   final String date;
//   final String vehicle;
//   final String leadId;
//   final String taskId;
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggled;

//   const TaskItem({
//     super.key,
//     required this.name,
//     required this.date,
//     required this.vehicle,
//     required this.leadId,
//     required this.taskId,
//     required this.isFavorite,
//     required this.onFavoriteToggled,
//   });

//   @override
//   State<TaskItem> createState() => _TaskItemState();
// }

// class _TaskItemState extends State<TaskItem> {
//   late bool isFav;

//   @override
//   void initState() {
//     super.initState();
//     isFav = widget.isFavorite;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//           border: const Border(
//             left: BorderSide(
//               width: 8.0,
//               color: Colors.green,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               isFav ? Icons.star_rounded : Icons.star_border_rounded,
//               color: isFav ? Colors.amber : Colors.grey,
//               size: 40,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.name,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const Icon(Icons.calendar_today,
//                           color: Colors.blue, size: 14),
//                       const SizedBox(width: 8),
//                       Text(
//                         widget.date,
//                         style:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(30)),
//               child: const Icon(Icons.arrow_forward_ios_sharp,
//                   size: 25, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_assist/pages/calenderPages/tasks/addTask.dart';
// import 'package:smart_assist/utils/bottom_navigation.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:smart_assist/utils/storage.dart';

// class LeadsAll extends StatefulWidget {
//   const LeadsAll({super.key});

//   @override
//   State<LeadsAll> createState() => _LeadsAllState();
// }

// class _LeadsAllState extends State<LeadsAll> {
//   bool isLoading = true;
//   List<dynamic> upcomingTasks = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTasksData();
//   }

//   Future<void> fetchTasksData() async {
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.smartassistapp.in/api/leads/all'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print('this is the leadall \$data');
//         setState(() {
//           upcomingTasks = data['rows'] ?? [];
//           isLoading = false;
//         });
//       } else {
//         print("Failed to load data: \${response.statusCode}");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Error fetching data: \$e");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BottomNavigation()),
//             );
//           },
//           icon: const Icon(
//             FontAwesomeIcons.angleLeft,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'Leads List',
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue,
//         automaticallyImplyLeading: false,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTasksList(upcomingTasks),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildTasksList(List<dynamic> tasks) {
//     if (tasks.isEmpty) {
//       return const Center(child: Text('No Leads available'));
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         var task = tasks[index];
//         return TaskItem(
//           name: task['fname'],
//           date: task['expected_date_purchase'] ?? 'No Date',
//           vehicle: task['PMI'] ?? 'Unknown Vehicle',
//           leadId: task['lead_id'] ?? '',
//           taskId: task['task_id'] ?? '',
//           isFavorite: task['favourite'] ?? false,
//           onFavoriteToggled: fetchTasksData,
//         );
//       },
//     );
//   }
// }

// class TaskItem extends StatefulWidget {
//   final String name;
//   final String date;
//   final String vehicle;
//   final String leadId;
//   final String taskId;
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggled;

//   const TaskItem({
//     super.key,
//     required this.name,
//     required this.date,
//     required this.vehicle,
//     required this.leadId,
//     required this.taskId,
//     required this.isFavorite,
//     required this.onFavoriteToggled,
//   });

//   @override
//   State<TaskItem> createState() => _TaskItemState();
// }

// class _TaskItemState extends State<TaskItem> {
//   late bool isFav;

//   @override
//   void initState() {
//     super.initState();
//     isFav = widget.isFavorite;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         final selectedLead = await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AddTaskPopup(leadId: widget.leadId),
//           ),
//         );

//         if (selectedLead != null) {
//           widget.onFavoriteToggled(); // Refresh the list after returning
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(10),
//             border: const Border(
//               left: BorderSide(
//                 width: 8.0,
//                 color: Colors.green,
//               ),
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 isFav ? Icons.star_rounded : Icons.star_border_rounded,
//                 color: isFav ? Colors.amber : Colors.grey,
//                 size: 40,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.name,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.calendar_today,
//                             color: Colors.blue, size: 14),
//                         const SizedBox(width: 8),
//                         Text(
//                           widget.date,
//                           style:
//                               const TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     color: Colors.grey[400],
//                     borderRadius: BorderRadius.circular(30)),
//                 child: const Icon(Icons.arrow_forward_ios_sharp,
//                     size: 25, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/pages/calenderPages/tasks/addTask.dart';
import 'package:smart_assist/utils/storage.dart';

class LeadsAll extends StatefulWidget {
  const LeadsAll({super.key});

  @override
  State<LeadsAll> createState() => _LeadsAllState();
}

class _LeadsAllState extends State<LeadsAll> {
  bool isLoading = true;
  List<dynamic> upcomingTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasksData();
  }

  Future<void> fetchTasksData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/leads/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          upcomingTasks = data['rows'] ?? [];
          isLoading = false;
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leads All',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextField(
                      // controller: searchController,
                      // onChanged: _filterTasks,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFE1EFFF),
                        contentPadding: const EdgeInsets.fromLTRB(1, 4, 0, 4),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        suffixIcon: const Icon(Icons.mic, color: Colors.grey),
                      ),
                    ),
                  ),
                  _buildTasksList(upcomingTasks),
                ],
              ),
            ),
    );
  }

  Widget _buildTasksList(List<dynamic> tasks) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No Leads available'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return TaskItem(
          name: task['fname'],
          date: task['expected_date_purchase'] ?? 'No Date',
          vehicle: task['PMI'] ?? 'Unknown Vehicle',
          leadId: task['lead_id'] ?? '',
          taskId: task['task_id'] ?? '',
          isFavorite: task['favourite'] ?? false,
          onFavoriteToggled: fetchTasksData,
        );
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final String name;
  final String date;
  final String vehicle;
  final String leadId;
  final String taskId;
  final bool isFavorite;
  final VoidCallback onFavoriteToggled;

  const TaskItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.taskId,
    required this.isFavorite,
    required this.onFavoriteToggled,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isFav;
  String? leadId;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Instead of showing the popup, we'll return the selected lead info
        Navigator.pop(context, {
          'leadId': widget.leadId,
          'leadName': widget.name,
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              left: BorderSide(
                width: 8.0,
                color: Colors.green,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isFav ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFav ? Colors.amber : Colors.grey,
                size: 40,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.blue, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          widget.date,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.arrow_forward_ios_sharp,
                    size: 25, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AddTaskPopup extends StatefulWidget {
//   final String leadId;
//   const AddTaskPopup({super.key, required this.leadId});

//   @override
//   State<AddTaskPopup> createState() => _AddTaskPopupState();
// }

// class _AddTaskPopupState extends State<AddTaskPopup> {
//   bool isLoading = true;
//   Map<String, dynamic>? leadData;

//   @override
//   void initState() {
//     super.initState();
//     fetchLeadDetails();
//   }

//   Future<void> fetchLeadDetails() async {
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.smartassistapp.in/api/leads/${widget.leadId}'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           leadData = data;
//           isLoading = false;
//         });
//       } else {
//         print("Failed to load lead details: ${response.statusCode}");
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Error fetching lead details: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     leadData?['fname'] ?? "Unknown Lead",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text("Lead ID: ${widget.leadId}"),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context, widget.leadId);
//                     },
//                     child: const Text("Select This Lead"),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
