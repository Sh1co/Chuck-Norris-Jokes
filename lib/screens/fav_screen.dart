import 'package:flutter/material.dart';
import 'package:soar_quest/soar_quest.dart';

import '../device_id.dart';

late SQCollection favJokesCollection;

Future<void> initFavsCollection() async {
  favJokesCollection = FirestoreCollection(
      id: "Favourites",
      fields: [SQStringField("Joke")],
      updates: false,
      adds: false,
      parentDoc:
          SQDoc(DeviceIdentifier.deviceId, collection: SQAuth.usersCollection));
}

class FavoriteJokesScreen extends CollectionScreen {
  FavoriteJokesScreen({required super.collection, super.key})
      : super(icon: Icons.favorite);
}
