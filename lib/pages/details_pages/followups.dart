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
                                iconPath: 'assets/whatsapp.png',
                                title: 'Phone Number',
                                subtitle: '2387429384',
                              ),
                              ContactRow(
                                iconPath: 'assets/blue_mail.png',
                                title: 'Email',
                                subtitle: 'Tira@gmail.com',
                              ),
                              ContactRow(
                                iconPath: 'assets/blue_bag.png',
                                title: 'Company',
                                subtitle: 'Abc Pvt Ltd',
                              ),
                              ContactRow(
                                iconPath: 'assets/location.png',
                                title: 'Address',
                                subtitle: 'Mumbai',
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right Column with Profile and Actions
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/profile.png',
                                width: 80,
                                height: 80,
                                semanticLabel: 'Profile Picture',
                              ),
                            ),
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
                                Image.asset(
                                  'assets/cloud.png',
                                  width: 30,
                                  height: 30,
                                  semanticLabel: 'Cloud Icon',
                                ),
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
                Row(
                  children: [
                    Row(
                      children: [],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 247, 243, 243),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset('assets/profile.png'),
                                  ),
                                  Text('Tira',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text('1 day left'),
                                  )
                                ],
                              ),
                              const Text(
                                'By Lily',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'Purchased the vehicle',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                  Icon(Icons.done)
                                ],
                              ),
                              Container(
                                // height: 300,
                                width: 300,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black))),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
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
