import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:soar_quest/soar_quest.dart';

part 'cn_api.g.dart';

class ChuckNorrisApi {
  static Future<List<dynamic>> getCategories() async {
    try {
      var response =
          await Dio().get("https://api.chucknorris.io/jokes/categories");
      String responseStr = response.toString();
      final jokesCategories = [];
      String categorie = "";
      for (var i = 0; i < responseStr.length; i++) {
        if (responseStr[i] == '[') {
          continue;
        } else if (responseStr[i] == ',' || responseStr[i] == ']') {
          jokesCategories.add(categorie);
          categorie = "";
          i++;
        } else {
          categorie = categorie + responseStr[i];
        }
      }
      jokesCategories.add("random");
      return jokesCategories;
    } on Exception {
      return [];
    }
  }

  static Future<Joke> getJoke() async {
    String queryUrl = 'https://api.chucknorris.io/jokes/random';
    try {
      final String? category = UserSettings().getSetting("Category");
      // if (category == null) UserSettings.setSettings(settings)
      if (category != "random" && category != null) {
        queryUrl += "?category=$category";
      }
    } catch (e) {
      if (kDebugMode) {
        print("User settings not setup.");
      }
    }
    try {
      var response = await Dio().get(queryUrl);
      var jsonData = jsonDecode(response.toString());

      Joke joke = Joke.fromJson(jsonData);

      return joke;
    } catch (e) {
      Joke failed = Joke(
          icon_url: "",
          id: "",
          url: "",
          value: "Failed to load joke, check internet connection");
      return failed;
    }
  }
}

@JsonSerializable()
class Joke {
  //Ignore used here because this needs to be the same name as the field name returned from the chuck norris API
  // ignore: non_constant_identifier_names
  final String icon_url, id, url, value;

  Joke(
      // ignore: non_constant_identifier_names
      {required this.icon_url,
      required this.id,
      required this.url,
      required this.value});

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  Map<String, dynamic> toJson() => _$JokeToJson(this);
}
