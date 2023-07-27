import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_play_time/app/variables.dart';
import 'package:kids_play_time/models/counter_model.dart';
import 'package:kids_play_time/network/models/video_list_model.dart';
import 'package:kids_play_time/network/network_controller.dart';
import 'package:kids_play_time/views/play_list_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.deepPurple.shade800,
            flexibleSpace: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset('assets/doll.png', width: 50),
                const SizedBox(height: 5),
                const Text(
                  'Kids Play Time',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
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
            const SizedBox(height: 15),
            const Center(
              child: Icon(
                Icons.qr_code,
                size: 100,
                color: Colors.white24,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Plz scan your QR code\nfor next page',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 280,
              height: 280,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  cameraFacing: CameraFacing.back,
                  overlay: QrScannerOverlayShape(
                    borderRadius: 20,
                    borderColor: Colors.purple,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      CommonVariables.playlist = scanData.code;
      pref.setString('videoUrl', CommonVariables.playlist ?? '');
      controller.pauseCamera();

      if (scanData.code != null) {
        await NetworkController(context: context).getVideoList(scanData.code!).then((model) {
          if (model != null) {
            VideoListModel videoListModel = model;
            if (videoListModel.playLimit != null) {
              Provider.of<CounterModel>(context, listen: false).setNewMinute(videoListModel.playLimit!);
            }
            Get.off(() => PlayListPage(playlist: videoListModel.playlist))?.then((value) => controller.resumeCamera());
          }
        });
      } else {
        controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
