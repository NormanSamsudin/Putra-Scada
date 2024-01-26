import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putra_scada/model/sensor.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class cardAnalytic extends StatelessWidget {
  cardAnalytic(
      {super.key,
      required this.title1,
       required this.title2,
      required this.lottiePath,
      required this.listData,
      required this.height,
      required this.width
      });

  final String title1;
  final String title2;
  final String lottiePath;
  final List<SensorData> listData;
  final double height;
  final double width;

  final List<SensorData> chartData = [
    SensorData(DateTime.now().subtract(Duration(hours: 1)), 35),
    SensorData(DateTime.now().subtract(Duration(hours: 2)), 28),
    SensorData(DateTime.now().subtract(Duration(hours: 3)), 34),
    SensorData(DateTime.now().subtract(Duration(hours: 4)), 32),
    SensorData(DateTime.now().subtract(Duration(hours: 5)), 40),
    SensorData(DateTime.now().subtract(Duration(hours: 6)), 44),
    SensorData(DateTime.now().subtract(Duration(hours: 7)), 58),
    SensorData(DateTime.now().subtract(Duration(hours: 8)), 75),
    SensorData(DateTime.now().subtract(Duration(hours: 9)), 42),
    SensorData(DateTime.now().subtract(Duration(hours: 10)), 83),
    SensorData(DateTime.now().subtract(Duration(hours: 11)), 85),
    SensorData(DateTime.now().subtract(Duration(hours: 12)), 50),
    SensorData(DateTime.now().subtract(Duration(hours: 13)), 40),
    SensorData(DateTime.now().subtract(Duration(hours: 14)), 10),
  ];

  @override
  Widget build(BuildContext context) {
    for (var data in listData) {
      print(data.sales);
      print(data.year);
      print('ppppp');
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
      child: Container(
        height: 190,
        width: double.infinity,
        //color: Colors.orange,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.orange),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
                top: 20,
                left: 80,
                child: Text(
                  title1,
                  style: GoogleFonts.lexend(
                      fontSize: 20, fontWeight: FontWeight.w400),
                )),
              Positioned(
                top: 45,
                left: 80,
                child: Text(
                  title2,
                  style: GoogleFonts.lexend(
                      fontSize: 20, fontWeight: FontWeight.w400),
                )),
            Positioned(
                top: 10,
                left: 10,
                child: Container(
                    height: height,
                    width: width,
                    child: Image.asset(
                      lottiePath,
                      color: Colors.white,
                    ))),
            Positioned(
              top: 25,
              right: 20,
              child: Container(
                width: 180,
                child: SfLinearGauge(
                  markerPointers: [
                    LinearShapePointer(
                      value: double.parse(
                          listData[listData.length - 1].sales.toString()),
                      markerAlignment: LinearMarkerAlignment.start,
                      color: Colors.purple,
                    )
                  ],
                  labelFormatterCallback: (value) {
                    if (value == '0') {
                      return 'Min';
                    }
                    if (value == '100') {
                      return 'Max';
                    }
                    if (value != '0' || value != '100') {
                      return '';
                    }
                    return value;
                  },
                  showTicks: false,
                  //showLabels: false,
                  minimum: 0,
                  maximum: 100,
                  axisTrackStyle: const LinearAxisTrackStyle(
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      thickness: 15,
                      color: Color.fromARGB(178, 255, 255, 255)
                      // gradient: LinearGradient(
                      //     colors: [Colors.purple, Colors.blue],
                      //     begin: Alignment.centerLeft,
                      //     end: Alignment.centerRight,
                      //     tileMode: TileMode.clamp),
                      ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 35,
              child: Container(
                height: 110,
                width: 350,
                child: SfCartesianChart(
                    borderColor: const Color.fromARGB(0, 255, 255, 255),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: DateTimeAxis(
                      axisLine: const AxisLine(width: 0, color: Colors.white),
                      majorGridLines:
                          MajorGridLines(width: 0, color: Colors.white),
                      borderWidth: 0,
                      borderColor: Colors.white,
                      isVisible: true,
                      //minimum: DateTime(1970),
                      //maximum: DateTime.now(),
                    ),
                    primaryYAxis: NumericAxis(
                        borderWidth: 0,
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 0),
                        borderColor: Colors.white,
                        isVisible: false),
                    //title: ChartTitle(text: 'Heart Rate Reading'),
                    series: <ChartSeries>[
                      // Renders line chart
                      AreaSeries<SensorData, DateTime>(
                        color: Colors.white,
                        //width: 2,
                        //opacity: 0.6,
                        dataSource: listData,
                        xValueMapper: (SensorData sales, _) => sales.year,
                        yValueMapper: (SensorData sales, _) => sales.sales,
                        //gradient: gradientColors,
                        isVisibleInLegend: true,
                        isVisible: true,
                        xAxisName: 'Time',
                        yAxisName: 'Heart Rate',
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
