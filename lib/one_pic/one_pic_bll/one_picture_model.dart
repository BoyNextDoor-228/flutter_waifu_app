import 'package:elementary/elementary.dart';
import 'package:http/http.dart' as http;

class OnePictureModel extends ElementaryModel {
  final waifuUrl = EntityStateNotifier<String>()..loading();

  @override
  init() {
    super.init();
    getImageUrl();
  }

void getImageUrl() async {
  final response = await http.get(Uri.parse("https://api.waifu.pics/sfw/waifu"));
  String pureWaifuPicUrl = response.body.substring(response.body.indexOf(":\"")+2, response.body.indexOf("\"}"));
  waifuUrl.content(pureWaifuPicUrl);
}

// Future<String> getImageUrl(BuildContext context) async {
//   final waifuUrl = await http.get(Uri.parse("https://api.waifu.pics/sfw/waifu"));
//   String pureWaifuPicUrl = waifuUrl.body.substring(waifuUrl.body.indexOf(":\"")+2, waifuUrl.body.indexOf("\"}"));
//   return pureWaifuPicUrl;
// }
}