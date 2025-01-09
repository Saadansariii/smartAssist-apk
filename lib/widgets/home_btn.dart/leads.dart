import 'package:flutter/material.dart';

class Leads extends StatelessWidget {
  const Leads({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1380FE), // Outer container color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
              ),
              // Optional rounded corners
            ),
            padding: const EdgeInsets.only(left: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Inner container color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // First Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // First child
                      SizedBox(
                        height: 140,
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1EFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Almost there, you need\n 5 more leads\n to achieve\n your goal',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                const SizedBox(height: 5),
                                Text('5',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Second child
                      SizedBox(
                        height: 140,
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1EFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Congratulations you \nhave completed leads everyday for 32 days straight.',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '80%',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Second Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Third child
                      SizedBox(
                        height: 140,
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1EFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Leads',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '3',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Fourth child
                      SizedBox(
                        height: 140,
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1EFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Great you are doing!\vbetter then 87% of salesperson.',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 5),
                                Text('87%',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1380FE), // Set the background color
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Space between text and image
                    children: [
                      // Text on the left
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text(
                            'Scheduled \nGoals',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Follow up 10 clients to hit your \ngoals.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          // SizedBox(height: 10)
                        ],
                      ),
                      // Image with text in the middle
                      Stack(
                        alignment: Alignment
                            .center, // Aligns the text in the center of the image
                        children: [
                          Image(
                            image: AssetImage('assets/circle-main.jpg'),
                            height: 100,
                            width: 100,
                            color:
                                Color(0xFF1380FE), // Blend white over the image
                            colorBlendMode:
                                BlendMode.multiply, // Apply blend mode
                          ),
                          Text(
                            '65%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
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
    );
  }
}
