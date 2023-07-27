import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_play_time/views/review_page.dart';
import 'package:kids_play_time/views/widgets/available_time_banner.dart';
import 'package:kids_play_time/views/widgets/play_pause_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/counter_model.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key, required this.youtubeId}) : super(key: key);

  final String youtubeId;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _playStatus = false;
  bool _isPlayerReady = false;

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBar(
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
              onPressed: () {
                Provider.of<CounterModel>(context, listen: false).timerStop();
                Get.back();
              },
              icon: const Icon(Icons.chevron_left),
            ),
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset('assets/doll.png', width: 50),
                const SizedBox(height: 5),
                const Text(
                  'Kids Play Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                const AvailableTimeBanner(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            const SizedBox(height: 40),
            AbsorbPointer(
              absorbing: true,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                onReady: () => setState(() => _isPlayerReady = true),
                onEnded: (endData) => Get.back(),
              ),
            ),
            const SizedBox(height: 20.0),
            !_playStatus
                ? PlayerPlayPauseButton(
                    buttonText: 'Play',
                    onPressed: () async {
                      _controller.play();
                      setState(() => _playStatus = true);
                      await Provider.of<CounterModel>(context, listen: false).startTimer();
                    },
                  )
                : PlayerPlayPauseButton(
                    buttonText: 'Stop',
                    buttonColor: Colors.blueGrey.shade300,
                    iconData: Icons.stop,
                    onPressed: () {
                      _controller.pause();
                      setState(() => _playStatus = false);
                      Provider.of<CounterModel>(context, listen: false).timerStop();
                    },
                  ),
            const SizedBox(height: 15),
            SizedBox(
              height: 35,
              width: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade100,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
                onPressed: () => Get.to(const ReviewPage()),
                child: Text(
                  'Review',
                  style: TextStyle(
                    color: Colors.blueGrey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
