import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_play_time/network/models/video_list_model.dart';
import 'package:kids_play_time/views/play_page.dart';
import 'package:kids_play_time/views/widgets/available_time_banner.dart';
import 'package:provider/provider.dart';

import '../models/counter_model.dart';

class PlayListPage extends StatelessWidget {
  const PlayListPage({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final List<Playlist>? playlist;

  @override
  Widget build(BuildContext context) {
    // CounterModel().reset();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBar(
            backgroundColor: Colors.deepPurple,
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
        body: ListView.separated(
          itemCount: playlist?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            Playlist videoItem = playlist![index];
            String youtubeId = videoItem.link!.substring(videoItem.link!.length - 11);
            return InkWell(
              onTap: () {
                Provider.of<CounterModel>(context, listen: false).timerStop();
                Get.to(PlayPage(youtubeId: youtubeId));
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
                    height: 180,
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage('https://img.youtube.com/vi/$youtubeId/0.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: Icon(Icons.play_arrow)),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text('${videoItem.duration ?? ""} min'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
