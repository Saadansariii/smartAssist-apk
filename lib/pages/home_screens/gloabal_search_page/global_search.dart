// import 'package:flutter/material.dart';

// class GlobalSearch extends StatefulWidget {
//   const GlobalSearch({super.key});

//   @override
//   State<GlobalSearch> createState() => _GlobalSearchState();
// }

// class _GlobalSearchState extends State<GlobalSearch> {

// // Search Functionality
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _searchResults = [];
//   bool _isLoadingSearch = false;
//   String _query = '';

//    @override
//   void initState() {
//     super.initState();
//     // fetchDashboardData();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//    Future<void> _fetchSearchResults(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults.clear();
//       });
//       return;
//     }

//     setState(() {
//       _isLoadingSearch = true;
//     });

//     final token = await Storage.getToken();

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api.smartassistapp.in/api/search/global?query=$query'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         setState(() {
//           _searchResults = data['suggestions'] ?? [];
//         });
//       }
//     } catch (e) {
//       showErrorMessage(context, message: 'Something went wrong..!');
//     } finally {
//       setState(() {
//         _isLoadingSearch = false;
//       });
//     }
//   }

//   void _onSearchChanged() {
//     final newQuery = _searchController.text.trim();
//     if (newQuery == _query) return;

//     _query = newQuery;
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (_query == _searchController.text.trim()) {
//         _fetchSearchResults(_query);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Global Search'),
//       ),
//       body: SingleChildScrollView(
//         keyboardDismissBehavior:
//                             ScrollViewKeyboardDismissBehavior.onDrag,
//         child: Column(

//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/storage.dart';

class GlobalSearch extends StatefulWidget {
  const GlobalSearch({super.key});

  @override
  State<GlobalSearch> createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoadingSearch = false;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
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

    try {
      final token = await Storage.getToken();
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
      } else {
        showErrorMessage(context, message: 'Failed to fetch results');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          // child: TextField(
          //   onTap: () => FocusScope.of(context).unfocus(),
          //   controller: _searchController,
          //   autofocus: true,
          //   decoration: InputDecoration(
          //     hintText: 'Search...',
          //     border: InputBorder.none,
          //     suffixIcon: IconButton(
          //       icon: const Icon(Icons.close),
          //       onPressed: () {
          //         _searchController.clear();
          //         setState(() {
          //           _searchResults.clear();
          //         });
          //       },
          //     ),
          //   ),
          // ),
          child: TextField(
            controller: _searchController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * .1,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: _isLoadingSearch
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
              ? GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Center(
                      child: Text("Type Something....",
                          style: AppFont.dropDowmLabel(context))),
                )
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    return ListTile(
                      onTap: () {
                        Get.to(
                            () => SingleLeadsById(leadId: result['lead_id']));
                      },
                      title: Text(result['lead_name'] ?? 'No Name'),
                      subtitle: Text(result['email'] ?? 'No Email'),
                      leading: const Icon(Icons.person),
                    );
                  },
                ),
    );
  }
}
