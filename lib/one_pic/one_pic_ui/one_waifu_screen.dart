import 'package:elementary/elementary.dart';
import "package:flutter/material.dart";
import 'package:waifu_app/one_pic/one_pic_bll/one_picture_widget_model.dart';

class OnePicture extends ElementaryWidget<IWaifuWidgetModel> {
  const OnePicture({Key? key}) : super(createWaifuWidgetModel, key: key);

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
              child: Image.network(
                  infoPicUrls!,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress){
                    return (loadingProgress == null ? child : const Center(child:CircularProgressIndicator()));
                  },
              ),
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