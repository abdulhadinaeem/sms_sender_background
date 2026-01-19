/// A Flutter plugin for sending SMS messages with support for dual SIM cards.
///
/// This plugin provides functionality to:
/// * Send SMS messages
/// * Check and request SMS permissions
/// * Support for dual SIM cards
/// * Handle long messages automatically
library sms_sender;

import 'dart:async';
import 'package:flutter/services.dart';

/// A Flutter plugin for sending SMS messages.
class SmsSender {
  static const MethodChannel _channel =
      MethodChannel('com.marketing_gateway.sms_sender');

  /// Sends an SMS message to the specified phone number.
  ///
  /// Parameters:
  /// - [phoneNumber]: The recipient's phone number in international format (e.g., '+1234567890')
  /// - [message]: The text message to send
  /// - [simSlot]: (Optional) The SIM card slot to use for dual-SIM devices (0 or 1). Defaults to 0
  ///
  /// Returns:
  /// - [Future<bool>]: true if the message was sent successfully, false otherwise
  ///
  /// Throws:
  /// - [PlatformException] if there's an error sending the message or if SMS permission is not granted
  Future<bool> sendSms({
    required String phoneNumber,
    required String message,
    int simSlot = 0,
  }) async {
    try {
      final bool? result = await _channel.invokeMethod('sendSms', {
        'phoneNumber': phoneNumber,
        'message': message,
        'simSlot': simSlot,
      });
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Checks if the app has permission to send SMS messages.
  ///
  /// Returns:
  /// - [Future<bool>]: true if SMS permission is granted, false otherwise
  Future<bool> checkSmsPermission() async {
    try {
      final bool? result = await _channel.invokeMethod('checkSmsPermission');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Requests SMS permission from the user.
  ///
  /// Returns:
  /// - [Future<bool>]: true if permission was granted, false if denied
  Future<bool> requestSmsPermission() async {
    try {
      final bool? result = await _channel.invokeMethod('requestSmsPermission');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Checks if the app has permission to read phone state (required for dual SIM support).
  ///
  /// Returns:
  /// - [Future<bool>]: true if READ_PHONE_STATE permission is granted, false otherwise
  Future<bool> checkPhoneStatePermission() async {
    try {
      final bool? result =
          await _channel.invokeMethod('checkPhoneStatePermission');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Requests READ_PHONE_STATE permission from the user (required for dual SIM support).
  ///
  /// Note: This permission is optional. If not granted, the plugin will fall back to
  /// using the default SIM card for sending SMS.
  ///
  /// Returns:
  /// - [Future<bool>]: true if permission was granted, false if denied
  Future<bool> requestPhoneStatePermission() async {
    try {
      final bool? result =
          await _channel.invokeMethod('requestPhoneStatePermission');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }
}
