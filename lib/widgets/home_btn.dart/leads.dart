import 'package:flutter/material.dart';

class Leads extends StatelessWidget {
  const Leads({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0xFF1380FE),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10))),
            padding: EdgeInsets.only(left: 9),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        // border: Border.all(color: Colors.yellow),
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(10))),
                    child: Column(
                      children: [
                        // First Row
                        SizedBox(
                          height: 126,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoCard(
                                context,
                                'Almost there, you need\n 5  ',
                                '6',
                                screenWidth,
                              ),
                              _buildInfoCard(
                                context,
                                'Congratulations you \nhave  .',
                                '80%',
                                screenWidth,
                                rightPadding: 15,
                              ),
                            ],
                          ),
                        ),
                        // Second Row
                        SizedBox(
                          height: 126,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoCard(
                                context,
                                'Total Leads',
                                '3',
                                screenWidth,
                                bottomPadding: screenHeight * 0.015,
                              ),
                              _buildInfoCard(
                                context,
                                'Great you are doing!\nbetter  ',
                                '87%',
                                screenWidth,
                                rightPadding: 15,
                                bottomPadding: screenHeight * 0.015,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  color: Colors.white, // Outer container with white background
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1380FE),
                      border: Border.all(
                          color:
                              Colors.transparent), // Ensures no visible border
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scheduled \nGoals',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.06,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  'Follow up 10 clients to hit your \ngoals.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image(
                                  image: const AssetImage(
                                      'assets/circle-main.jpg'),
                                  height: screenWidth * 0.25,
                                  width: screenWidth * 0.25,
                                  color: const Color(0xFF1380FE),
                                  colorBlendMode: BlendMode.multiply,
                                ),
                                Text(
                                  '65%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // Bottom Container (Scheduled Goals)
  }

  Widget _buildInfoCard(
      BuildContext context, String title, String value, double screenWidth,
      {double leftPadding = 10,
      double rightPadding = 0,
      double bottomPadding = 0}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            leftPadding, screenWidth * 0.025, rightPadding, bottomPadding),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE1EFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(screenWidth * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              Text(
                value,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
