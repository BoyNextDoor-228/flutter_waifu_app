import 'dart:convert' as JSON;

import "package:elementary/elementary.dart";
import 'package:http/http.dart' as http;


class AllPicturesModel extends ElementaryModel {
  final waifusPicsUrl = EntityStateNotifier<List<String>>()..loading();

  @override
  init(){
    super.init();
    _getImagesUrls();
  }

  void onRetryPressed() => _getImagesUrls();

  void _getImagesUrls() async {
    try{
      final waifuRawData = await http.post(Uri.parse("https://api.waifu.pics/many/sfw/waifu"), body: {"": ""});
      var dataStringg = JSON.jsonDecode(waifuRawData.body);
      waifusPicsUrl.content( List<String>.from(dataStringg['files']) );
    } on Exception
    catch(exception){
      waifusPicsUrl.error(exception);
    }
  }

}