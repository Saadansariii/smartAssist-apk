// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalenderWidget extends StatefulWidget {
//   final CalendarFormat calendarFormat;
//   const CalenderWidget({super.key, required this.calendarFormat});

//   @override
//   State<CalenderWidget> createState() => _CalenderWidgetState();
// }

// class _CalenderWidgetState extends State<CalenderWidget> {
//   DateTime _focusedDay = DateTime.now();

//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(18.0),
//       child: TableCalendar(
//         firstDay: DateTime.utc(2000, 1, 1),
//         lastDay: DateTime.utc(2100, 12, 31),
//         focusedDay: _focusedDay,
//         selectedDayPredicate: (day) {
//           return isSameDay(_selectedDay, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//           });
//         },
//         calendarFormat: widget.calendarFormat,
//         availableGestures: AvailableGestures.none,
//         headerStyle: const HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: false,
//           leftChevronVisible: false,
//           rightChevronVisible: false,
//           headerPadding: EdgeInsets.zero,
//           titleTextStyle: TextStyle(fontSize: 0, color: Colors.transparent),
//         ),
//         calendarStyle: const CalendarStyle(
//           selectedDecoration: BoxDecoration(
//             color: Colors.blue,
//             shape: BoxShape.circle,
//           ),
//           todayDecoration: BoxDecoration(
//             color: Colors.blue,
//             shape: BoxShape.circle,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalenderWidget extends StatefulWidget {
//   final CalendarFormat calendarFormat;
//   const CalenderWidget({super.key, required this.calendarFormat});

//   @override
//   State<CalenderWidget> createState() => _CalenderWidgetState();
// }

// class _CalenderWidgetState extends State<CalenderWidget> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(18.0),
//       child: TableCalendar(
//         firstDay: DateTime.utc(2000, 1, 1),
//         lastDay: DateTime.utc(2100, 12, 31),
//         focusedDay: _focusedDay, // Ensure focusedDay is updated correctly
//         selectedDayPredicate: (day) {
//           return isSameDay(_selectedDay, day); // Check if the day is selected
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay; // Update the selected day
//             _focusedDay = focusedDay; // Update the focused day
//           });
//         },
//         calendarFormat: widget.calendarFormat,
//         availableGestures: AvailableGestures.none,
//         headerStyle: const HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: false,
//           leftChevronVisible: false,
//           rightChevronVisible: false,
//           headerPadding: EdgeInsets.zero,
//           titleTextStyle: TextStyle(fontSize: 0, color: Colors.transparent),
//         ),
//         calendarStyle: const CalendarStyle(
//           selectedDecoration: BoxDecoration(
//             color: Colors.blue,
//             shape: BoxShape.circle,
//           ),
//           todayDecoration: BoxDecoration(
//             color: Colors.blue,
//             shape: BoxShape.circle,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final Function(DateTime)
      onDateSelected; // Callback to notify the parent widget
  const CalenderWidget({
    super.key,
    required this.calendarFormat,
    required this.onDateSelected, // Pass the callback to the parent
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Function to fetch data based on the selected date
  Future<void> _fetchData(DateTime selectedDay) async {
    final formattedDate = DateFormat('dd-MM-yyyy')
        .format(selectedDay); // Format date to string (YYYY-MM-DD)
    print('Fetching data for date: $formattedDate');

    // Here you can call your API and pass the formatted date
    // Example:
    // await fetchAppointments(formattedDate);

    // Notify the parent widget with the selected date
    widget.onDateSelected(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(18.0),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay, // Ensure focusedDay is updated correctly
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day); // Check if the day is selected
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay; // Update the selected day
            _focusedDay = focusedDay; // Update the focused day
          });
          _fetchData(selectedDay); // Fetch data when a date is selected
        },
        calendarFormat: widget.calendarFormat,
        availableGestures: AvailableGestures.none,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerPadding: EdgeInsets.zero,
          titleTextStyle: TextStyle(fontSize: 0, color: Colors.transparent),
        ),
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
