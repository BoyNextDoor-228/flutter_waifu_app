import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class AllPictures extends StatefulWidget {
  AllPictures({Key? key}) : super(key: key);

  @override
  State<AllPictures> createState() => _AllPicturesState();
}

class _AllPicturesState extends State<AllPictures> with AutomaticKeepAliveClientMixin<AllPictures>{
  late Future<List<String>> imagesUrlsFuture;

  Future<List<String>> getImagesUrls(BuildContext context) async {
    final waifuRawData = await http.post(
        Uri.parse("https://api.waifu.pics/many/sfw/waifu"), body: {"": ""});
    final List<String> waifuPicsUrls = waifuRawData.body
        .substring(
            waifuRawData.body.indexOf("[") + 1, waifuRawData.body.indexOf("]"))
        .split(",");
    final pureWaifuUrls = waifuPicsUrls.map((e) => e.substring(1, e.length - 1)).toList();
    return pureWaifuUrls;
  }

  @override
  void initState() {
    super.initState();
    imagesUrlsFuture = getImagesUrls(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: FutureBuilder<List<String>>(
            future: imagesUrlsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final imagesUrls = snapshot.data!;
                return WaifuListView(imagesUrls);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  @override
  bool get wantKeepAlive => true;
}

Widget WaifuListView(List<String> imagesUrls) => MasonryGridView.count(
  itemCount: imagesUrls.length,
  crossAxisCount: 2,
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  itemBuilder: (context, index) {
    return WaifuItem(imagesUrls[index]);
  },
);

Widget WaifuItem (String waifuPicUrl) =>
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      shadowColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: waifuPicUrl,
              fadeInDuration: const Duration(milliseconds: 100),
              placeholder: (context, url) => Transform.scale(
                scale: 0.25,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              SizedBox.shrink(),
              Icon(Icons.more_horiz, color: Colors.grey)
            ],
          )
        ],
      )

    );