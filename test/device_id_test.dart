import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinder_with_chuck_norris/device_id.dart';

void main() {
  test(
      'When device id is requested from DeviceIdentifier'
      'then a unique presistent ID is returned', () async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await DeviceIdentifier.initUserID();
    var firstId = DeviceIdentifier.deviceId;

    expect(firstId, isInstanceOf<String>());
    expect(firstId.isEmpty, isFalse);

    var secondId = DeviceIdentifier.deviceId;
    expect(secondId == firstId, isTrue);

    prefs.clear();
    await DeviceIdentifier.initUserID();
    var thirdId = DeviceIdentifier.deviceId;
    expect(thirdId == firstId, isFalse);
  });
}
