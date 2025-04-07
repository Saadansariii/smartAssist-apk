import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/font/font.dart';

class BottomBtnThird extends StatefulWidget {
  const BottomBtnThird({super.key});

  @override
  State<BottomBtnThird> createState() => _BottomBtnThirdState();
}

class _BottomBtnThirdState extends State<BottomBtnThird> {
  int _childButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black38,
            )),
        child: Column(
          children: [
            // First Row: MTD, QTD, YTD buttons on the left, text on the right
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.33, // Adjust width as needed
                  height: screenWidth * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: .5),
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
                const SizedBox(
                  width: 5,
                ),
                // Texts on the right side
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Dealership rank text
                      Expanded(
                        child: Text(
                          'Dealership rank',
                          style: AppFont.tinyText(context)
                              .copyWith(fontWeight: FontWeight.w500),
                          maxLines: 2, // Limit to 2 lines
                          // overflow:
                          //     TextOverflow.ellipsis, // Ellipsis if text overflows
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      // My performance text
                      Expanded(
                        child: Text(
                          'My performance',
                          style: AppFont.tinyText(context)
                              .copyWith(fontWeight: FontWeight.w500),
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      // All India rank text
                      Expanded(
                        child: Text(
                          'All India rank',
                          style: AppFont.tinyText(context)
                              .copyWith(fontWeight: FontWeight.w500),
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      // All India Best performer text
                      Expanded(
                        child: Text(
                          'All India Best performer',
                          style: AppFont.tinyText(context)
                              .copyWith(fontWeight: FontWeight.w500),
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20), // Spacing between rows
            // Second Row: Table
            _buildTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Set responsive column widths based on screen width
    double columnWidth1 =
        screenWidth * 0.3; // First column (larger text, like "Enquiries")
    double columnWidth2 = screenWidth * 0.15; // Other columns (smaller numbers)

    return Table(
      border: TableBorder.all(color: Colors.grey, width: 0.2),
      columnWidths: {
        0: FixedColumnWidth(columnWidth1),
        1: FixedColumnWidth(columnWidth2),
        2: FixedColumnWidth(columnWidth2),
        3: FixedColumnWidth(columnWidth2),
        4: FixedColumnWidth(columnWidth2),
      },
      children: [
        _buildTableRow(['Enquiries', '02', '42', '42', '42']),
        _buildTableRow(['Test drives', '06', '23', '23', '23']),
        _buildTableRow(['New Orders', '01', '15', '15', '15']),
        _buildTableRow(['Cancellations', '04', '2', '2', '2']),
        _buildTableRow(['Retail', '02', '7', '7', '7']),
      ],
    );
  }

  TableRow _buildTableRow(List<String> values) {
    return TableRow(
      children: values.map((value) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis, // Handle overflow
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButton(String text, int index) {
    bool isSelected = _childButtonIndex == index;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: isSelected ? Colors.blue : Colors.transparent,
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              _childButtonIndex = index;
            });
          },
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            foregroundColor: isSelected ? Colors.blue : Colors.black,
            backgroundColor: isSelected ? Colors.blue : Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
