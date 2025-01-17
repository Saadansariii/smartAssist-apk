import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OppUpcoming extends StatelessWidget {
  const OppUpcoming({super.key});

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
              borderRadius: BorderRadius.circular(10), // Optional rounded corners
              border: const Border(
                left: BorderSide(
                  width: 8.0, // Left border width
                  color: Color.fromARGB(255, 81, 223, 121), // Left border color
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/star.png'),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tira Smith',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 139, 138, 138)),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                        ),
                        Text('10:30 Am',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.grey)),
                      ],
                    )
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
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          'Tomorrow',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [Image.asset('assets/arrowButton.png')],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
