import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/calenderPages/calender.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/pages/home_screens/opportunity.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🛠️ Main Page Content (Screens)
          Obx(() => controller.screens[controller.selectedIndex.value]),

          // 🛠️ Popup Menu (Shown when FAB is expanded)
          Obx(() {
            return controller.isFabExpanded.value
                ? Positioned(
                    bottom: 100, // Ensures it is above the navigation bar
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    child: _buildPopupMenu(controller),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          Obx(() => _buildFloatingActionButton(controller, context)),
      bottomNavigationBar: Container(
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
                    icon: Icons.people_alt_outlined,
                    label: 'Leads',
                    index: 0,
                    controller: controller,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          .01), // Space for the FAB
                  _buildNavItem(
                    icon: FontAwesomeIcons.calendarDays,
                    label: 'Calendar',
                    index: 2,
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.blue.withOpacity(0.3),
            //     blurRadius: 10,
            //     spreadRadius: 3,
            //   )
            // ],
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

// Widget _buildPopupMenu(NavigationController controller, BuildContext context) {
//   return Obx(() {
//     if (!controller.isFabExpanded.value)
//       return SizedBox.shrink(); // ✅ Hide when collapsed

//     return Stack(
//       children: [
//         // 🛠️ Dark Overlay when expanded
//         Positioned.fill(
//           child: GestureDetector(
//             onTap: () {
//               controller.isFabExpanded.value = false; // ✅ Close on tap outside
//             },
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               color: Colors.black.withOpacity(0.5), // ✅ Smooth fade-in effect
//             ),
//           ),
//         ),

//         // 🛠️ Animated Popup Items (Slide from Right)
//         Positioned(
//           bottom: 90, // Adjust height as needed
//           right: MediaQuery.of(context).size.width / 2 - 50, // Center-right
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               _buildPopupItem(controller, Icons.message, "Lead", 50),
//               _buildPopupItem(controller, Icons.event, "Followup", 40),
//               _buildPopupItem(controller, Icons.message, "Appointment", 30),
//               _buildPopupItem(controller, Icons.event, "Test Drive", 20),
//             ],
//           ),
//         ),
//       ],
//     );
//   });
// }



Widget _buildPopupMenu(NavigationController controller) {
  return Positioned(
    bottom: 20,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildPopupItem(controller, Icons.message, "Lead", -45, -1),
        _buildPopupItem(controller, Icons.event, "Followup", 45, -1),
        _buildPopupItem(controller, Icons.message, "Appointment", -80, 80),
        _buildPopupItem(controller, Icons.event, "Test Drive", 85, 80),
      ],
    ),
  );
}

Widget _buildPopupItem(NavigationController controller, IconData icon,
    String label, double dx, double dy) {
  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 0, end: controller.isFabExpanded.value ? 1 : 0),
    duration: const Duration(milliseconds: 300),
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(dx * value, dy * value),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(30),
              // elevation: 5,
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print("$label clicked");
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Icon(icon, color: Colors.blue, size: 24),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Opacity(
              opacity: value,
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

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

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isFabExpanded = false.obs;
  final screens = [
    const HomeScreen(
      greeting: '',
      leadId: '',
    ),
    const Opportunity(leadId: ''),
    const Calender(
      leadId: '',
      leadName: '',
    )
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
