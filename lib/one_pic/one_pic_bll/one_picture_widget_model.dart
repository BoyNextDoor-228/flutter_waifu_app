import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu_app/one_pic/one_pic_bll/one_picture_model.dart';
import 'package:waifu_app/one_pic/one_pic_ui/one_waifu_screen.dart';

abstract class IWaifuWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get waifuUrl;
}

WaifuWidgetModel createWaifuWidgetModel (BuildContext context) {
  return WaifuWidgetModel(OnePictureModel());
}

class WaifuWidgetModel extends WidgetModel<OnePicture, OnePictureModel> implements IWaifuWidgetModel {
  WaifuWidgetModel(super.model);

  @override
  ListenableState<EntityState<String>> get waifuUrl => model.waifuUrl;


}