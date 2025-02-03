import 'package:flutter/material.dart';
import 'package:smart_assist/pages/home_screens/all_followups.dart';
import 'package:smart_assist/widgets/home_btn.dart/leads.dart';
import 'package:smart_assist/widgets/home_btn.dart/order.dart';
import 'package:smart_assist/widgets/home_btn.dart/test_drive.dart';

class BottomBtnSecond extends StatefulWidget {
  const BottomBtnSecond({super.key});

  @override
  State<BottomBtnSecond> createState() => _BottomBtnSecondState();
}

class _BottomBtnSecondState extends State<BottomBtnSecond> {
  int _selectedBtnIndex = 0;
  final List<Widget> _widgets = [
    const Leads(),
    const Order(),
    const TestDrive(),
  ];

  int _leadButton = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddFollowups()));
              },
              child: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 36,
              ),
            )
          ],
        ),
        // SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE1EFFF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                children: [
                  // Follow Ups Button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _leadButton = 0;
                          _selectedBtnIndex = 0;
                        });
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: _leadButton == 0
                            ? const Color(0xFF1380FE)
                            : Colors.transparent,
                        foregroundColor:
                            _leadButton == 0 ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('Leads', textAlign: TextAlign.center),
                    ),
                  ),

                  // Appointments Button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _leadButton = 1;
                          _selectedBtnIndex = 2;
                        });
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: _leadButton == 1
                            ? const Color(0xFF1380FE)
                            : Colors.transparent,
                        foregroundColor:
                            _leadButton == 1 ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child:
                          const Text('Test Drive', textAlign: TextAlign.center),
                    ),
                  ),

                  // Test Drive Button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _leadButton = 2;
                          _selectedBtnIndex = 1;
                        });
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: _leadButton == 2
                            ? const Color(0xFF1380FE)
                            : Colors.transparent,
                        foregroundColor:
                            _leadButton == 2 ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('Orders', textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _widgets[_selectedBtnIndex],
      ],
    );
  }
}
