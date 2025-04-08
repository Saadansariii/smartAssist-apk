import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({super.key});

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  bool isLoading = true;
  Iterable<CallLogEntry> _callLogs = [];

  @override
  void initState() {
    super.initState();
    fetchCallLogs();
  }

  Future<void> fetchCallLogs() async {
    if (await Permission.phone.request().isGranted) {
      final Iterable<CallLogEntry> result = await CallLog.get();
      setState(() {
        _callLogs = result;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // You can show a dialog or message here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Logs"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _callLogs.length,
              itemBuilder: (context, index) {
                final entry = _callLogs.elementAt(index);
                return ListTile(
                  title: Text(entry.name ?? entry.number ?? "Unknown"),
                  subtitle: Text("Duration: ${entry.duration}s"),
                  trailing: Text(entry.callType.toString().split('.').last),
                );
              },
            ),
    );
  }
}
