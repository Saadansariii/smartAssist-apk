import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _upcommingButtonIndex = 0;

  // Function to build each button widget
  Widget _buildButton(String title, int index) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: _upcommingButtonIndex == index
            ? Border.all(color: Colors.blue)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0xffF3F9FF),
          padding: EdgeInsets.symmetric(horizontal: 10),
          minimumSize: Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          setState(() {
            _upcommingButtonIndex = index;
          });
        },
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: _upcommingButtonIndex == index ? Colors.blue : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Wrap(
          spacing: 5, // Horizontal space between buttons
          runSpacing: 5, // Vertical space between lines of buttons
          children: [
            _buildButton('All', 0),
            _buildButton('Followups', 1),
            _buildButton('Appointments', 2),
            _buildButton('Test Drive', 3),
            _buildButton('Leads', 4),
            _buildButton('Orders', 5),
          ],
        ),
      ),
    );
  }
}
