import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OppOverdue extends StatelessWidget {
  const OppOverdue({super.key});

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
      child: Row(
        children: [
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: const Border(
                    left: BorderSide(
                      width: 8.0,
                      color: Color(0xFFEA4335),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipRect(
                        child: Image.asset('assets/Star.png'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // const Text('data')
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Tom Adams',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF767676)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/call.png',
                                height: 30, // Adjust image size as needed
                                width: 30,
                              ),
                              const Text(
                                'Yesterday',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Discovery Sport',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Image.asset('assets/arrowButton.png')],
            ),
          )
        ],
      ),
    );
  }
}
