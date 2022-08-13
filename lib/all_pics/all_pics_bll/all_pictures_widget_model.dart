import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu_app/all_pics/all_pics_bll/all_pictures_model.dart';
import 'package:waifu_app/all_pics/all_pics_ui/all_waifus_screen.dart';



abstract class IWaifusWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<String>>> get waifuPicsUrls;
  ListenableState<EntityState<String>> get errorText;
}

WaifusWidgetModel createWaifusWidgetModel (BuildContext context) {
  return WaifusWidgetModel(AllPicturesModel());
}

class WaifusWidgetModel extends WidgetModel<AllPictures, AllPicturesModel> implements IWaifusWidgetModel {

  WaifusWidgetModel(super.model);

  @override
  ListenableState<EntityState<List<String>>> get waifuPicsUrls => model.waifusPicsUrl;

  @override
  ListenableState<EntityState<String>> get errorText => model.errorText;
}