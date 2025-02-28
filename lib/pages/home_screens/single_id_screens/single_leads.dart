import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';

class SingleLeadsById extends StatefulWidget {
  final String leadId;
  const SingleLeadsById({super.key, required this.leadId});

  @override
  State<SingleLeadsById> createState() => _SingleLeadsByIdState();
}

class _SingleLeadsByIdState extends State<SingleLeadsById> {
  String phoneNumber = '';
  String subtype = '';
  String email = '';
  String brand = '';
  String dealerName = '';
  String pmi = '';
  String status = '';
  String leadSource = '';
  String purchaseType = '';
  String leadOwner = '';
  String flag = '';
  String enquiryType = '';
  String leadName = '';

  @override
  void initState() {
    super.initState();
    fetchLeadData(widget.leadId);

    // print('this is lead id $widget.leadId');
    // print(widget.leadId);
  }

  Future<void> fetchLeadData(String leadId) async {
    try {
      final leadData = await LeadsSrv.fetchLeadsById(leadId);
      setState(() {
        phoneNumber = leadData['mobile'] ?? 'N/A';
        subtype = leadData['sub_type'] ?? 'N/A';
        email = leadData['email'] ?? 'N/A';
        brand = leadData['brand'] ?? 'N/A';
        dealerName = leadData['dealer_name'] ?? 'N/A';
        pmi = leadData['PMI'] ?? 'N/A';
        status = leadData['status'] ?? 'N/A';
        leadSource = leadData['lead_source'] ?? 'N/A';
        purchaseType = leadData['purchase_type'] ?? 'N/A';
        leadOwner = leadData['lead_owner'] ?? 'N/A';
        flag = leadData['flag'] ?? 'N/A';
        enquiryType = leadData['enquiry_type'] ?? 'N/A';
        leadName = leadData['lead_name'] ?? 'N/A';
      });
      // ignore: avoid_print
      print("Leads data: $leadData");
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  Widget _buildInfoBox(String title, String value) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 205, 205),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const Icon(Icons.person, size: 40),
          const SizedBox(height: 5),
          Text(
            leadName,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCFCFCF),
      appBar: AppBar(
        title: Text('Lead',
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey)),
        backgroundColor: const Color.fromARGB(255, 206, 205, 205),
        foregroundColor: Colors.grey,
        leading: IconButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomNavigation())),
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildInfoBox('Status', status),
                    const SizedBox(width: 5),
                    _buildInfoBox('Lead Source', leadSource),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildInfoBox('Mobile', phoneNumber),
                    const SizedBox(width: 5),
                    _buildInfoBox('Sub Type', subtype),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildInfoBox('Email', email),
                    const SizedBox(width: 5),
                    _buildInfoBox('Brand', brand),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildInfoBox('Dealer Name', dealerName),
                    const SizedBox(width: 5),
                    _buildInfoBox('PMI', pmi),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildInfoBox('Lead Owner', leadOwner),
                    const SizedBox(width: 5),
                    _buildInfoBox('Flag', flag),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    _buildInfoBox('Purchase Type', purchaseType),
                    const SizedBox(width: 5),
                    _buildInfoBox('Enquiry Type', enquiryType),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    _buildActionButton('Lost', Colors.red, () {}),
                    const SizedBox(width: 5),
                    _buildActionButton(
                        'Convert to Opportunity', Colors.blue, () {}),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
    
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_assist/pages/home_screens/home_screen.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:smart_assist/services/leads_srv.dart';
// import 'package:smart_assist/utils/storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SingleLeadsById extends StatefulWidget {
//   final String leadId;
//   const SingleLeadsById({super.key, required this.leadId});

//   @override
//   State<SingleLeadsById> createState() => _SingleLeadsByIdState();
// }

// class _SingleLeadsByIdState extends State<SingleLeadsById> {
//   String phoneNumber = '';
//   String subtype = '';
//   String email = '';
//   String brand = '';
//   String dealerName = '';
//   String pmi = '';
//   String status = '';
//   String leadSource = '';
//   String purchaseType = '';
//   String leadOwner = '';
//   String flag = '';
//   String enquiryType = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchLeadData(widget.leadId);
//   }

//   // Future<void> fetchLeadsById() async {
//   //   const String apiUrl =
//   //       "https://api.smartassistapp.in/api/leads/434e1b21-7b29-4989-915b-4e883d7d9b59";

//   //   final token = await Storage.getToken();
//   //   if (token == null) {
//   //     print("No token found. Please login.");
//   //     return;
//   //   }

//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse(apiUrl),
//   //       headers: {'Authorization': 'Bearer $token',},
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final data = json.decode(response.body);
//   //       setState(() {
//   //         phoneNumber = data['mobile'] ?? 'N/A';
//   //         subtype = data['sub_type'] ?? 'N/A';
//   //         email = data['email'] ?? 'N/A';
//   //         brand = data['brand'] ?? 'N/A';
//   //         dealerName = data['dealer_name'] ?? 'N/A';
//   //         pmi = data['pmi'] ?? 'N/A';
//   //         status = data['status'] ?? 'N/A';
//   //         leadSource = data['lead_source'] ?? 'N/A';
//   //         purchaseType = data['purchase_type'] ?? 'N/A';
//   //         leadOwner = data['lead_owner'] ?? 'N/A';
//   //         flag = data['flag'] ?? 'N/A';
//   //         enquiryType = data['enquiry_type'] ?? 'N/A';
//   //       });
//   //       print("Leads data: $data");
//   //     } else {
//   //       print('Failed to load data: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching data: $e');
//   //   }
//   // }

//   Future<void> fetchLeadData(String leadId) async {
//     try {
//       final leadData = await LeadsSrv.fetchLeadsById(widget.leadId);
//       setState(() {
//         phoneNumber = leadData['mobile'] ?? 'N/A';
//         subtype = leadData['sub_type'] ?? 'N/A';
//         email = leadData['email'] ?? 'N/A';
//         brand = leadData['brand'] ?? 'N/A';
//         dealerName = leadData['dealer_name'] ?? 'N/A';
//         pmi = leadData['pmi'] ?? 'N/A';
//         status = leadData['status'] ?? 'N/A';
//         leadSource = leadData['lead_source'] ?? 'N/A';
//         purchaseType = leadData['purchase_type'] ?? 'N/A';
//         leadOwner = leadData['lead_owner'] ?? 'N/A';
//         flag = leadData['flag'] ?? 'N/A';
//         enquiryType = leadData['enquiry_type'] ?? 'N/A';
//       });
//       print("Leads data: $leadData");
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Widget _buildInfoBox(String title, String value) {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 206, 205, 205),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               value,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Column(
//         children: [
//           const Icon(Icons.person, size: 40),
//           const SizedBox(height: 5),
//           Text(
//             'Alex Carter',
//             style:
//                 GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
//     return Expanded(
//       child: Container(
//         height: 45,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: TextButton(
//           onPressed: onPressed,
//           child: Text(
//             text,
//             style: GoogleFonts.poppins(
//                 fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffCFCFCF),
//       appBar: AppBar(
//         title: Text('Lead',
//             style: GoogleFonts.poppins(
//                 fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey)),
//         backgroundColor: const Color.fromARGB(255, 206, 205, 205),
//         foregroundColor: Colors.grey,
//         leading: IconButton(
//           onPressed: () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const HomeScreen())),
//           icon: const Icon(Icons.arrow_back_ios_outlined),
//         ),
//         actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(10.0),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               // add the rest field
//               _buildHeader(),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     _buildInfoBox('Status', status),
//                     const SizedBox(width: 5),
//                     _buildInfoBox('Lead Source', leadSource),
//                     const SizedBox(width: 5),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     _buildInfoBox('mobile', phoneNumber),
//                     const SizedBox(width: 5),
//                     _buildInfoBox('sub type', subtype),
//                     const SizedBox(width: 5),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     _buildInfoBox('email', email),
//                     const SizedBox(width: 5),
//                     _buildInfoBox('brand', brand),
//                     const SizedBox(width: 5),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     _buildInfoBox('dealer_name', dealerName),
//                     const SizedBox(width: 5),
//                     _buildInfoBox('pmi', pmi),
//                     const SizedBox(width: 5),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     _buildInfoBox('lead owner', leadOwner),
//                     const SizedBox(width: 5),
//                     _buildInfoBox('flag', flag),
//                     const SizedBox(width: 5),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 5),
//                     _buildInfoBox('purchase type', purchaseType),
//                     const SizedBox(width: 5),
//                     _buildInfoBox('enquiry type', enquiryType),
//                     const SizedBox(width: 5),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Row(
//                   children: [
//                     _buildActionButton('Lost', Colors.red, () {}),
//                     const SizedBox(width: 5),
//                     Container(
//                       decoration: BoxDecoration(),
//                       child: _buildActionButton(
//                           'Convert to opportunity', Colors.blue, () {}),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
