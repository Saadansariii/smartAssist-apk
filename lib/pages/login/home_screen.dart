import 'package:flutter/material.dart'; 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1380FE),
        title: const Text(
          'Good morning Richard !',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color: Colors.white,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: const Color(0xFFE1EFFF),
                            contentPadding:
                                const EdgeInsets.fromLTRB(1, 4, 0, 4),
                            border: InputBorder.none,

                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                            // iconColor: Colors.blueGrey,
                            prefixIcon:
                                const Icon(Icons.menu, color: Colors.grey),
                            suffixIcon:
                                const Icon(Icons.mic, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: 60, // Set height for the container
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1380FE),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(70, 40),
                            textStyle: const TextStyle(fontSize: 12),
                            shape:   RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
                            )
                          ),
                          child: const Text(
                              'Follow Ups(6)'), // Corrected Button widget
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Appointments (5)',
                          style: TextStyle(fontSize: 14), // Added font size
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Test Drive (5)',
                          style: TextStyle(fontSize: 14), // Added font size
                        ),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
