import 'package:flutter/material.dart';
import 'package:kids_play_time/models/counter_model.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class AvailableTimeBanner extends StatelessWidget {
  const AvailableTimeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterModel counterModel = Provider.of<CounterModel>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: HexColor('#A7B141'),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Available Watch Time',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${counterModel.getMinute.toString().length == 1 ? '0' + counterModel.getMinute.toString() : counterModel.getMinute}:${counterModel.getSeconds.toString().length == 1 ? '0' + counterModel.getSeconds.toString() : counterModel.getSeconds} Minutes',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
