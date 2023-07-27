import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kids_play_time/app/variables.dart';
import 'package:kids_play_time/views/intro_page.dart';
import 'package:kids_play_time/views/splash_screen_page.dart';
import 'package:provider/provider.dart';

import '../models/counter_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(create: (context) => CounterModel()),
        ChangeNotifierProvider<CommonVariables>(create: (context) => CommonVariables()),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
