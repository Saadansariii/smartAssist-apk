import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_assist/pages/calenderPages.dart/addTask.dart';
import 'package:smart_assist/pages/home_screen.dart';
import 'package:smart_assist/widgets/calender/appointment.dart';
import 'package:smart_assist/widgets/calender/calender.dart';
import 'package:smart_assist/widgets/calender/event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _isMonthView = true;
  // DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: Text(
          DateFormat('MMMM yyyy').format(_focusedDay), // e.g., January 2025
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          Row(
            children: [
              if (_isMonthView)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _calendarFormat = CalendarFormat.week;
                      _isMonthView = false;
                    });
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
              if (!_isMonthView)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _calendarFormat = CalendarFormat.month;
                      _isMonthView = true;
                    });
                  },
                  icon: const Icon(
                    FontAwesomeIcons.calendar,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Addtask(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffD2D1D1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Section
              CalenderWidget(calendarFormat: _calendarFormat),
              // CalenderWidget(),
              const SizedBox(
                height: 10,
              ),

              AppointmentWidget(),
              SizedBox(height: 10), // Space between report and events
              EventWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
