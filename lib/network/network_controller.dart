import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:kids_play_time/app/constant_web.dart';
import 'package:kids_play_time/network/models/video_list_model.dart';
import 'package:kids_play_time/network/repository/frontend_repository.dart';

class NetworkController {
  BuildContext context;

  NetworkController({required this.context});

  Future<VideoListModel?> getVideoList(String url) async {
    VideoListModel? videoData;
    final response = await FrontEndRepository(context: context).getVideoList(url);
    if (response.id == ResponseCode.SUCCESSFUL) {
      videoData = VideoListModel.fromJson(json.decode(response.object.toString()));
    } else {
      print("Something went wrong...");
    }
    return videoData;
  }
}
