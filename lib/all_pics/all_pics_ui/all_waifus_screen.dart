import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:waifu_app/all_pics/all_pics_bll/all_pictures_widget_model.dart';

class AllPictures extends ElementaryWidget<IWaifusWidgetModel> {
  const AllPictures({Key? key}) : super(createWaifusWidgetModel, key: key);

  @override
  Widget build(IWaifusWidgetModel wm) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: EntityStateNotifierBuilder<List<String>>(
          listenableEntityState: wm.waifuPicsUrls,
          builder: (_, infoPicsUrls) {
            return WaifuList(imagesUrls: infoPicsUrls!);
          },
          loadingBuilder: (_, __) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}

class WaifuList extends StatelessWidget {
  final List<String> imagesUrls;
  const WaifuList({Key? key, required this.imagesUrls }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      key: PageStorageKey<List<String>>(imagesUrls),
      itemCount: imagesUrls.length,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return WaifuItem(waifuPicUrl: imagesUrls[index]);
      },
    );
  }
}



class WaifuItem extends StatelessWidget {
  final String waifuPicUrl;
  const WaifuItem({Key? key, required this.waifuPicUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        key: PageStorageKey<String>(waifuPicUrl),
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
                fadeInDuration: const Duration(milliseconds: 300),
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
  }
}