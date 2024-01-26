import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:putra_scada/service/streamThreshold.dart';
import 'package:putra_scada/widget/thresholdCard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:putra_scada/widget/dashboard.dart';

class thresholdScreenV2 extends StatefulWidget {
  thresholdScreenV2({super.key});

  @override
  State<thresholdScreenV2> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<thresholdScreenV2> {
  final DataStream _dataStream = DataStream();
  Map<String, dynamic> _jsonData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataStream.fetchDataFromFirebase();
    Timer.periodic(Duration(seconds: 2), (timer) {
      _dataStream.fetchDataFromFirebase();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dataStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final channel = IOWebSocketChannel.connect('ws://192.168.126.154:80');

    // TODO: implement build
    return StreamBuilder<Map<String, dynamic>>(
      stream: _dataStream.dataStream,
      builder: (context, snapshot) {
        //print('snapshot : ${snapshot.data!}');

        if (snapshot.hasData) {
          _jsonData = snapshot.data!;
          //print('snapshot : $_jsonData');
          String frequency = _jsonData['steamFlow'].toString();
          String steamFlow = _jsonData['steamPressure'].toString();
          String steamPressure = _jsonData['turbineFrequency'].toString();
          String waterLevel = _jsonData['waterLevel'].toString();

          // List<String> listFrequency = frequency.split(',').skip(1).toList();
          // List<String> listSteamFlow = steamFlow.split(',').skip(1).toList();
          // List<String> listSteamPreasure =
          //     steamPreasure.split(',').skip(1).toList();
          // List<String> listWaterLevel = waterLevel.split(',').skip(1).toList();

          // List<double> doubleListFrequency =
          //     listFrequency.map((value) => double.parse(value)).toList();
          // List<double> doubleListSteamFlow =
          //     listSteamFlow.map((value) => double.parse(value)).toList();
          // List<double> doubleListSteamPreasure =
          //     listSteamPreasure.map((value) => double.parse(value)).toList();
          // List<double> doubleListWaterLevel =
          //     listWaterLevel.map((value) => double.parse(value)).toList();

          print('threshold 1 $frequency');
          print('threshold 2 $steamFlow');
          print('threshold 3 $steamPressure');
          print('threshold 4 $waterLevel');

          //print(doubleListSteamPreasure);

          return  SingleChildScrollView(

            child: thresholdCard(steamFlow: steamFlow, steamPressure: steamPressure, turbineFrequency: frequency, waterLevel: waterLevel),
          );
        }
        if (!snapshot.hasData) {
          return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Lottie.asset('lib/assets/lottie/loading.json'),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
