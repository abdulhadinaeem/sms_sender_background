# SMS Sender Background

A Flutter plugin for sending SMS messages with support for dual SIM cards, permission handling, and multi-part messages.

## Features

- Send SMS messages from your Flutter app
- Support for dual SIM cards (specify SIM slot)
- Automatic permission handling (request and check SMS permissions)
- Support for long messages (automatically splits into multi-part messages)
- Error handling and status reporting

## Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  sms_sender_background: ^1.0.5
```

### Android Setup

Add the following permissions to your Android Manifest (`android/app/src/main/AndroidManifest.xml`):

```xml
<uses-permission android:name="android.permission.SEND_SMS"/>
<!-- Optional: Required only for dual SIM support -->
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
```

**Note about READ_PHONE_STATE permission:**
- This permission is **optional** and only needed if you want to use dual SIM functionality
- If not granted, the plugin will automatically fall back to using the default SIM card
- This ensures the plugin works reliably even on devices with stricter security policies or when distributed outside Google Play

### Usage

```dart
import 'package:sms_sender_background/sms_sender.dart';;

// Create an instance
final smsSender = SmsSender();

// Check SMS permission
bool hasPermission = await smsSender.checkSmsPermission();

// Request permission if needed
if (!hasPermission) {
  hasPermission = await smsSender.requestSmsPermission();
}

// Optional: Check and request READ_PHONE_STATE permission for dual SIM support
// If not granted, the plugin will use the default SIM card
bool hasPhoneStatePermission = await smsSender.checkPhoneStatePermission();
if (!hasPhoneStatePermission) {
  hasPhoneStatePermission = await smsSender.requestPhoneStatePermission();
}

// Send SMS
if (hasPermission) {
  try {
    bool success = await smsSender.sendSms(
      phoneNumber: '+1234567890',
      message: 'Hello from Flutter!',
      simSlot: 0, // Optional: specify SIM slot (0 or 1)
    );
    print('SMS sent: $success');
  } catch (e) {
    print('Error sending SMS: $e');
  }
}
```

## Additional Features

### Dual SIM Support

To send an SMS using a specific SIM card:

```dart
// Optional: Request READ_PHONE_STATE permission for dual SIM support
bool hasPhoneStatePermission = await smsSender.checkPhoneStatePermission();
if (!hasPhoneStatePermission) {
  hasPhoneStatePermission = await smsSender.requestPhoneStatePermission();
}

await smsSender.sendSms(
  phoneNumber: '+1234567890',
  message: 'Hello!',
  simSlot: 1, // Use second SIM card
);
```

**Important Notes:**
- Dual SIM support requires the `READ_PHONE_STATE` permission
- If this permission is not granted, the plugin will automatically fall back to using the default SIM card
- This ensures compatibility across all devices, including those with stricter security policies
- The fallback mechanism works reliably even when apps are installed from unknown sources

### Long Messages

The plugin automatically handles long messages by splitting them into multiple parts:

```dart
await smsSender.sendSms(
  phoneNumber: '+1234567890',
  message: 'A very long message that will be automatically split...',
);
```

## Error Handling

The plugin provides detailed error information through exceptions:

- `PlatformException` with code "PERMISSION_DENIED" when SMS permission is not granted
- `PlatformException` with code "INVALID_ARGUMENT" when phone number or message is empty
- `PlatformException` with code "SMS_SEND_ERROR" when SMS sending fails

## Contributing

Feel free to contribute to this project:

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
