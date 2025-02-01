import 'package:flutter/material.dart';

class ContactRow extends StatelessWidget {
  final IconData icon; // Use IconData for Material Icons
  final String title;
  final String subtitle;
  final Color? iconColor; // Optional icon color

  const ContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor, // Allow customization of icon color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon, // Use Icon widget instead of Image.asset
            size: 30,
            color: iconColor ?? Colors.blue, // Default color
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
