import 'package:flutter/material.dart';

class AppointmentWidget extends StatefulWidget {
  final List<dynamic> appointments;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const AppointmentWidget({
    super.key,
    required this.appointments,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  _AppointmentWidgetState createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.appointments.isEmpty)
                Center(child: Text('No appointments available for today.')),
              ...widget.appointments.map((appointment) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffE0EAF6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment['subject'] ?? 'No Subject',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${appointment['start_date']}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${appointment['start_time']} - ${appointment['end_time']}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appointment['lead_email'] ?? 'No Email',
                            style: TextStyle(
                                fontSize: screenWidth > 600 ? 18 : 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(Icons.camera_enhance_outlined),
                              SizedBox(width: 10),
                              Text('Appointment '),
                              SizedBox(width: 2),
                              Icon(
                                Icons.circle,
                                size: 10,
                              ),
                              SizedBox(width: 2),
                              Text(
                                '${appointment['start_time']} - ${appointment['end_time']}',
                                style: TextStyle(
                                    fontSize: screenWidth > 600 ? 14 : 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            appointment['location'] ?? 'No Location',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            appointment['PMI'] ?? 'No PMI',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
