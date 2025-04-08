import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/widgets/calender/calender.dart';
import 'package:table_calendar/table_calendar.dart';

class CallHistory extends StatefulWidget {
  const CallHistory({super.key});

  @override
  State<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  int _childButtonIndex = 0;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _isMonthView = false;
  DateTime? _selectedDay;
  //   Map<String, dynamic> getSelectedData() {
  //   switch (_childButtonIndex) {
  //     case 0:
  //       return widget.MtdData;
  //     case 1:
  //       return widget.QtdData;
  //     case 2:
  //       return widget.YtdData;
  //     default:
  //       return {};
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Calls', style: AppFont.appbarfontgrey(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: AppColors.iconGrey),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenWidth * 0.65,
                    height: 27,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 129, 129, 129),
                        strokeAlign: .5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        _buildButton('Day', 0),
                        _buildButton('Week', 1),
                        _buildButton('Month', 2),
                        _buildButton('Year', 3),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _calendarFormat = _isMonthView
                                  ? CalendarFormat.week
                                  : CalendarFormat.month;
                              _isMonthView = !_isMonthView;
                            });
                          },
                          icon: Icon(
                            _isMonthView
                                ? Icons.calendar_view_week
                                : Icons.calendar_month,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              CalenderWidget(
                key: ValueKey(_calendarFormat),
                calendarFormat: _calendarFormat,
                onDateSelected: (selectedDate) {
                  setState(() {
                    // _focusedDay = selectedDate;
                    // _selectedDay = selectedDate;
                  });
                  // _fetchAppointments(selectedDate);
                  // _fetchTasks(selectedDate);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstSlide(BuildContext context, double screenWidth) {
    // final selectedData = getSelectedData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: _buildInfoCard1(
                      context,
                      'Current month new enquiries',
                      ' ',
                      screenWidth,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildInfoCard1(
                      context,
                      'Enquiries lost',
                      ' ',
                      screenWidth,
                      Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInfoCard1(
                context,
                'More enquiries to achieve your target',
                ' ',
                screenWidth,
                Colors.red,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInfoCard1(
                context,
                'Enquiries lost',
                ' ',
                screenWidth,
                Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard1(BuildContext context, String title, String value,
      double screenWidth, Color valueColor) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 4,
              value,
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w700, color: valueColor),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Text(
                title,
                softWrap: true,
                // textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, int index) {
    bool isSelected = _childButtonIndex == index;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              _childButtonIndex = index;
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: isSelected ? Colors.blue : Colors.black,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// class _childButtonIndex {}
