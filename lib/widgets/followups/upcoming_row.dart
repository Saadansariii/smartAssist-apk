import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/Leads/single_details_pages/singleLead_followup.dart';

class FollowupsUpcoming extends StatefulWidget {
  final List<dynamic> upcomingFollowups;
  final bool isNested;
  final Function(String, bool)? onFavoriteToggle;

  const FollowupsUpcoming({
    super.key,
    required this.upcomingFollowups,
    required this.isNested,
    this.onFavoriteToggle,
  });

  @override
  State<FollowupsUpcoming> createState() => _FollowupsUpcomingState();
}

class _FollowupsUpcomingState extends State<FollowupsUpcoming> {
  final Map<String, double> _swipeOffsets = {};

  void _onHorizontalDragUpdate(DragUpdateDetails details, String taskId) {
    setState(() {
      _swipeOffsets[taskId] =
          (_swipeOffsets[taskId] ?? 0) + (details.primaryDelta ?? 0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details, dynamic item, int index) {
    String taskId = item['task_id'];
    double swipeOffset = _swipeOffsets[taskId] ?? 0;

    if (swipeOffset > 100) {
      // Right Swipe (Favorite)
      _toggleFavorite(taskId, index);
    } else if (swipeOffset < -100) {
      // Left Swipe (Call)
      _handleCall(item);
    }

    // Reset animation
    setState(() {
      _swipeOffsets[taskId] = 0.0;
    });
  }

  Future<void> _toggleFavorite(String taskId, int index) async {
    bool newFavoriteStatus =
        !(widget.upcomingFollowups[index]['favourite'] ?? false);

    setState(() {
      widget.upcomingFollowups[index]['favourite'] = newFavoriteStatus;
    });

    if (widget.onFavoriteToggle != null) {
      widget.onFavoriteToggle!(taskId, newFavoriteStatus);
    }

    print(
        "Favorite toggled for Task ID: $taskId, New Status: $newFavoriteStatus");
  }

  void _handleCall(dynamic item) {
    print("Call action triggered for ${item['name']}");
    // Implement actual call functionality here
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upcomingFollowups.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: Text(
            'No upcoming followups available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: widget.isNested
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      itemCount: widget.upcomingFollowups.length,
      itemBuilder: (context, index) {
        var item = widget.upcomingFollowups[index];

        if (!(item.containsKey('name') &&
            item.containsKey('due_date') &&
            item.containsKey('lead_id') &&
            item.containsKey('task_id'))) {
          return ListTile(title: Text('Invalid data at index $index'));
        }

        String taskId = item['task_id'];
        double swipeOffset = _swipeOffsets[taskId] ?? 0;

        return GestureDetector(
          onHorizontalDragUpdate: (details) =>
              _onHorizontalDragUpdate(details, taskId),
          onHorizontalDragEnd: (details) =>
              _onHorizontalDragEnd(details, item, index),
          child: UpcomingFollowupItem(
            name: item['name'],
            date: item['due_date'],
            vehicle: 'Discovery Sport',
            leadId: item['lead_id'],
            taskId: taskId,
            isFavorite: item['favourite'] ?? false,
            swipeOffset: swipeOffset,
            fetchDashboardData:
                () {}, // Placeholder, replace with actual method
          ),
        );
      },
    );
  }
}

class UpcomingFollowupItem extends StatelessWidget {
  final String name, date, vehicle, leadId, taskId;
  final bool isFavorite;
  final double swipeOffset;
  final VoidCallback fetchDashboardData;

  const UpcomingFollowupItem({
    super.key,
    required this.name,
    required this.date,
    required this.vehicle,
    required this.leadId,
    required this.taskId,
    required this.isFavorite,
    required this.swipeOffset,
    required this.fetchDashboardData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: _buildFollowupCard(context),
    );
  }

  Widget _buildFollowupCard(BuildContext context) {
    bool isFavoriteSwipe = swipeOffset > 50;
    bool isCallSwipe = swipeOffset < -50;

    // Gradient background for swipe
    LinearGradient _buildSwipeGradient() {
      if (isFavoriteSwipe) {
        return LinearGradient(
          colors: [
            Colors.yellow.withOpacity(0.2),
            Colors.yellow.withOpacity(0.8)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      } else if (isCallSwipe) {
        return LinearGradient(
          colors: [
            Colors.green.withOpacity(0.2),
            Colors.green.withOpacity(0.8)
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        );
      }
      return LinearGradient(
        colors: [AppColors.containerBg, AppColors.containerBg],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    }

    return Stack(
      children: [
        // Favorite Swipe Overlay
        if (isFavoriteSwipe)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow.withOpacity(0.2),
                    Colors.yellow.withOpacity(0.8)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 5),
                    Icon(Icons.star_rounded,
                        color: Colors.yellow.withOpacity(0.7), size: 40),
                    const SizedBox(width: 10),
                    Text('Favorite',
                        style: GoogleFonts.poppins(
                            color: Colors.yellow.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),

        // Call Swipe Overlay
        if (isCallSwipe)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.2),
                    Colors.green.withOpacity(0.8)
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.phone_in_talk,
                        color: Colors.white, size: 30),
                    const SizedBox(width: 10),
                    Text('Call',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),

        // Main Container
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: _buildSwipeGradient(),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              left: BorderSide(
                width: 8.0,
                color: isFavorite
                    ? (isFavoriteSwipe
                        ? Colors.yellow.withOpacity(0.1)
                        : Colors.yellow.withOpacity(0.9))
                    : (isFavoriteSwipe
                        ? Colors.yellow.withOpacity(0.1)
                        : (isCallSwipe
                            ? Colors.green.withOpacity(0.1)
                            : AppColors.sideGreen)),
              ),
            ),
          ),
          child: Opacity(
            opacity: (isFavoriteSwipe || isCallSwipe) ? 0 : 1.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Conditional favorite star
                    // if (isFavorite || isFavoriteSwipe)
                    //   Icon(
                    //     Icons.star_rounded,
                    //     color: isFavoriteSwipe
                    //         ? Colors.white
                    //         : AppColors.starColorsYellow,
                    //     size: 40,
                    //   ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserDetails(),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _date(),
                            _buildVerticalDivider(20),
                            _buildCarModel(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                _buildNavigationButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildFollowupCard(BuildContext context) {
  //   bool isFavoriteSwipe = swipeOffset > 50;

  //   // Gradient background for swipe
  //   LinearGradient _buildSwipeGradient() {
  //     return LinearGradient(
  //       colors: isFavoriteSwipe
  //           ? [Colors.yellow.withOpacity(0.2), Colors.yellow.withOpacity(0.8)]
  //           : [AppColors.containerBg, AppColors.containerBg],
  //       begin: Alignment.centerLeft,
  //       end: Alignment.centerRight,
  //     );
  //   }

  //   return Stack(
  //     children: [
  //       // Swipe Overlay
  //       if (isFavoriteSwipe)
  //         Positioned.fill(
  //           child: Container(
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [
  //                   Colors.yellow.withOpacity(0.2),
  //                   Colors.yellow.withOpacity(0.8)
  //                 ],
  //                 begin: Alignment.centerLeft,
  //                 end: Alignment.centerRight,
  //               ),
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Center(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   const SizedBox(
  //                     width: 5,
  //                   ),
  //                   Icon(Icons.star_rounded,
  //                       color: Colors.yellow.withOpacity(0.7), size: 40),
  //                   const SizedBox(width: 10),
  //                   Text('Favorite',
  //                       style: GoogleFonts.poppins(
  //                           color: Colors.yellow.withOpacity(0.9),
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold)),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),

  //       // Main Container
  //       Container(
  //         padding: const EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           gradient: _buildSwipeGradient(),
  //           borderRadius: BorderRadius.circular(10),
  //           border: Border(
  //             left: BorderSide(
  //                 width: 8.0,
  //                 color: isFavoriteSwipe
  //                     ? Colors.yellow.withOpacity(0.1)
  //                     : AppColors.sideGreen),
  //           ),
  //         ),
  //         child: Opacity(
  //           opacity: isFavoriteSwipe ? 0 : 1.0,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Row(
  //                 children: [
  //                   // Conditional favorite star
  //                   if (isFavorite || isFavoriteSwipe)
  //                     Icon(
  //                       Icons.star_rounded,
  //                       color: isFavoriteSwipe
  //                           ? Colors.white
  //                           : AppColors.starColorsYellow,
  //                       size: 40,
  //                     ),
  //                   const SizedBox(width: 8),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       _buildUserDetails(),
  //                       const SizedBox(height: 4),
  //                       Row(
  //                         children: [
  //                           _date(),
  //                           _buildVerticalDivider(20),
  //                           _buildCarModel(),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               _buildNavigationButton(context),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildNavigationButton(BuildContext context) {
    // ✅ Accept context
    return GestureDetector(
      onTap: () {
        if (leadId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FollowupsDetails(leadId: leadId)),
          );
        } else {
          print("Invalid leadId");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: AppColors.arrowContainerColor,
            borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.arrow_forward_ios_rounded,
            size: 25, color: Colors.white),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: GoogleFonts.poppins(
                color: AppColors.fontColor,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _date() {
    String formattedDate = '';
    try {
      DateTime parseDate = DateTime.parse(date);
      formattedDate = DateFormat('dd MMM').format(parseDate);
    } catch (e) {
      formattedDate = date;
    }
    return Row(
      children: [
        const Icon(Icons.phone_in_talk, color: Colors.blue, size: 14),
        const SizedBox(width: 5),
        Text(formattedDate,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildVerticalDivider(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      width: 1,
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: AppColors.fontColor))),
    );
  }

  Widget _buildCarModel() {
    return Text(
      vehicle,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(fontSize: 10, color: AppColors.fontColor),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}


 
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; 
// import 'package:intl/intl.dart';
// import 'package:smart_assist/config/component/color/colors.dart'; 
// import 'package:smart_assist/pages/Leads/single_details_pages/singleLead_followup.dart';

// class FollowupsUpcoming extends StatefulWidget {
//   final List<dynamic> upcomingFollowups;
//   final bool isNested;
//   const FollowupsUpcoming({
//     super.key,
//     required this.upcomingFollowups,
//     required this.isNested,

//   });

//   @override
//   State<FollowupsUpcoming> createState() => _FollowupsUpcomingState();
// }

// class _FollowupsUpcomingState extends State<FollowupsUpcoming> {
//   double _swipeOffset = 0.0;

//   void _onHorizontalDragUpdate(DragUpdateDetails details) {
//     setState(() {
//       _swipeOffset += details.primaryDelta ?? 0;
//     });
//   }

//   void _onHorizontalDragEnd(DragEndDetails details, String taskId, int index) {
//     if (_swipeOffset > 100) {
//       // Right Swipe (Favorite)
//       _toggleFavorite(taskId, index);
//     } else if (_swipeOffset < -100) {
//       // Left Swipe (Call)
//       print(
//           "Call action triggered for ${widget.upcomingFollowups[index]['name']}");
//     }

//     // Reset animation
//     setState(() {
//       _swipeOffset = 0.0;
//     });
//   }

//   Future<void> _toggleFavorite(String taskId, int index) async {
//     setState(() {
//       widget.upcomingFollowups[index]['favourite'] =
//           !(widget.upcomingFollowups[index]['favourite'] ?? false);
//     });

//     // Simulating API Call (Replace with actual API request)
//     await Future.delayed(Duration(milliseconds: 500));

//     print("Favorite toggled for Task ID: $taskId");
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.upcomingFollowups.isEmpty) {
//       return const SizedBox(
//         height: 240,
//         child: Center(child: Text('No upcoming followups available')),
//       );
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: widget.isNested
//           ? const NeverScrollableScrollPhysics()
//           : const AlwaysScrollableScrollPhysics(),
//       itemCount: widget.upcomingFollowups.length,
//       itemBuilder: (context, index) {
//         var item = widget.upcomingFollowups[index];

//         if (!(item.containsKey('name') &&
//             item.containsKey('due_date') &&
//             item.containsKey('lead_id') &&
//             item.containsKey('task_id'))) {
//           return ListTile(title: Text('Invalid data at index $index'));
//         }

//         return GestureDetector(
//           onHorizontalDragUpdate: _onHorizontalDragUpdate,
//           onHorizontalDragEnd: (details) =>
//               _onHorizontalDragEnd(details, item['task_id'], index),
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: _swipeOffset > 50
//                   ? Colors.yellow // Right Swipe (Favorite)
//                   : _swipeOffset < -50
//                       ? Colors.blue // Left Swipe (Call)
//                       : Colors.white, // Default
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Left Side (Favorite)
//                 if (_swipeOffset > 50)
//                   Row(
//                     children: [
//                       Icon(Icons.star_rounded, color: Colors.white, size: 30),
//                       SizedBox(width: 10),
//                       Text("Prime",
//                           style: GoogleFonts.poppins(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600)),
//                     ],
//                   ),

//                 // Middle (Task Info)
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(item['name'],
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 5),
//                       Text(item['due_date'],
//                           style: TextStyle(fontSize: 14, color: Colors.grey)),
//                     ],
//                   ),
//                 ),

//                 // Right Side (Call)
//                 if (_swipeOffset < -50)
//                   Row(
//                     children: [
//                       Text("Call",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                       SizedBox(width: 10),
//                       Icon(Icons.phone, color: Colors.white, size: 28),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class UpcomingFollowupItem extends StatelessWidget {
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
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//       child: _buildFollowupCard(context), // ✅ Pass context here
//     );
//   }

//   Widget _buildFollowupCard(BuildContext context) {
//     // ✅ Accept context
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: AppColors.containerBg,
//         borderRadius: BorderRadius.circular(10),
//         border: const Border(
//           left: BorderSide(width: 8.0, color: AppColors.sideGreen),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               if (isFavorite)
//                 const Icon(
//                   Icons.star_rounded,
//                   color: AppColors.starColorsYellow,
//                   size: 40,
//                 ),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildUserDetails(),
//                   const SizedBox(
//                       height: 4), // Spacing between user details and date-car
//                   Row(
//                     children: [
//                       _date(),
//                       _buildVerticalDivider(20),
//                       _buildCarModel(),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           _buildNavigationButton(context), // ✅ Pass context here
//         ],
//       ),
//     );
//   }

//   Widget _buildNavigationButton(BuildContext context) {
//     // ✅ Accept context
//     return GestureDetector(
//       onTap: () {
//         if (leadId.isNotEmpty) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => FollowupsDetails(leadId: leadId)),
//           );
//         } else {
//           print("Invalid leadId");
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//             color: AppColors.arrowContainerColor,
//             borderRadius: BorderRadius.circular(30)),
//         child: const Icon(Icons.arrow_forward_ios_rounded,
//             size: 25, color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildUserDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(name,
//             style: GoogleFonts.poppins(
//                 color: AppColors.fontColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14)),
//         const SizedBox(height: 5),
//       ],
//     );
//   }

//   Widget _date() {
//     String formattedDate = '';
//     try {
//       DateTime parseDate = DateTime.parse(date);
//       formattedDate = DateFormat('dd MMM').format(parseDate);
//     } catch (e) {
//       formattedDate = date;
//     }
//     return Row(
//       children: [
//         const Icon(Icons.phone_in_talk, color: Colors.blue, size: 14),
//         const SizedBox(width: 5),
//         Text(formattedDate,
//             style: const TextStyle(fontSize: 12, color: Colors.grey)),
//       ],
//     );
//   }

//   Widget _buildVerticalDivider(double height) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       height: height,
//       width: 1,
//       decoration: const BoxDecoration(
//           border: Border(right: BorderSide(color: AppColors.fontColor))),
//     );
//   }

//   Widget _buildCarModel() {
//     return Text(
//       vehicle,
//       textAlign: TextAlign.start,
//       style: GoogleFonts.poppins(fontSize: 10, color: AppColors.fontColor),
//       softWrap: true,
//       overflow: TextOverflow.visible,
//     );
//   }
// }
