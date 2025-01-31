import 'package:flutter/material.dart';

class TestDrive extends StatelessWidget {
  const TestDrive({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const SizedBox(height: 20), // Adds space at the top
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 231, 228, 228), // Top border color
                width: 1.5, // Top border thickness
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10, // Generates labels from 90 to 0
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        '${(10 - index) * 10}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between labels and graph
                Expanded(
                  child: Image.asset(
                    'assets/graph.png',
                    fit: BoxFit.contain, // Ensures image scales well
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
