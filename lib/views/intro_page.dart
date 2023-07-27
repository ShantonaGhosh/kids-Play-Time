import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:kids_play_time/app/variables.dart';
import 'package:kids_play_time/models/counter_model.dart';
import 'package:kids_play_time/network/models/video_list_model.dart';
import 'package:kids_play_time/network/network_controller.dart';
import 'package:kids_play_time/views/play_list_page.dart';
import 'package:kids_play_time/views/qr_code_scaner_page.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Provider.of<CounterModel>(context, listen: false).initiateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
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
                  )
                ],
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  'Kids Contents',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'Lets Play',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Carousel(
                  width: 380,
                  height: 340,
                  indicatorBarColor: Colors.transparent,
                  autoScrollDuration: const Duration(seconds: 2),
                  animationPageDuration: const Duration(milliseconds: 1500),
                  activateIndicatorColor: Colors.deepPurple.shade200,
                  animationPageCurve: Curves.easeInOut,
                  indicatorBarHeight: 40,
                  indicatorHeight: 20,
                  indicatorWidth: 20,
                  unActivatedIndicatorColor: Colors.grey.withOpacity(0.3),
                  stopAtEnd: false,
                  autoScroll: true,
                  // widgets
                  items: [
                    Image.asset('assets/kids.jpg', fit: BoxFit.contain),
                    Image.asset('assets/kids1.jpg', fit: BoxFit.contain),
                    Image.asset('assets/kids2.jpg', fit: BoxFit.contain),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                  onPressed: () async {
                    if (CounterModel().isTimeZero) {
                      Get.to(const QrPage());
                    } else {
                      if (CommonVariables.playlist != null) {
                        if (CommonVariables.playlist!.isNotEmpty) {
                          await NetworkController(context: context).getVideoList(CommonVariables.playlist!).then((model) {
                            if (model != null) {
                              VideoListModel videoListModel = model;
                              Get.to(() => PlayListPage(playlist: videoListModel.playlist));
                            }
                          });
                        } else {
                          Get.to(const QrPage());
                        }
                      } else {
                        Get.to(const QrPage());
                      }
                    }
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          )),
    );
  }
}
