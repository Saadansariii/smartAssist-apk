import 'package:flutter/material.dart';
import 'package:smart_assist/pages/details_pages/followups.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OverdueFollowup extends StatelessWidget {
  const OverdueFollowup({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.phone, // Material icon
            onPressed: (context) {
              // Define action for phone icon
              print('Phone action pressed');
            },
          ),
          SlidableAction(
            backgroundColor: Colors.green,
            icon: Icons.message_rounded,
            onPressed: (context) {
              // Define action for WhatsApp icon
              print('WhatsApp action pressed');
            },
          ),
          SlidableAction(
            backgroundColor: const Color.fromARGB(255, 231, 225, 225),
            icon: Icons.mail,
            onPressed: (context) {
              // Define action for mail icon
              print('Mail action pressed');
            },
            foregroundColor: Colors.red, // This will set the icon color to red
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 245, 244, 244), // Background color for the content
              borderRadius:
                  BorderRadius.circular(10), // Optional rounded corners
              border: const Border(
                left: BorderSide(
                  width: 8.0, // Left border width
                  color: Color(0xFFEA4335), // Left border color
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Image.asset('assets/star.png'),
                Icon(Icons.star),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Beth Ford',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 139, 138, 138)),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: [
                        // Icon(
                        //   Icons.phone,
                        //   color: Colors.grey,
                        // ),
                        Image.asset('assets/phone.png'),
                        const Padding(padding: EdgeInsets.only(right: 5)),
                        const Text('Today',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Discovery Sport',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.calendar_month_outlined,
                    //       color: Colors.grey,
                    //     ),
                    //     Text(
                    //       'Tomorrow',
                    //       style: TextStyle(
                    //           color: Colors.grey, fontWeight: FontWeight.w400),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FollowupsDetails()));
                      },
                      child: Image.asset('assets/arrowButton.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
