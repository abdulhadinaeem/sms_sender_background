import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_sender_background/sms_sender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SmsSenderDemo(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
    );
  }
}

class SmsSenderDemo extends StatefulWidget {
  const SmsSenderDemo({super.key});

  @override
  State<SmsSenderDemo> createState() => _SmsSenderDemoState();
}

class _SmsSenderDemoState extends State<SmsSenderDemo> {
  final _smsSender = SmsSender();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _hasPermission = false;
  String _status = '';

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    try {
      final hasPermission = await _smsSender.checkSmsPermission();
      setState(() {
        _hasPermission = hasPermission;
        _status = hasPermission ? 'Permission granted' : 'Permission denied';
      });
    } catch (e) {
      setState(() {
        _status = 'Error checking permission: $e';
      });
    }
  }

  Future<void> _requestPermission() async {
    try {
      final granted = await _smsSender.requestSmsPermission();
      setState(() {
        _hasPermission = granted;
        _status = granted ? 'Permission granted' : 'Permission denied';
      });
    } catch (e) {
      setState(() {
        _status = 'Error requesting permission: $e';
        print(e);
      });
    }
  }

  Future<void> _sendSms() async {
    if (!_hasPermission) {
      setState(() => _status = 'SMS permission not granted');
      return;
    }

    if (_phoneController.text.isEmpty || _messageController.text.isEmpty) {
      setState(() => _status = 'Please enter phone number and message');
      return;
    }

    try {
      final success = await _smsSender.sendSms(
        phoneNumber: _phoneController.text,
        message: _messageController.text,
      );

      setState(() {
        _status = success ? 'SMS sent successfully' : 'Failed to send SMS';
      });

      if (success) {
        _messageController.clear();
      }
    } on PlatformException catch (e) {
      setState(() {
        _status = 'Error sending SMS: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Sender Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1234567890',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                hintText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Text(
              'Status: $_status',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            if (!_hasPermission)
              ElevatedButton(
                onPressed: _requestPermission,
                child: const Text('Request SMS Permission'),
              )
            else
              ElevatedButton(
                onPressed: _sendSms,
                child: const Text('Send SMS'),
              ),
          ],
        ),
      ),
    );
  }
}
