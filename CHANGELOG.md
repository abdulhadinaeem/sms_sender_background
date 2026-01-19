## 1.0.7

**Bug Fixes:**
* Fixed SecurityException on devices with stricter security policies when using dual SIM functionality
* Added automatic fallback to `SmsManager.getDefault()` when subscription-based SmsManager fails
* Improved compatibility with apps distributed outside Google Play (unknown sources)

**New Features:**
* Added `checkPhoneStatePermission()` method to check READ_PHONE_STATE permission
* Added `requestPhoneStatePermission()` method to request READ_PHONE_STATE permission
* Added READ_PHONE_STATE permission to manifest (optional, only needed for dual SIM support)

**Improvements:**
* Enhanced error handling with proper fallback mechanisms
* Better logging for debugging SIM slot selection issues
* Updated documentation with detailed permission requirements

## 1.0.5

Initial release with the following features:
* Send SMS messages with support for dual SIM cards
* Automatic permission handling (request and check SMS permissions)
* Support for long messages (automatically splits into multi-part messages)
* Comprehensive error handling and status reporting
* Example app demonstrating all features
