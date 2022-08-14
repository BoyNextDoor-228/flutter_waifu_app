import 'package:elementary/elementary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class OnePictureModel extends ElementaryModel {
  final waifuUrl = EntityStateNotifier<String>()..loading();

  @override
  init() {
    super.init();
    getImageUrl();
  }

void getImageUrl() async {
  final response = await http.get(Uri.parse("https://api.waifu.pics/sfw/waifu"));
  var dataStringg = JSON.jsonDecode(response.body);
  waifuUrl.content(dataStringg["url"]);
}
}