import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class miniGauges extends StatelessWidget {
  miniGauges({super.key, required this.type, required this.value});

  final String type;
  final double value;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SfRadialGauge(
        title: GaugeTitle(
          text: type,
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        axes: <RadialAxis>[
          RadialAxis(
              axisLineStyle: AxisLineStyle(thickness: 10, color: Colors.orange),
              showTicks: false,
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: value,
                  enableDragging: true,
                  markerWidth: 10,
                  markerHeight: 10,
                  markerOffset: -10,
                  color: Colors.indigo,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    axisValue: 50,
                    positionFactor: 0.4,
                    horizontalAlignment: GaugeAlignment.far,
                    widget: Text(
                      value.toStringAsFixed(2),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
              ],
              minimum: 0,
              maximum: 41,
              labelsPosition: ElementsPosition.inside,
              showLabels: true,
              showFirstLabel: true,
              showLastLabel: false,
              startAngle: 180,
              endAngle: 0,
              interval: 20,
              canScaleToFit: true)
        ]);
  }
}
