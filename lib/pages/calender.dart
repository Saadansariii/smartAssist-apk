import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          'Nov 2025',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon:const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon:const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: Row(
        children: [
          Row(
            // calender
          ),
          Row(
            // report
          ),
          Row(
            // events
          )
        ],
      ),
    );
  }
}
