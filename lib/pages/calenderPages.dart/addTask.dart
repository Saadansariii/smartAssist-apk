import 'package:flutter/material.dart';
import 'package:smart_assist/pages/calenderPages.dart/calender.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  String? selectedEvent;
  String? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task / Event',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Calender()));
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 243, 238, 238),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: double.infinity, // Full width container

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // Stretch children horizontally
                  children: [
                    // Dropdown 1 (Event Type)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Select event / task',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity, // Full width dropdown
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 243, 238, 238),
                      ),
                      child: DropdownButton<String>(
                        value: selectedEvent,
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Appointment",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: <String>['Appointment', 'Followup', 'Test Drive']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(value,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedEvent = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Dropdown 2 (Customer/Client)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Select Customer/Client',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity, // Full width dropdown
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 243, 238, 238),
                      ),
                      child: DropdownButton<String>(
                        value: selectedCustomer,
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text("Tira",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: <String>['Tira', 'Andrew', 'Add another']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(value,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCustomer = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Row with Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 202, 200,
                                  200), // Changed to red for cancel
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Calender()));
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Calender()));
                              },
                              child: const Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
