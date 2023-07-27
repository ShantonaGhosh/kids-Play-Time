import 'package:flutter/widgets.dart';
import 'package:kids_play_time/app/constant_web.dart';
import 'package:kids_play_time/network/repository/repository_helper.dart';

class FrontEndRepository {
  BuildContext context;

  FrontEndRepository({required this.context});

  Future<ResponseObject> getVideoList(String url) async {
    return RepositoryHelper(context).apiCall(url: url);
  }
}
