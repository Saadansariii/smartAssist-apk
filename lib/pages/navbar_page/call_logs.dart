import 'package:flutter/material.dart'; 
import 'package:permission_handler/permission_handler.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({super.key});

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  bool isLoading = true;
  // List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    // fetchContacts();
  }

  // Future<void> fetchContacts() async {
  //   // Request permission to access contacts
  //   PermissionStatus status = await Permission.contacts.request();

  //   if (status.isGranted) {
  //     final Iterable<Contact> contacts = await ContactsService.getContacts();
  //     setState(() {
  //       _contacts = contacts.toList();
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     // Handle permission denial here
  //     // For example, show a message or dialog
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        backgroundColor: Colors.blue,
      ),
      // body: isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemCount: _contacts.length,
      //         itemBuilder: (context, index) {
      //           final contact = _contacts[index];
      //           return ListTile(
      //             title: Text(contact.displayName ?? 'Unknown'),
      //             subtitle: Text(contact.phones?.isNotEmpty == true
      //                 ? contact.phones!.first.value ?? 'No number'
      //                 : 'No phone number'),
      //           );
      //         },
      //       ),
    );
  }
}
