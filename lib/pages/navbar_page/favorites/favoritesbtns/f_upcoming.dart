import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_assist/pages/details_pages/followups/followups.dart';
import 'package:smart_assist/utils/storage.dart';

class FUpcoming extends StatefulWidget {
  final String leadId;
  const FUpcoming({super.key, required this.leadId});

  @override
  State<FUpcoming> createState() => _FUpcomingState();
}

class _FUpcomingState extends State<FUpcoming> {
  bool isLoading = true;
  List<dynamic> upcomingTasks = [];
  List<dynamic> overdueTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasksData();
  }

  Future<void> fetchTasksData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.smartassistapp.in/api/favourites/follow-ups/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          upcomingTasks = data['upcomingTasks']['rows'] ?? [];
          overdueTasks = data['overdueTasks']['rows'] ?? [];
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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTasksList(upcomingTasks, isUpcoming: true),
          _buildTasksList(overdueTasks, isUpcoming: false),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(List<dynamic> tasks, {required bool isUpcoming}) {
    if (tasks.isEmpty) {
      return Center(
        child:
            Text('No ${isUpcoming ? "upcoming" : "overdue"} tasks available'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return TaskItem(
          name: task['name'] ?? 'No Name',
          date: task['due_date'] ?? 'No Date',
          vehicle: task['vehicle'] ?? 'Discovery Sport',
          leadId: task['lead_id'] ?? '',
          taskId: task['task_id'] ?? '',
          isFavorite: task['favourite'] ?? false,
          isUpcoming: isUpcoming,
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
  final bool isUpcoming;
  final VoidCallback onFavoriteToggled;

  const TaskItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.taskId,
    required this.isFavorite,
    required this.isUpcoming,
    required this.onFavoriteToggled,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    final token = await Storage.getToken();
    try {
      final response = await http.put(
        Uri.parse(
          'https://api.smartassistapp.in/api/favourites/mark-fav/task/${widget.taskId}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'taskId': widget.taskId, 'favourite': !isFav}),
      );

      if (response.statusCode == 200) {
        setState(() => isFav = !isFav);
        widget.onFavoriteToggled();
      }
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(
              width: 8.0,
              color: widget.isUpcoming ? Colors.green : Colors.red,
            ),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                isFav ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFav ? Colors.amber : Colors.grey,
                size: 40,
              ),
              onPressed: _toggleFavorite,
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
                      Icon(
                        widget.isUpcoming
                            ? Icons.calendar_today
                            : Icons.warning_rounded,
                        color: widget.isUpcoming ? Colors.blue : Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.isUpcoming ? Colors.grey : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              widget.vehicle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                if (widget.leadId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FollowupsDetails(leadId: widget.leadId)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:smart_assist/pages/details_pages/followups/followups.dart';
// import 'package:smart_assist/utils/storage.dart'; 

// class FUpcomingFavorites extends StatefulWidget {
//   final List<dynamic> upcomingFollowups;
//   const FUpcomingFavorites({
//     super.key,
//     required this.upcomingFollowups,
//   });

//   @override
//   State<FUpcomingFavorites> createState() => _FUpcomingFavoritesState();
// }

// class _FUpcomingFavoritesState extends State<FUpcomingFavorites> {
//   bool isLoading = false;
//   List<dynamic> upcomingFollowups = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//   }

//   Future<void> fetchDashboardData() async {
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api.smartassistapp.in/api/favourites/follow-ups/all'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json'
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           upcomingFollowups = data['upcomingFollowups'];
//         });
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.upcomingFollowups.isEmpty) {
//       return const Center(child: Text('No upcoming followups available'));
//     }
//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.upcomingFollowups.length,
//             itemBuilder: (context, index) {
//               var item = widget.upcomingFollowups[index];
//               return (item.containsKey('name') &&
//                       item.containsKey('due_date') &&
//                       item.containsKey('lead_id') &&
//                       item.containsKey('task_id'))
//                   ? UpcomingFollowupItem(
//                       name: item['name'],
//                       date: item['due_date'],
//                       vehicle: 'Discovery Sport',
//                       leadId: item['lead_id'],
//                       taskId: item['task_id'],
//                       isFavorite: item['favourite'] ?? false,
//                       fetchDashboardData: fetchDashboardData,
//                     )
//                   : ListTile(title: Text('Invalid data at index $index'));
//             },
//           );
//   }
// }

// class UpcomingFollowupItem extends StatefulWidget {
//   final String name, date, vehicle, leadId, taskId;
//   final bool isFavorite;
//   final VoidCallback fetchDashboardData;

//   const UpcomingFollowupItem({
//     super.key,
//     required this.name,
//     required this.date,
//     required this.vehicle,
//     required this.leadId,
//     required this.taskId,
//     required this.isFavorite,
//     required this.fetchDashboardData,
//   });

//   @override
//   State<UpcomingFollowupItem> createState() => _UpcomingFollowupItemState();
// }

// class _UpcomingFollowupItemState extends State<UpcomingFollowupItem> {
//   late bool isFav;

//   @override
//   void initState() {
//     super.initState();

//     isFav = widget.isFavorite;
//   }

//   Future<void> _toggleFavorite() async {
//     final token = await Storage.getToken();
//     final url = Uri.parse(
//         'https://api.smartassistapp.in/api/favourites/mark-fav/task/${widget.taskId}');

//     try {
//       final response = await http.put(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json'
//         },
//         body: jsonEncode({'taskId': widget.taskId, 'favourite': !isFav}),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           isFav = !isFav;
//         });
//         widget.fetchDashboardData();
//       } else {
//         print('Failed to update favorite status: ${response.body}');
//       }
//     } catch (e) {
//       print('Error updating favorite status: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//       child: _buildFollowupCard(),
//     );
//   }

//   Widget _buildFollowupCard() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(10),
//         border: const Border(
//             left: BorderSide(
//                 width: 8.0, color: Color.fromARGB(255, 81, 223, 121))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             icon: Icon(isFav ? Icons.star_rounded : Icons.star_border_rounded,
//                 color: isFav ? Colors.amber : Colors.grey, size: 40),
//             onPressed: _toggleFavorite,
//           ),
//           _buildUserDetails(),
//           _buildVerticalDivider(),
//           _buildCarModel(),
//           _buildNavigationButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.name,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             const Icon(Icons.calendar_today, color: Colors.blue, size: 14),
//             const SizedBox(width: 5),
//             Text(widget.date,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildVerticalDivider() {
//     return Container(
//       // margin: const EdgeInsets.only(top: 20),
//       height: 20,
//       width: 1,
//       decoration: const BoxDecoration(
//           border: Border(right: BorderSide(color: Colors.grey))),
//     );
//   }

//   Widget _buildCarModel() {
//     return Text(widget.vehicle,
//         style: const TextStyle(fontSize: 12, color: Colors.grey));
//   }

//   Widget _buildNavigationButton() {
//     return GestureDetector(
//       onTap: () {
//         if (widget.leadId.isNotEmpty) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => FollowupsDetails(leadId: widget.leadId)),
//           );
//         } else {
//           print("Invalid leadId");
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             color: Colors.grey[400], borderRadius: BorderRadius.circular(30)),
//         child: const Icon(Icons.arrow_forward_ios_sharp,
//             size: 25, color: Colors.white),
//       ),
//     );
//   }
// }

// class FOverdueFavorites extends StatefulWidget {
//   final List<dynamic> overdueeFollowups;
//   const FOverdueFavorites({super.key, required this.overdueeFollowups});

//   @override
//   State<FOverdueFavorites> createState() => _FOverdueFavoritesState();
// }

// class _FOverdueFavoritesState extends State<FOverdueFavorites> {
//   bool isLoading = false;
//   List<dynamic> overdueFollowups = [];
//   @override
//   void initState() {
//     super.initState();
//     print("widget.upcomingFollowups");
//     print(widget.overdueeFollowups);
//     fetchDashboardData();
//   }

//   Future<void> fetchDashboardData() async {
//     final token = await Storage.getToken();
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.smartassistapp.in/api/favourites/follow-ups/all'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json'
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           overdueFollowups = data['overdueFollowups'];
//         });
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.overdueeFollowups.isEmpty) {
//       return const Center(
//         child: Text('No upcoming followups available'),
//       );
//     }
//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : ListView.builder(
//             shrinkWrap: true,
//             itemCount: widget.overdueeFollowups.length,
//             itemBuilder: (context, index) {
//               var item = widget.overdueeFollowups[index];
//               if (item.containsKey('name') &&
//                   item.containsKey('due_date') &&
//                   item.containsKey('lead_id') &&
//                   item.containsKey('task_id')) {
//                 return overdueeFollowupsItem(
//                   name: item['name'],
//                   date: item['due_date'],
//                   vehicle: 'Discovery Sport',
//                   taskId: item['task_id'],
//                   leadId: item['lead_id'],
//                   isFavorite: item['favourite'] ?? false,
//                   fetchDashboardData: fetchDashboardData,
//                 );
//               } else {
//                 return ListTile(title: Text('Invalid data at index $index'));
//               }
//             },
//           );
//   }
// }

// class overdueeFollowupsItem extends StatefulWidget {
//   final String name;
//   final String date;
//   final String vehicle;
//   final String leadId;
//   final String taskId;
//   final bool isFavorite;
//   final VoidCallback fetchDashboardData;

//   const overdueeFollowupsItem({
//     super.key,
//     required this.name,
//     required this.date,
//     required this.vehicle,
//     required this.leadId,
//     required this.taskId,
//     required this.isFavorite,
//     required this.fetchDashboardData,
//   });

//   @override
//   State<overdueeFollowupsItem> createState() => _overdueeFollowupsItemState();
// }

// class _overdueeFollowupsItemState extends State<overdueeFollowupsItem> {
//   late bool isFav;
//   @override
//   void initState() {
//     super.initState();
//     isFav = widget.isFavorite;
//   }

//   Future<void> _toggleFavorite() async {
//     final token = await Storage.getToken();
//     final url = Uri.parse(
//         'https://api.smartassistapp.in/api/favourites/mark-fav/task/${widget.taskId}');

//     try {
//       final response = await http.put(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({'taskId': widget.taskId, 'favourite': !isFav}),
//       );

//       if (response.statusCode == 200) {
//         print('this is the url ${url}');
//         setState(() {
//           isFav = !isFav;
//         });
//       } else {
//         print('Failed to update favorite status: ${response.body}');
//         print('this is the url ${url}');
//       }
//     } catch (e) {
//       print('Error updating favorite status: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//       child: SizedBox(
//         height: 80,
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 245, 244, 244),
//             borderRadius: BorderRadius.circular(10),
//             border: const Border(
//               left: BorderSide(width: 8.0, color: Colors.red),
//             ),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   isFav ? Icons.star_rounded : Icons.star_border_rounded,
//                   color: isFav ? Colors.amber : Colors.grey,
//                   size: 40,
//                 ),
//                 onPressed: _toggleFavorite, // Call API on tap
//               ),
//               _buildUserDetails(),
//               _buildVerticalDivider(),
//               _buildCarModel(),
//               _buildNavigationButton(context, widget.leadId),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserDetails() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.name,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: Color.fromARGB(255, 139, 138, 138)),
//         ),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             const Icon(Icons.phone, color: Colors.blue, size: 14),
//             const SizedBox(width: 10),
//             Text(widget.date,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildVerticalDivider() {
//     return Container(
//       margin: const EdgeInsets.only(top: 20),
//       height: 20,
//       width: 1,
//       decoration: const BoxDecoration(
//           border: Border(right: BorderSide(color: Colors.grey))),
//     );
//   }

//   Widget _buildCarModel() {
//     return Container(
//       margin: const EdgeInsets.only(top: 22),
//       child: Text(widget.vehicle,
//           style: const TextStyle(
//               fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)),
//     );
//   }

//   Widget _buildNavigationButton(BuildContext context, String leadId) {
//     return GestureDetector(
//       onTap: () {
//         if (leadId.isNotEmpty) {
//           print("Navigating with leadId: $leadId");
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => FollowupsDetails(leadId: leadId),
//             ),
//           );
//         } else {
//           print("Invalid leadId");
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             color: const Color(0xffD9D9D9),
//             borderRadius: BorderRadius.circular(30)),
//         child: const Icon(Icons.arrow_forward_ios_sharp,
//             size: 25, color: Colors.white),
//       ),
//     );
//   }
// }
