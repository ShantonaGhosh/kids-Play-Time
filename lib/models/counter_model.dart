import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_play_time/app/variables.dart';
import 'package:kids_play_time/views/qr_code_scaner_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterModel extends ChangeNotifier {
  int _min = 0;
  int _sec = 59;
  int _playtime = 0;

  setNewMinute(int newMin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _playtime = newMin - 1;
    _min = newMin - 1;
    pref.setInt('min', _min);
  }

  final Duration _counter = const Duration(seconds: 1);

  Timer? _time;

  initiateTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _min = pref.getInt('min') ?? 0;
    _sec = pref.getInt('sec') ?? 59;
    _playtime = pref.getInt('playTime') ?? 0;
    CommonVariables.playlist = pref.getString('videoUrl');
  }

  int get getMinute => _min;

  int get getSeconds => _sec;

  get isTimeZero => (_min + _sec == 0);

  reset() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('min');
    pref.remove('sec');
    pref.remove('playTime');
    pref.remove('videoUrl');
    await initiateTime();
  }

  String get viewedTime {
    int sec = 59 - _sec;
    int min = _playtime - _min < 0 ? 0 : _playtime - _min;
    return '${min.toString().length == 1 ? '0' + min.toString() : min} Minutes, ${sec.toString().length == 1 ? '0' + sec.toString() : sec} Seconds';
  }

  Future<void> startTimer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    timerStop();

    _time = Timer.periodic(_counter, (Timer timer) {
      if (_min + _sec != 0) {
        if (_sec != 0) {
          _sec--;
          pref.setInt('sec', _sec);
          notifyListeners();
        } else {
          _sec = 59;
          pref.setInt('sec', _sec);
          _min--;
          pref.setInt('min', _min);
          notifyListeners();
        }
      } else {
        reset();
        timer.cancel();
        notifyListeners();
        Get.offAll(const QrPage());
      }
    });
  }

  void timerStop() => _time?.cancel();
}
