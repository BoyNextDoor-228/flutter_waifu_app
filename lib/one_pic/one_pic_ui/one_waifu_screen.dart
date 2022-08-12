import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class OnePicture extends StatefulWidget {
  const OnePicture({Key? key}) : super(key: key);

  @override
  State<OnePicture> createState() => _OnePictureState();
}

class _OnePictureState extends State<OnePicture> with AutomaticKeepAliveClientMixin<OnePicture> {

  late Future<String> imageUrlFuture;

  Future<String> getImageUrl(BuildContext context) async {
    final waifuUrl = await http.get(Uri.parse("https://api.waifu.pics/sfw/waifu"));
    String pureWaifuPicUrl = waifuUrl.body.substring(waifuUrl.body.indexOf(":\"")+2, waifuUrl.body.indexOf("\"}"));
    return pureWaifuPicUrl;
  }

  @override
  void initState() {
    super.initState();
    imageUrlFuture = getImageUrl(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: FutureBuilder<String>(
            future: imageUrlFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final imageUrl = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
