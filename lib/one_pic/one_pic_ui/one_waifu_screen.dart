import 'package:elementary/elementary.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:waifu_app/one_pic/one_pic_bll/one_picture_widget_model.dart';

class OnePicture extends ElementaryWidget<IWaifuWidgetModel> {
  OnePicture({Key? key}) : super(createWaifuWidgetModel);


  @override
  Widget build(IWaifuWidgetModel wm) {
    return Container(
        key: const PageStorageKey<String>("One Waifu Pic"),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: EntityStateNotifierBuilder<String>(
          listenableEntityState: wm.waifuUrl,
          builder: (_, infoPicUrls) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(infoPicUrls!, fit: BoxFit.cover),
            );
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


// FutureBuilder<String>(
// future: imageUrlFuture,
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// final imageUrl = snapshot.data!;
// return Padding(
// padding: const EdgeInsets.all(20.0),
// child: Image.network(imageUrl, fit: BoxFit.cover),
// );
// } else {
// return const Center(child: CircularProgressIndicator());
// }
// }
// )



