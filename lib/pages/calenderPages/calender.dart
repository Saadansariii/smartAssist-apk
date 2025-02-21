import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/calenderPages/tasks/addTask.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:smart_assist/widgets/calender/appointment.dart';
import 'package:smart_assist/widgets/calender/calender.dart';
import 'package:smart_assist/widgets/calender/calender_task.dart';
import 'package:smart_assist/widgets/calender/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  final String leadId;
  const Calender({super.key, required this.leadId});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _isMonthView = true;
  List<dynamic> appointments = [];
  List<dynamic> tasks = [];
  DateTime? _selectedDay;
  int upcomingFollowupsCount = 0;
  int overdueFollowupsCount = 0;
  int overdueAppointmentsCount = 0;
  int upcomingAppointmentsCount = 0;
  late Widget _createTask;

  @override
  void initState() {
    super.initState();
    _createTask = AddTaskPopup(
      selectedDate: _selectedDay,
      leadId: '',
      leadName: widget.leadId,
      selectedLeadId: '',
    );
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    _fetchAppointments(_focusedDay);
    _fetchCount(_focusedDay);
    _fetchTasks(_focusedDay);
  }

  Future<void> _fetchAppointments(DateTime selectedDate) async {
    final DateTime finalDate = selectedDate ?? DateTime.now();
    final data = await LeadsSrv.fetchAppointments(finalDate);
    setState(() {
      appointments = data;
    });
  }

  Future<void> _fetchTasks(DateTime? selectedDate) async {
    final DateTime finalDate = selectedDate ?? DateTime.now();
    final data = await LeadsSrv.fetchtasks(finalDate);
    setState(() {
      tasks = data;
    });
  }

  Future<void> _fetchCount(DateTime selectedDate) async {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(selectedDate); // Ensure correct format
    final data = await LeadsSrv.fetchCount(selectedDate);

    // print("API Response for $formattedDate: $data");

    if (data.isNotEmpty) {
      setState(() {
        upcomingFollowupsCount = data['upcomingFollowupsCount'] ?? 0;
        overdueFollowupsCount = data['overdueFollowupsCount'] ?? 0;
        upcomingAppointmentsCount = data['upcomingAppointmentsCount'] ?? 0;
        overdueAppointmentsCount = data['overdueAppointmentsCount'] ?? 0;
      });

      // print("Updated counts: "
      //     "Upcoming Follow-ups: $upcomingFollowupsCount, "
      //     "Overdue Follow-ups: $overdueFollowupsCount, "
      //     "Upcoming Appointments: $upcomingAppointmentsCount, "
      //     "Overdue Appointments: $overdueAppointmentsCount");
    } else {
      // print("No data returned for $formattedDate");
    }
  }

  void _handleDateSelection(DateTime selectedDay) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDay);

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = selectedDay;
      _createTask = AddTaskPopup(
        selectedDate: selectedDay,
        leadId: '',
        leadName: '',
        selectedLeadId: '',
      );
    });

    // print("Fetching data for date: $formattedDate");

    _fetchAppointments(selectedDay);
    _fetchCount(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
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
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _createTask,
                  );
                },
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalenderWidget(
              calendarFormat: CalendarFormat.month,
              onDateSelected: _handleDateSelection,
            ),
            AppointmentWidget(
              appointments: appointments,
              onDateSelected: _fetchAppointments,
              selectedDate: _selectedDay ?? _focusedDay,
            ),
            CalenderTask(
                tasks: tasks,
                selectedDate: _selectedDay ?? _focusedDay,
                onDateSelected: _fetchTasks),
            EventWidget(
              // selectedDate: _focusedDay,
              selectedDate: _selectedDay ?? _focusedDay,
              upcomingFollowupsCount: upcomingFollowupsCount,
              overdueFollowupsCount: overdueFollowupsCount,
              upcomingAppointmentsCount: upcomingAppointmentsCount,
              overdueAppointmentsCount: overdueAppointmentsCount,
            ),
          ],
        ),
      ),
    );
  }
}
