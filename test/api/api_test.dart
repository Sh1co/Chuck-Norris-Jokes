import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:tinder_with_chuck_norris/api/cn_api.dart';

void main() {
  group('Remote API', () {
    test(
        'When joke is requested from chuck norris api'
        'then api respons with a joke in the correct format', () async {
      String queryUrl = 'https://api.chucknorris.io/jokes/random';
      var response = await Dio().get(queryUrl);
      var jsonData = jsonDecode(response.toString());

      Joke joke = Joke.fromJson(jsonData);

      expect(joke.value.isEmpty, isFalse);
      expect(joke.id.isEmpty, isFalse);
      expect(joke.url.isEmpty, isFalse);
    });

    test(
        'When categories are requested from chuck norris api'
        'then api respons with a list of categories', () async {
      String queryUrl = "https://api.chucknorris.io/jokes/categories";
      var response = await Dio().get(queryUrl);
      var responseStr = response.toString();
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

      expect(jokesCategories.isEmpty, isFalse);
    });
  });

  group('API Class', () {
    test(
        'When joke is requested from chuck norris api class'
        'then class returns a Joke object', () async {
      var joke = await ChuckNorrisApi.getJoke();
      expect(joke, isInstanceOf<Joke>());
      expect(joke.value != "Failed to load joke, check internet connection",
          isTrue);
      expect(joke.value.isEmpty, isFalse);
      expect(joke.id.isEmpty, isFalse);
      expect(joke.url.isEmpty, isFalse);
    });

    test(
        'When categories are requested from chuck norris api class'
        'then class respons with a list of categories', () async {
      var jokesCategories = await ChuckNorrisApi.getCategories();
      expect(jokesCategories.isEmpty, false);
    });
  });
}
