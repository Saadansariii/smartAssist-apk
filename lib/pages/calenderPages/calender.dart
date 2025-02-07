import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/calenderPages/addTask.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/widgets/calender/appointment.dart';
import 'package:smart_assist/widgets/calender/calender.dart';
import 'package:smart_assist/widgets/calender/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_assist/utils/storage.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _focusedDay = DateTime(2025, 1, 25);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _isMonthView = true;
  List<dynamic> appointments = [];
  int upcomingFollowupsCount = 0;
  DateTime? _selectedDay;
  int overdueFollowupsCount = 0;
  int overdueAppointmentsCount = 0;
  int upcomingAppointmentsCount = 0;
  // var data = responseData;

  @override
  void initState() {
    super.initState();
    _fetchAppointments(_focusedDay);
    _fetchDashboardData();
  }

  // Function to fetch appointments based on the selected date
  Future<void> _fetchAppointments(DateTime selectedDate) async {
    final String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final String apiUrl =
        'https://api.smartassistapp.in/api/admin/events/all/asondate?date=$formattedDate';

    final token = await Storage.getToken();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          appointments = data['rows'] ?? [];
        });
        print("Appointments fetched: ${appointments.length}");
        print('this the url ${apiUrl}');
      } else {
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}"); // Debugging the API response
      }
    } catch (error) {
      print("Error fetching appointments: $error");
    }
  }

  Future<void> _fetchDashboardData() async {
    final token = await Storage.getToken();
    try {
      final response = await http.get(
        Uri.parse('https://api.smartassistapp.in/api/users/dashboard'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Decoded Data: $data');
        setState(() {
          overdueFollowupsCount = data['overdueFollowupsCount'] ?? 0;
          upcomingFollowupsCount = data['upcomingFollowupsCount'] ?? 0;
          upcomingAppointmentsCount = data['upcomingAppointmentsCount'] ?? 0;
          overdueAppointmentsCount = data['overdueAppointmentsCount'] ?? 0;
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // Function to handle date selection and update data
  void _handleDateSelection(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = selectedDay; // Update focused day as well
    });

    // Fetch data for the selected date
    _fetchAppointments(selectedDay);
    _fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: Text(
          DateFormat('MMMM yyyy').format(_focusedDay),
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _calendarFormat =
                    _isMonthView ? CalendarFormat.week : CalendarFormat.month;
                _isMonthView = !_isMonthView;
              });
            },
            icon: Icon(
                _isMonthView ? Icons.calendar_month : FontAwesomeIcons.calendar,
                color: Colors.white),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white)),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Addtask()));
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffD2D1D1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalenderWidget(
                calendarFormat: CalendarFormat.month,
                onDateSelected: _handleDateSelection,
              ),
              const SizedBox(height: 10),
              AppointmentWidget(
                appointments: appointments,
                onDateSelected: _fetchAppointments,
                selectedDate: _focusedDay,
              ),
              const SizedBox(height: 10),
              EventWidget(
                upcomingFollowupsCount: upcomingFollowupsCount,
                overdueFollowupsCount: overdueFollowupsCount,
                upcomingAppointmentsCount: upcomingAppointmentsCount,
                overdueAppointmentsCount: upcomingAppointmentsCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
