import 'package:flutter/material.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/widgets/home_btn.dart/leads.dart';
import 'package:smart_assist/widgets/home_btn.dart/order.dart';
import 'package:smart_assist/widgets/home_btn.dart/test_drive.dart';

class BottomBtnSecond extends StatefulWidget {
  const BottomBtnSecond({super.key});

  @override
  State<BottomBtnSecond> createState() => _BottomBtnSecondState();
}

class _BottomBtnSecondState extends State<BottomBtnSecond> {
  Widget? currentWidget;

  int _leadButton = 0;

  @override
  void initState() {
    super.initState();
    // Set a default widget if needed
    currentWidget = const Leads();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.containerBg,
          border: Border.all(color: Colors.black.withOpacity(.1)),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(
                height: 32,
                width: double.infinity,
                child: Row(
                  children: [
                    // Leads Button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _leadButton = 0;
                            leads(0);
                          });
                        },
                        style: _buttonStyle(_leadButton == 0),
                        child: Text(
                          'Enquiry',
                          textAlign: TextAlign.center,
                          style: AppFont.buttonwhite(context),
                        ),
                      ),
                    ),

                    // Test Drive Button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _leadButton = 1;
                            testDrive(1);
                          });
                        },
                        style: _buttonStyle(_leadButton == 1),
                        child: Text('Test Drive',
                            textAlign: TextAlign.center,
                            style: AppFont.buttonwhite(context)),
                      ),
                    ),

                    // Orders Button
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _leadButton = 2;
                            orders(2);
                          });
                        },
                        style: _buttonStyle(_leadButton == 2),
                        child: Text('Orders',
                            textAlign: TextAlign.center,
                            style: AppFont.buttonwhite(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          currentWidget ??
              const SizedBox(
                height: 10,
              ), // Handle null case


          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  // Button Style
  ButtonStyle _buttonStyle(bool isSelected) {
    return TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor:
          isSelected ? const Color(0xFF1380FE) : Colors.transparent,
      foregroundColor: isSelected ? Colors.white : AppColors.fontColor,
      textStyle: AppFont.threeBtn(context),
    );
  }

  // Update Widgets
  void leads(int index) {
    setState(() {
      currentWidget = const Leads();
    });
  }

  void testDrive(int index) {
    setState(() {
      currentWidget = const TestDrive();
    });
  }

  void orders(int index) {
    setState(() {
      currentWidget = const Order();
    });
  }
}
