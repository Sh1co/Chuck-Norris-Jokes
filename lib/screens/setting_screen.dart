import 'package:soar_quest/soar_quest.dart';
import 'package:tinder_with_chuck_norris/api/cn_api.dart';

Future<void> initSettingScreen() async {
  await UserSettings.setSettings([
    SQEnumField(SQStringField("Category"),
        options: await ChuckNorrisApi.getCategories())
  ]);
}
