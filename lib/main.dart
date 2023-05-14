import 'package:flutter/material.dart';
import 'package:soar_quest/soar_quest.dart';

import 'device_id.dart';
import 'firebase/firebase_options.dart';
import 'screens/fav_screen.dart';
import 'screens/jokes_screen.dart';
import 'screens/setting_screen.dart';

late final SQCollection categories;

void main() async {
  await SQApp.init(
    "Tinder with Chuck Norris",
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );

  await DeviceIdentifier.initUserID();
  await initFavsCollection();
  await initSettingScreen();

  SQApp.run([
    const JokesScreen("Jokes", icon: Icons.comment),
    FavoriteJokesScreen(collection: favJokesCollection),
    UserSettings.settingsScreen(),
  ]);
}
