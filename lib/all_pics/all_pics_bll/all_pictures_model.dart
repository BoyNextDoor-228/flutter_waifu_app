import "package:elementary/elementary.dart";
import 'package:http/http.dart' as http;

class AllPicturesModel extends ElementaryModel {
  final waifusPicsUrl = EntityStateNotifier<List<String>>()..loading();


  @override
  init(){
    super.init();
    getImagesUrls();
  }

  void getImagesUrls() async {
    final waifuRawData = await http.post(
        Uri.parse("https://api.waifu.pics/many/sfw/waifu"), body: {"": ""});
    final List<String> waifuPicsUrls = waifuRawData.body
        .substring(
        waifuRawData.body.indexOf("[") + 1, waifuRawData.body.indexOf("]"))
        .split(",");
    final pureWaifuUrls = waifuPicsUrls.map((e) => e.substring(1, e.length - 1)).toList();
    waifusPicsUrl.content(pureWaifuUrls);
  }

}