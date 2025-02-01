import 'package:flutter/material.dart';
import 'package:smart_assist/widgets/details/contactrow.dart';

class FollowupsDetails extends StatelessWidget {
  const FollowupsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Followups Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 134, 134, 134),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Existing Container
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 243, 243),
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Column with Contact Details
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContactRow(
                                icon: Icons.phone,
                                title: 'Phone Number',
                                subtitle: '2387429384',
                              ),
                              ContactRow(
                                icon: Icons.email,
                                title: 'Email',
                                subtitle: 'Tira@gmail.com',
                              ),
                              ContactRow(
                                icon: Icons.local_post_office_outlined,
                                title: 'Company',
                                subtitle: 'Abc Pvt Ltd',
                              ),
                              ContactRow(
                                icon: Icons.location_on,
                                title: 'Address',
                                subtitle: 'Mumbai',
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right Column with Profile and Actions
                      Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                      )),
                                  const Text(
                                    'Tira',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        'assets/whatsapp.png',
                                        width: 30,
                                        height: 30,
                                        semanticLabel: 'WhatsApp Icon',
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        'assets/redirect_msg.png',
                                        width: 30,
                                        height: 30,
                                        semanticLabel: 'Redirect Message Icon',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Additional Row
                const SizedBox(height: 20), // Spacer
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('History',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey))
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  const HistoryRow({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 30,
            height: 30,
            semanticLabel: title,
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
