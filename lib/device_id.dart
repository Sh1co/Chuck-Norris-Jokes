import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

const _charList =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class DeviceIdentifier {
  static late String deviceId;

  static Future<void> initUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceIdentifier = prefs.getString("DeviceID");
    if (deviceIdentifier == null) {
      Random rnd = Random();
      deviceIdentifier = String.fromCharCodes(Iterable.generate(
          12, (_) => _charList.codeUnitAt(rnd.nextInt(_charList.length))));
      prefs.setString("DeviceID", deviceIdentifier);
    }
    deviceId = deviceIdentifier;
  }
}
