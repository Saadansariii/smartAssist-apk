import 'package:flutter/material.dart';
import 'package:smart_assist/pages/details_pages/followups.dart';

class OppFollUps extends StatelessWidget {
  const OppFollUps({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              // Image.asset('assets/star.png'),
              Icon(Icons.star),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tira Smith',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 139, 138, 138)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset('assets/vector.png'),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 5)),
                  Row(
                    children: [
                      // Icon(
                      //   Icons.phone,
                      //   color: Colors.grey,
                      // ),
                      // Image.asset('assets/phone.png'),
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      const Text('Today 3pm',
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
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FollowupsDetails()));
                    },
                    child: Image.asset('assets/arrowButton.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
