import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/calenderPages/calender.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/pages/home_screens/opportunity.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/appointment_popup.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_followups/create_Followups_popups.dart';
import 'package:smart_assist/widgets/home_btn.dart/popups_model/create_leads.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    // final Widget _createFollowups = const CreateFollowupsPopups();

    return Scaffold(
      body: Stack(
        children: [
          // 🛠️ Main Page Content (Screens)
          Obx(() => controller.screens[controller.selectedIndex.value]),

          // 🛠️ Overlay & Popup Menu
          // 🛠️ Overlay & Popup Menu
          Obx(() => controller.isFabExpanded.value
              ? _buildPopupMenu(controller, context)
              : const SizedBox.shrink()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          Obx(() => _buildFloatingActionButton(controller, context)),
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );
  }
}

// ✅ Floating Action Button (FAB)
Widget _buildFloatingActionButton(
    NavigationController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      HapticFeedback.lightImpact();
      controller.isFabExpanded.toggle();
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .18,
          height: MediaQuery.of(context).size.height * .1,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: AppColors.colorsBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AnimatedRotation(
              turns: controller.isFabExpanded.value ? 0.250 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                controller.isFabExpanded.value ? Icons.close : Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ✅ Popup Menu Item Animation
Widget _buildPopupMenu(NavigationController controller, BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: GestureDetector(
          onTap: () {
            print("Appointment option tapped");
            controller.isFabExpanded.value = false;
            _showAppointmentPopup(context);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),

      // 🔹 Animated Popup Items (Slide from Bottom)
      Positioned(
        bottom: 90, // Adjust as needed
        left: MediaQuery.of(context).size.width / 2 - 50, // Center items
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildPopupItem(
                controller, Icons.people_alt_rounded, "Lead", -45, -10),
            _buildPopupItem(controller, Icons.call, "Followup", 45, -10),
            _buildPopupItem(controller, Icons.calendar_month_outlined,
                "Appointment", -85, 70),
            _buildPopupItem(
                controller, Icons.directions_car, "Test Drive", 85, 70),
          ],
        ),
      ),
    ],
  );
}

Widget _buildPopupItem(NavigationController controller, IconData icon,
    String label, double dx, double dy) {
  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 0, end: controller.isFabExpanded.value ? 1 : 0),
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutBack, // Smooth animation
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(dx * value, dy * value), // Moves outward
        child: Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.isFabExpanded.value = false; // ✅ Close menu

                  // ✅ Show the custom popup when "Lead" is clicked
                  if (label == "Lead") {
                    _showLeadPopup(context);
                  } else {
                    print("$label clicked");
                  }

                  if (label == "Followup") {
                    _showFollowupPopup(context);
                  } else {
                    print("$label clicked");
                  }

                  // if (label == "Appointment") {
                  //   _showAppointmentPopup(context);
                  // } else {
                  //   print("$label Appointment clickked");
                  // }

                  if (label == "Appointment") {
                    print("Appointment clicked!"); // Debugging print
                    _showAppointmentPopup(context);
                  } else {
                    print("$label clicked");
                  }

                  if (label == "TestDrive") {
                    _showTestDrivePopup(context);
                  } else {
                    print("$label clicked");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.3),
                    //     blurRadius: 8,
                    //     spreadRadius: 5,
                    //   )
                    // ],
                  ),
                  child: Icon(icon, color: Colors.blue, size: 24),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ✅ Function to Show `CreateFollowupsPopups` on "Lead"
void _showLeadPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add some margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CreateLeads(),
        ),
      );
    },
  );
}

// ✅ Function to Show `CreateFollowupsPopups` on "Lead"
void _showFollowupPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add some margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CreateFollowupsPopups(),
        ),
      );
    },
  );
}

void _showAppointmentPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero, // Remove default padding
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const AppointmentPopup(), // Appointment modal
        ),
      );
    },
  );
}

void _showTestDrivePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Add some margin for better UX
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CreateFollowupsPopups(),
        ),
      );
    },
  );
}

// ✅ Bottom Navigation Bar
Widget _buildBottomNavigationBar(NavigationController controller) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
        )
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                  icon: Icons.people_alt_rounded,
                  label: 'Leads',
                  index: 0,
                  controller: controller),
              SizedBox(width: 10), // Space for the FAB
              _buildNavItem(
                  icon: FontAwesomeIcons.calendarDays,
                  label: 'Calendar',
                  index: 2,
                  controller: controller),
            ],
          ),
        ),
      ),
    ),
  );
}

// ✅ Bottom Navigation Bar Item
Widget _buildNavItem({
  required IconData icon,
  required String label,
  required int index,
  required NavigationController controller,
}) {
  final isSelected = controller.selectedIndex.value == index;

  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        HapticFeedback.lightImpact();
        controller.selectedIndex.value = index;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: isSelected ? 1.2 : 1.0,
              child: Icon(
                icon,
                color: isSelected ? AppColors.colorsBlue : Colors.black54,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                color: isSelected ? AppColors.colorsBlue : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ✅ Navigation Controller
class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isFabExpanded = false.obs;
  final screens = [
    const HomeScreen(greeting: '', leadId: ''),
    const Opportunity(leadId: ''),
    const Calender(leadId: '', leadName: ''),
  ];
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smart_assist/main.dart';
// import 'package:smart_assist/pages/calenderPages/calender.dart';
// import 'package:smart_assist/pages/home_screens/home_screen.dart';
// import 'package:smart_assist/pages/home_screens/opportunity.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

// class BottomNavigation extends StatelessWidget {
//   BottomNavigation({super.key});

//   final NavigationController controller = Get.put(NavigationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => controller.screens[controller.selectedIndex.value],
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 10,
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Obx(
//               () => Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildNavItem(
//                     icon: FontAwesomeIcons.magnifyingGlass,
//                     label: 'Leads',
//                     index: 0,
//                     controller: controller,
//                   ),
//                   _buildNavItem(
//                     icon: FontAwesomeIcons.calendarDays,
//                     label: 'Calendar',
//                     index: 2,
//                     controller: controller,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildNavItem({
//   required IconData icon,
//   required String label,
//   required int index,
//   required NavigationController controller,
// }) {
//   final isSelected = controller.selectedIndex.value == index;

//   return Material(
//     color: Colors.transparent,
//     child: InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () {
//         HapticFeedback.lightImpact();
//         controller.selectedIndex.value = index;
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AnimatedScale(
//               duration: const Duration(milliseconds: 200),
//               scale: isSelected ? 1.2 : 1.0,
//               child: Icon(
//                 icon,
//                 color: isSelected ? Colors.blue : Colors.black54,
//                 size: 22,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                 color: isSelected ? Colors.blue : Colors.black54,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// class NavigationController extends GetxController {
//   final RxInt selectedIndex = 0.obs;
//   final screens = [
//     const HomeScreen(
//       greeting: '',
//       leadId: '',
//     ),
//     const Opportunity(leadId: ''),
//     const Calender(
//       leadId: '',
//       leadName: '',
//     )
//   ];
// }
