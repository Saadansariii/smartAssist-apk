import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/font/font.dart';

class Leads extends StatefulWidget {
  const Leads({super.key});

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  int _childButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // Row with Buttons and Enquiry Bank
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Buttons with Fixed Width
              Container(
                width: screenWidth * 0.45, // Adjust width if needed
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _buildButton('MTD', 0),
                    _buildButton('QTD', 1),
                    _buildButton('YTD', 2),
                  ],
                ),
              ),

              // Enquiry Bank
              Container(
                width: MediaQuery.of(context).size.width * .42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min, // Keep it compact
                  children: [
                    Text(
                      'Enquiry bank',
                      style: AppFont.smallText(context),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '137',
                      style: AppFont.smallTextBold(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        IntrinsicHeight(
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Ensures same height
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        context,
                        _getLeftCardTitle(_childButtonIndex),
                        _getLeftCardValue(_childButtonIndex),
                        screenWidth,
                        _getGreenCardColor(_childButtonIndex),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        context,
                        _getMiddleCardTitle(_childButtonIndex),
                        _getMiddleCardValue(_childButtonIndex),
                        screenWidth,
                        _getRedCardColor(_childButtonIndex),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: _buildInfoCard2(
                      context,
                      _getRightCardTitle(_childButtonIndex),
                      _getRightCardValue(_childButtonIndex),
                      screenWidth,
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  // Dynamic Titles and Values for Each Selected Button
  String _getLeftCardTitle(int index) {
    switch (index) {
      case 0:
        return 'Current month new enquiries';
      case 1:
        return 'Current quarter new enquiries';
      case 2:
        return 'Current year new enquiries';
      default:
        return '';
    }
  }

  String _getLeftCardValue(int index) {
    switch (index) {
      case 0:
        return '5';
      case 1:
        return '50';
      case 2:
        return '120';
      default:
        return '';
    }
  }

  Color _getGreenCardColor(int index) {
    switch (index) {
      case 0:
        return Colors.green; // Color for MTD
      case 1:
        return Colors.green; // Color for QTD
      case 2:
        return Colors.green; // Color for YTD
      default:
        return Colors.black; // Default color
    }
  }

  Color _getRedCardColor(int index) {
    switch (index) {
      case 0:
        return Colors.red; // Color for MTD
      case 1:
        return Colors.red; // Color for QTD
      case 2:
        return Colors.red; // Color for YTD
      default:
        return Colors.black; // Default color
    }
  }

  String _getMiddleCardTitle(int index) {
    switch (index) {
      case 0:
        return 'Enquiries lost';
      case 1:
        return 'Enquiries lost';
      case 2:
        return 'Enquiries lost';
      default:
        return '';
    }
  }

  String _getMiddleCardValue(int index) {
    switch (index) {
      case 0:
        return '8';
      case 1:
        return '40';
      case 2:
        return '100';
      default:
        return '';
    }
  }

  String _getRightCardTitle(int index) {
    switch (index) {
      case 0:
        return '45';
      case 1:
        return '100';
      case 2:
        return '350';
      default:
        return '';
    }
  }

  String _getRightCardValue(int index) {
    switch (index) {
      case 0:
        return 'More Enquiry to achieve your target';
      case 1:
        return 'More Enquiry to achieve your target';
      case 2:
        return 'More Enquiry to achieve your target';
      default:
        return '';
    }
  }

  // Button Builder
  Widget _buildButton(String text, int index) {
    bool isSelected = _childButtonIndex == index;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Colors.blue
                : Colors.transparent, // Only selected has blue border
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
            foregroundColor: isSelected
                ? Colors.blue
                : Colors.black, // Selected text blue, others black
            backgroundColor: Colors.transparent, // No background color change
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

  // Small Info Cards
  Widget _buildInfoCard(BuildContext context, String title, String value,
      double screenWidth, Color valueColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
                fontSize: 30, fontWeight: FontWeight.w700, color: valueColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  // Large Info Card
  Widget _buildInfoCard2(
      BuildContext context, String title, String value, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.blue),
          ),
          // const SizedBox(height: 2),
          Text(
            value,
            style: AppFont.dropDowmLabel(context),
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
              alignment: Alignment.centerRight,
              child: Text(
                textAlign: TextAlign.center,
                '😍',
                style:
                    TextStyle(fontSize: 20, fontFamily: 'YourAppleEmojiFont'),
              ))
        ],
      ),
    );
  }
}
