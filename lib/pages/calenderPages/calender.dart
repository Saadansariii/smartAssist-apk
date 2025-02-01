import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  DateTime _focusedDay =
      DateTime(2025, 1, 25); 
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _isMonthView = true;
  List<dynamic> appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments(_focusedDay); // Fetch appointments for 25-01-2025
  }

  // Function to fetch appointments based on the selected date
  Future<void> _fetchAppointments(DateTime selectedDate) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final String apiUrl =
        'https://api.smartassistapp.in/api/admin/events/all/asondate?date=$formattedDate';

    final token =
        await Storage.getToken(); // Ensure token is retrieved correctly

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          // 'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          appointments = data['rows'] ?? [];
        });
        print("Appointments fetched: ${appointments.length}");
      } else {
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}"); // Debugging the API response
      }
    } catch (error) {
      print("Error fetching appointments: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          DateFormat('MMMM yyyy').format(_focusedDay), // e.g., January 2025
          style: const TextStyle(
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
              CalenderWidget(calendarFormat: _calendarFormat),
              const SizedBox(height: 10),
              AppointmentWidget(
                appointments: appointments,
                onDateSelected: _fetchAppointments,
                selectedDate: _focusedDay,
              ),
              const SizedBox(height: 10),
              EventWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
