package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new dev.flutter.plugins.integration_test.IntegrationTestPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin integration_test, dev.flutter.plugins.integration_test.IntegrationTestPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.sms_sender.SmsSenderPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin sms_sender_background, com.example.sms_sender.SmsSenderPlugin", e);
    }
  }
}
