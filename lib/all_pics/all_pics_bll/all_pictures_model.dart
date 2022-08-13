import 'dart:convert' as JSON;

import "package:elementary/elementary.dart";
import 'package:http/http.dart' as http;


class AllPicturesModel extends ElementaryModel {
  final waifusPicsUrl = EntityStateNotifier<List<String>>()..loading();
  var errorText = EntityStateNotifier<String>()..loading();

  @override
  init(){
    super.init();
    getImagesUrls();
  }

  // void getImagesUrls() async {
  //   try{
  //     final waifuRawData = await http.post(
  //         Uri.parse("https://api.waifu.pics/many/sfw/waifu"), body: {"": ""});
  //     final List<String> waifuPicsUrls = waifuRawData.body
  //         .substring(
  //         waifuRawData.body.indexOf("[") + 1, waifuRawData.body.indexOf("]"))
  //         .split(",");
  //     final pureWaifuUrls = waifuPicsUrls.map((e) => e.substring(1, e.length - 1)).toList();
  //     waifusPicsUrl.content(pureWaifuUrls);
  //     isLoading.content(false);
  //   }
  //     catch(e){
  //       errorText.content(e.toString());
  //       isLoading.content(false);
  //     }
  // }

  void getImagesUrls() async {
    try{
      final waifuRawData = await http.post(Uri.parse("https://api.waifu.pics/many/sfw/waifu"), body: {"": ""});
      var dataStringg = JSON.jsonDecode(waifuRawData.body);
      waifusPicsUrl.content( List<String>.from(dataStringg['files']) );
    }
    catch(e){
      errorText.content(e.toString());
    }
  }

}