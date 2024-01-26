import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putra_scada/model/pieChart.dart';
import 'package:putra_scada/model/sensor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class logScreen extends StatelessWidget {
  logScreen(
      {super.key,
      required this.data,
      required this.title,
      required this.unit,
      required this.threshold});
  final List<SensorData> data;
  final String title;
  final String unit;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    int normal = 0;
    int exceed = 0;

    for (int i = 0; i < data.length; i++) {
      if (data[i].sales < threshold) {
        exceed++;
      } else {
        normal++;
      }
    }

    List<ChartData> chartData = <ChartData>[
    ChartData(
        x: 'Normal', y: normal, color: const Color.fromARGB(255, 117, 230, 121)),
    ChartData(
        x: 'Below Threshold', y: exceed, color: Color.fromARGB(255, 235, 60, 47)),
    ];


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Putra SCADA",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: Text(
                  'Percentage History',
                  style: GoogleFonts.lexend(
                      fontSize: 30, fontWeight: FontWeight.w600),
                )),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true, // Show the legend
                    toggleSeriesVisibility: true,
                  ),
                  series: <CircularSeries<ChartData, String>>[
                    PieSeries<ChartData, String>(
                      dataSource: chartData,

                      xValueMapper: (ChartData data, _) => data.x,

                      yValueMapper: (ChartData data, _) => data.y,

                      dataLabelMapper: (ChartData data, _) => data.x,

                      radius: '60%',

                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,

                        // Avoid labels intersection

                        labelIntersectAction: LabelIntersectAction.shift,

                        labelPosition: ChartDataLabelPosition.outside,

                        connectorLineSettings: ConnectorLineSettings(
                          type: ConnectorType.curve,
                          length: '25%',
                        ),
                      ),

                      pointColorMapper: (ChartData data, _) =>
                          data.color, // Set custom colors
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: Text(
                  '$title History',
                  style: GoogleFonts.lexend(
                      fontSize: 30, fontWeight: FontWeight.w600),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: DataTable(
                    columns: [
                      //DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Date and Time')),
                      DataColumn(label: Text('Value $unit')),
                    ],
                    rows: data.map((SensorData sensor) {
                      //value
                      Color rowColor = (sensor.sales < threshold)
                          ? Color.fromARGB(120, 248, 109, 99)
                          : Colors.white;
                      return DataRow(
                        color: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08);
                          }
                          return rowColor;
                        }),
                        cells: [
                          //DataCell(Text(sensor.id.toString())),
                          DataCell(Text(sensor.year.toString())),
                          DataCell(
                            Text(sensor.sales.toString()),
                          ),
                        ],
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
