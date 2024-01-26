import 'dart:async';

import 'package:flutter/material.dart';
import 'package:putra_scada/service/streamDashboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:putra_scada/widget/dashboard.dart';

class dashboardScreen extends StatefulWidget {
  dashboardScreen({super.key});

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
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
          String frequency = _jsonData['Frequency'].toString();
          String steamFlow = _jsonData['SteamFlow'].toString();
          String steamPreasure = _jsonData['SteamPressure'].toString();
          String waterLevel = _jsonData['WaterLevel'].toString();

          List<String> listFrequency = frequency.split(',').skip(1).toList();
          List<String> listSteamFlow = steamFlow.split(',').skip(1).toList();
          List<String> listSteamPreasure =
              steamPreasure.split(',').skip(1).toList();
          List<String> listWaterLevel = waterLevel.split(',').skip(1).toList();

          List<double> doubleListFrequency =
              listFrequency.map((value) => double.parse(value)).toList();
          List<double> doubleListSteamFlow =
              listSteamFlow.map((value) => double.parse(value)).toList();
          List<double> doubleListSteamPreasure =
              listSteamPreasure.map((value) => double.parse(value)).toList();
          List<double> doubleListWaterLevel =
              listWaterLevel.map((value) => double.parse(value)).toList();

          print(doubleListSteamPreasure);

          return SingleChildScrollView(
            child: dashboard(
              steamPreasure:doubleListSteamPreasure[doubleListSteamPreasure.length - 1],
              steamFlow: doubleListSteamFlow[doubleListSteamFlow.length - 1],
              waterLevel: doubleListWaterLevel[doubleListWaterLevel.length - 1],
              turbineFrequency:doubleListFrequency[doubleListFrequency.length - 1],
            ),
          );
        }
        if (!snapshot.hasData) {
          return SingleChildScrollView(
              child: dashboard(
            steamFlow: 0.00,
            steamPreasure: 00.0,
            waterLevel: 0.00,
            turbineFrequency: 0.00,
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
