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
        availableGestures: AvailableGestures.all,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerPadding: EdgeInsets.zero,
          titleTextStyle: TextStyle(fontSize: 0, color: Colors.transparent),
        ),
        calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            todayTextStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
