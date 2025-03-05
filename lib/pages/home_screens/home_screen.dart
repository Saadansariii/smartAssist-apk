import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
import 'package:smart_assist/pages/navbar_page/app_setting.dart';
import 'package:smart_assist/pages/navbar_page/favorite.dart';
import 'package:smart_assist/pages/navbar_page/leads_all.dart';
import 'package:smart_assist/pages/navbar_page/logout_page.dart';
import 'package:smart_assist/pages/notification/notification.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/storage.dart';
import 'package:smart_assist/widgets/home_btn.dart/bottom_btn_second.dart';
import 'package:smart_assist/widgets/home_btn.dart/threebtn.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String greeting;
  final String leadId;

  const HomeScreen({
    super.key,
    required this.greeting,
    required this.leadId,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? leadId;
  String greeting = '';
  int notificationCount = 0;
  int overdueFollowupsCount = 0;
   int overdueAppointmentsCount = 0;
  List<dynamic> upcomingFollowups = [];
  List<dynamic> overdueFollowups = [];
  List<dynamic> upcomingAppointments = [];
  List<dynamic> overdueAppointments = [];
  bool isDashboardLoading = false;

  // Search Functionality
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoadingSearch = false;
  String _query = '';

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchDashboardData() async {
    setState(() {
      isDashboardLoading = true;
    });
    try {
      final data = await LeadsSrv.fetchDashboardData();
      setState(() {
        upcomingFollowups = data['upcomingFollowups'];
        overdueFollowups = data['overdueFollowups'];
        upcomingAppointments = data['upcomingAppointments'];
        overdueAppointments = data['overdueAppointments'];
        overdueFollowupsCount = data.containsKey('overdueFollowupsCount') && data['overdueFollowupsCount'] is int ? data['overdueFollowupsCount'] : 0;
        overdueAppointmentsCount = data.containsKey('overdueAppointmentsCount') && data['overdueAppointmentsCount'] is int ? data['overdueAppointmentsCount'] : 0;
        notificationCount =
            data.containsKey('notifications') && data['notifications'] is int
                ? data['notifications']
                : 0;
        greeting =
            (data.containsKey('greetings') && data['greetings'] is String)
                ? data['greetings']
                : 'Welcome!';
        // if (upcomingFollowups.isNotEmpty) {
        //   leadId = upcomingFollowups[0]['lead_id'];
        // }
      });
    } catch (e) {
      showErrorMessage(context, message: e.toString());
    } finally {
      setState(() {
        isDashboardLoading = false;
      });
    }
  }

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

// Your HomeScreen Code
  @override
  Widget build(BuildContext context) {
// final height = MediaQuery.of(context).size.height * 1;  use it for dynamic height as per the mobile 
//  height * .2 not use like that 100 & 200


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF1380FE),
          title: Text(
            ' $greeting',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()),
                    );
                  },
                  icon: const Icon(Icons.notifications),
                  color: Colors.white,
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 12,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 5,
                        minHeight: 5,
                      ),
                      child: Text(
                        notificationCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
        body: Stack(
          children: [
            /// ✅ Main content behind the search box
            SafeArea(
              child: RefreshIndicator(
                onRefresh: fetchDashboardData,
                child: isDashboardLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),

                            /// ✅ Row with Menu, Search Bar, and Microphone
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      color: AppColors.fontColor),
                                  onPressed: () {
                                    Get.bottomSheet(Container(
                                      padding: const EdgeInsets.all(16),
                                      height: 320,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30)),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.search,
                                                size: 28),
                                            title: Text('Leads',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18)),
                                            onTap: () =>
                                                Get.to(() => const AllLeads()),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.star_border_outlined,
                                                size: 28),
                                            title: Text('Favorites',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18)),
                                            onTap: () => Get.to(() =>
                                                const FavoritePage(leadId: '')),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.person_outline,
                                                size: 28),
                                            title: Text('Profile',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18)),
                                            onTap: () => Get.back(),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.settings_outlined,
                                                size: 28),
                                            title: Text('App Settings',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18)),
                                            onTap: () => Get.to(
                                                () => const AppSetting()),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.logout_outlined,
                                                size: 28),
                                            title: Text('Logout',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18)),
                                            onTap: () => Get.to(
                                                () => const LogoutPage()),
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: _searchController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        filled: true,
                                        fillColor: AppColors.searchBar,
                                        hintText: 'Search',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        suffixIcon: const Icon(
                                          FontAwesomeIcons.magnifyingGlass,
                                          color: AppColors.fontColor,
                                          size: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.microphone,
                                      size: 18, color: AppColors.fontColor),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                            /// ✅ Other UI Components (Follow-ups, Buttons, etc.)
                            const SizedBox(height: 3),
                            Threebtn(
                              leadId: leadId ?? 'empty',
                              upcomingFollowups: upcomingFollowups,
                              overdueFollowups: overdueFollowups,
                              upcomingAppointments: upcomingAppointments,
                              overdueAppointments: overdueAppointments,
                              refreshDashboard: fetchDashboardData,
                              overdueFollowupsCount : overdueFollowupsCount,
                              overdueAppointmentsCount : overdueAppointmentsCount,
                            ),
                            const BottomBtnSecond(),
                          ],
                        ),
                      ),
              ),
            ),

            /// ✅ Search Results Overlay (Doesn't push content down)
            if (_isLoadingSearch || _searchResults.isNotEmpty)
              Positioned(
                top: 50, // Position it below the search bar
                left: 20,
                right: 20,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 300,
                    // padding: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: 1,
                      //     blurRadius: 5,
                      //   ),
                      // ],
                    ),
                    child: _isLoadingSearch
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final result = _searchResults[index];
                              return ListTile(
                                onTap: () {
                                  // Navigate to the new screen with the lead_id
                                  Get.to(() => SingleLeadsById(
                                      leadId: result['lead_id']));
                                },
                                title: Text(
                                  result['lead_name'] ?? 'No Name',
                                  style: AppFont.searchFontTitle(),
                                ),
                                subtitle: Text(
                                  result['email'] ?? 'No Email',
                                  style: AppFont.searchFontSubtitle(),
                                ),
                                leading: const Icon(Icons.person),
                              );
                            },
                          ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xFF1380FE),
//           title: Text(
//             ' $greeting',
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: Colors.white,
//             ),
//           ),
//           actions: [
//             Stack(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const NotificationPage()));
//                   },
//                   icon: const Icon(Icons.notifications),
//                   color: Colors.white,
//                 ),
//                 if (notificationCount > 0) // ✅ Only show badge if count > 0
//                   Positioned(
//                     right: 12, // Adjust position (horizontal)
//                     top: 10, // Adjust position (vertical)
//                     child: Container(
//                       padding: const EdgeInsets.all(1),
//                       decoration: const BoxDecoration(
//                         color: Colors.red, // Badge color
//                         shape: BoxShape.circle,
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 5,
//                         minHeight: 5,
//                       ),
//                       child: Text(
//                         notificationCount.toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 7,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//               ],
//             )
//           ],
//         ),
//         body: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: fetchDashboardData,
//             child: isDashboardLoading
//                 ? const Center(
//                     child:
//                         CircularProgressIndicator()) // Show loader when refreshing
//                 : SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 5),

//                         // ✅ Row with Menu, Search Bar, and Microphone
//                         Row(
//                           children: [
//                             // ✅ Menu Icon
//                             IconButton(
//                               icon: const Icon(Icons.menu,
//                                   color: AppColors.fontColor),
//                               onPressed: () {
//                                 Get.bottomSheet(Container(
//                                   padding: const EdgeInsets.all(16),
//                                   height: 320,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(30)),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       ListTile(
//                                         leading:
//                                             const Icon(Icons.search, size: 28),
//                                         title: Text('Leads',
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 18)),
//                                         onTap: () =>
//                                             Get.to(() => const AllLeads()),
//                                       ),
//                                       ListTile(
//                                         leading: const Icon(
//                                             Icons.star_border_outlined,
//                                             size: 28),
//                                         title: Text('Favorites',
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 18)),
//                                         onTap: () => Get.to(() =>
//                                             const FavoritePage(leadId: '')),
//                                       ),
//                                       ListTile(
//                                         leading: const Icon(
//                                             Icons.person_outline,
//                                             size: 28),
//                                         title: Text('Profile',
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 18)),
//                                         onTap: () => Get.back(),
//                                       ),
//                                       ListTile(
//                                         leading: const Icon(
//                                             Icons.settings_outlined,
//                                             size: 28),
//                                         title: Text('App Settings',
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 18)),
//                                         onTap: () =>
//                                             Get.to(() => const AppSetting()),
//                                       ),
//                                       ListTile(
//                                         leading: const Icon(
//                                             Icons.logout_outlined,
//                                             size: 28),
//                                         title: Text('Logout',
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 18)),
//                                         onTap: () =>
//                                             Get.to(() => const LogoutPage()),
//                                       ),
//                                     ],
//                                   ),
//                                 ));
//                               },
//                             ),

//                             // ✅ Search Bar
//                             Expanded(
//                               child: SizedBox(
//                                 height: 35,
//                                 child: TextField(
//                                   controller: _searchController,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding:
//                                         const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                     filled: true,
//                                     fillColor: AppColors.searchBar,
//                                     hintText: 'Search',
//                                     hintStyle: GoogleFonts.poppins(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w300),
//                                     suffixIcon: const Icon(
//                                       FontAwesomeIcons.magnifyingGlass,
//                                       color: AppColors.fontColor,
//                                       size: 15,
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             // ✅ Microphone Icon
//                             IconButton(
//                               icon: const Icon(FontAwesomeIcons.microphone,
//                                   size: 18, color: AppColors.fontColor),
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),

//                         if (_isLoadingSearch)
//                           const Padding(
//                             padding: EdgeInsets.all(10),
//                             child: CircularProgressIndicator(),
//                           ),

//                         // ✅ Show Search Results if Available
//                         if (_searchResults.isNotEmpty)
//                           Container(
//                             height: 200,
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                 ),
//                               ],
//                             ),
//                             child: ListView.builder(
//                               itemCount: _searchResults.length,
//                               itemBuilder: (context, index) {
//                                 final result = _searchResults[index];
//                                 return ListTile(
//                                   title: Text(result['lead_name'] ?? 'No Name'),
//                                   subtitle: Text(result['email'] ?? 'No Email'),
//                                   leading: const Icon(Icons.person),
//                                 );
//                               },
//                             ),
//                           ),

//                         const SizedBox(
//                           height: 3,
//                         ),
//                         isDashboardLoading
//                             ? const Center(
//                                 child:
//                                     CircularProgressIndicator()) // Show loader only when data is loading
//                             : Threebtn(
//                                 leadId: leadId ?? 'empty',
//                                 upcomingFollowups: upcomingFollowups,
//                                 overdueFollowups: overdueFollowups,
//                                 upcomingAppointments: upcomingAppointments,
//                                 overdueAppointments: overdueAppointments,
//                                 refreshDashboard: fetchDashboardData,
//                               ),
//                         const BottomBtnSecond(),
//                       ],
//                     ),
//                   ),
//           ),
//         ));
//   }
// }
