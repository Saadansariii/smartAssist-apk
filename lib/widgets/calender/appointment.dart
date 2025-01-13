import 'package:flutter/material.dart';

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({super.key});

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
                        color: Color(0xffE0EAF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 13th with superscript
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '13',
                                style: TextStyle(
                                    fontSize: 18), // Regular size for 13
                              ),
                              Text(
                                'nd',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 0.5,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                          // Nov on a new line
                          Text(
                            'Nov',
                            style:
                                TextStyle(fontSize: 18), // Regular size for Nov
                          ),

                          // Time on the next line
                          SizedBox(height: 5),
                          Text(
                            '10:15 AM',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )),
                ],
              ),

              SizedBox(
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
                    Text(
                      'Tira Smith',
                      style: TextStyle(
                          fontSize: screenWidth > 600 ? 18 : 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.camera_enhance_outlined),
                        SizedBox(width: 10),
                        Text('Appointment '),
                        SizedBox(width: 2),
                        Icon(
                          Icons.circle,
                          size: 10,
                        ),
                        SizedBox(width: 2),
                        Text('8.00 Am - 9.30Am',
                            style: TextStyle(
                                fontSize: screenWidth > 600 ? 14 : 12))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Kachpada, Malad West, india - 400064',
                      style: Theme.of(context).textTheme.titleSmall,
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
