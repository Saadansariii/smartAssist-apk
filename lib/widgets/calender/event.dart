import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Get the screen width
          double screenWidth = constraints.maxWidth;

          // Adjust layout based on screen size
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Date and Time Section (left-aligned)
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff7FAEE5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 13th with superscript
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '13',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ), // Regular size for 13
                              ),
                              Text(
                                'nd',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 0.5,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // Nov on a new line
                          Text(
                            'Nov',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ), // Regular size for Nov
                          ),

                          // Time on the next line
                          SizedBox(height: 5),
                          Text(
                            '12:15 AM',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      )),
                ],
              ),

              const SizedBox(
                width: 10,
              ),

              // Add some space between rows
              if (screenWidth > 600)
                const SizedBox(width: 20), // Add space for larger screens

              // Name Section (right-aligned)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_2_outlined),
                        Text(
                          'Event',
                          style: TextStyle(
                              fontSize: screenWidth > 600 ? 18 : 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Color(0xffEF5138),
                          size: 12,
                        ),
                        const SizedBox(width: 10),
                        Text('Overdue Follow-Ups ',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 2),
                        const SizedBox(width: 2),
                        Text('2',
                            style: TextStyle(
                                fontSize: screenWidth > 600 ? 20 : 16,
                                color: const Color(0xffEF5138)))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Color(0xff27AB3B),
                          size: 12,
                        ),
                        const SizedBox(width: 10),
                        const Text('Upcoming Follow-Ups ',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 2),
                        const SizedBox(width: 2),
                        Text('2',
                            style: TextStyle(
                                fontSize: screenWidth > 600 ? 20 : 16,
                                color: const Color(0xff27AB3B)))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
