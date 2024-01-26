import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:putra_scada/model/sensor.dart';
import 'package:putra_scada/screen/logScreen.dart';
import 'package:putra_scada/widget/analyticCard.dart';
import 'package:putra_scada/widget/dashboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:putra_scada/service/streamDashboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:putra_scada/widget/dashboard.dart';

class analyticScreen extends StatefulWidget {
  analyticScreen({super.key});

  @override
  State<analyticScreen> createState() => _analyticScreenState();
}

class _analyticScreenState extends State<analyticScreen> {
  final DataStream _dataStream = DataStream();
  Map<String, dynamic> _jsonData = {};

  //final channel = IOWebSocketChannel.connect('ws://192.168.0.14:80');
  // final List<SensorData> chartData = [
  //       SensorData(DateTime.now().subtract(Duration(hours: 1)), 35),
  //       SensorData(DateTime.now().subtract(Duration(hours: 2)), 28),
  //       SensorData(DateTime.now().subtract(Duration(hours: 3)), 34),
  //       SensorData(DateTime.now().subtract(Duration(hours: 4)), 32),
  //       SensorData(DateTime.now().subtract(Duration(hours: 5)), 40),
  //       SensorData(DateTime.now().subtract(Duration(hours: 6)), 44),
  //       SensorData(DateTime.now().subtract(Duration(hours: 7)), 58),
  //       SensorData(DateTime.now().subtract(Duration(hours: 8)), 75),
  //       SensorData(DateTime.now().subtract(Duration(hours: 9)), 42),
  //       SensorData(DateTime.now().subtract(Duration(hours: 10)), 83),
  //       SensorData(DateTime.now().subtract(Duration(hours: 11)), 85),
  //   ];

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

  // @override
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _dataStream.dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _jsonData = snapshot.data!;
          //print('snapshot : $_jsonData');
          String frequency = _jsonData['Frequency'].toString();
          String steamFlow = _jsonData['SteamFlow'].toString();
          String steamPreasure = _jsonData['SteamPressure'].toString();
          String waterLevel = _jsonData['WaterLevel'].toString();
          String dateTime = _jsonData['Date'].toString();

          List<String> listFrequency = frequency.split(',').skip(1).toList();
          List<String> listSteamFlow = steamFlow.split(',').skip(1).toList();
          List<String> listSteamPreasure =
              steamPreasure.split(',').skip(1).toList();
          List<String> listWaterLevel = waterLevel.split(',').skip(1).toList();
          List<String> listDateTime = dateTime.split(',').skip(1).toList();
          print('list ori $listDateTime');
          List<DateTime> datetime = [];

          for (var _date in listDateTime) {
            String replacedString = _date.replaceAll("#", " ");
            print('replace $replacedString');

            List<String> parts = replacedString.split(' ');
            String dateString = parts[0]; // "2023-10-20"
            String timeString = parts[1]; // "1.12.55"

            // Split the time component into hours, minutes, and seconds
            List<String> timeParts = timeString.split('.');
            int hours = int.parse(timeParts[0]);
            int minutes = int.parse(timeParts[1]);
            int seconds = int.parse(timeParts[2]);

            // Parse the date component
            DateTime date = DateTime.parse(dateString);

            datetime.add(DateTime(
                date.year, date.month, date.day, hours, minutes, seconds));
          }

          List<double> doubleListFrequency =
              listFrequency.map((value) => double.parse(value)).toList();
          List<double> doubleListSteamFlow =
              listSteamFlow.map((value) => double.parse(value)).toList();
          List<double> doubleListSteamPreasure =
              listSteamPreasure.map((value) => double.parse(value)).toList();
          List<double> doubleListWaterLevel =
              listWaterLevel.map((value) => double.parse(value)).toList();

          List<SensorData> steamPressureSensor = [];
          List<SensorData> steamFlowSensor = [];
          List<SensorData> turbineSensor = [];
          List<SensorData> waterSensor = [];

          for (var i = 0; i < datetime.length; i++) {
            steamPressureSensor
                .add(SensorData(datetime[i], doubleListSteamPreasure[i]));

            steamFlowSensor
                .add(SensorData(datetime[i], doubleListSteamFlow[i]));

            turbineSensor.add(SensorData(datetime[i], doubleListFrequency[i]));

            waterSensor.add(SensorData(datetime[i], doubleListWaterLevel[i]));
          }

          return SingleChildScrollView(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  //dispose();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => logScreen(
                      data: steamFlowSensor,
                      title: 'Steam Flow',
                      unit: 'TH',
                      threshold: 40,
                    ),
                  ));
                },
                child: cardAnalytic(
                  title1: 'Steam',
                  lottiePath: 'lib/assets/image/flow.png',
                  listData: steamFlowSensor,
                  height: 80,
                  width: 80,
                  title2: 'Flow',
                ),
              ),
              InkWell(
                onTap: () {
                  //dispose();
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => logScreen(
                      data: steamPressureSensor,
                      title: 'Steam Pressure',
                      unit: 'TH',
                      threshold: 40,
                    ),
                  ));
                },
                child: cardAnalytic(
                  title1: 'Steam',
                  lottiePath: 'lib/assets/image/pressure.png',
                  listData: steamPressureSensor,
                  height: 75,
                  width: 75,
                  title2: 'Pressure',
                ),
              ),

              InkWell(
                onTap: () {
                   //dispose();
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => logScreen(
                      data: turbineSensor,
                      title: 'Turbine Frequency',
                      unit: 'Hz',
                      threshold: 40,
                    ),
                  ));
                },
                child: cardAnalytic(
                  title1: 'Turbine',
                  lottiePath: 'lib/assets/image/turbine.png',
                  listData: turbineSensor,
                  height: 60,
                  width: 60,
                  title2: 'Frequency',
                ),
              ),


              InkWell(
                   onTap: () {
                   //dispose();
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => logScreen(
                      data: waterSensor,
                      title: 'Water Level',
                      unit: 'Hz',
                      threshold: 40,
                    ),
                  ));
                },
                child: cardAnalytic(
                  title1: 'Water',
                  lottiePath: 'lib/assets/image/water-level.png',
                  listData: waterSensor,
                  height: 60,
                  width: 60,
                  title2: 'Level',
                ),
              ),
            ],
          ));
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
