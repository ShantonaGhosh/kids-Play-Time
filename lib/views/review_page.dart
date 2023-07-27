import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kids_play_time/views/qr_code_scaner_page.dart';
import 'package:provider/provider.dart';

import '../models/counter_model.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    CounterModel cm = Provider.of<CounterModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBar(
            backgroundColor: Colors.deepPurple.shade700,
            leading: IconButton(
              onPressed: () async {
                int min = Provider.of<CounterModel>(context, listen: false).getMinute;
                int sec = Provider.of<CounterModel>(context, listen: false).getSeconds;
                if (min + sec == 0) {
                  Get.offAll(const QrPage());
                } else {
                  Get.back();
                  // await NetworkController(context: context).getVideoList(CommonVariables.playlist!).then((model) {
                  //   if (model != null) {
                  //     VideoListModel videoListModel = model;
                  //     Get.to(() => PlayListPage(playlist: videoListModel.playlist));
                  //   }
                  // });
                }
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: HexColor('#A7B141'),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Please send your feedback and Rating',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 10),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Current Videos Play Time',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    Provider.of<CounterModel>(context).viewedTime,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Total Remaining Time',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FutureBuilder(
                    builder: (_, __) {
                      return Text(
                        '${cm.getMinute.toString().length == 1 ? '0' + cm.getMinute.toString() : cm.getMinute} Minutes, '
                        '${cm.getSeconds.toString().length == 1 ? '0' + cm.getSeconds.toString() : cm.getSeconds} Seconds',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Send Your Review',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: RatingBar.builder(
                  onRatingUpdate: (rating) {
                    setState(() {});
                    Future.delayed(const Duration(seconds: 1), () {
                      Get.back();
                    });
                  },
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  unratedColor: Colors.deepPurple.shade50,
                  glow: false,
                  minRating: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
