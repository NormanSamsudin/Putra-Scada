import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putra_scada/widget/miniGauges.dart';
import 'package:intl/intl.dart';
import 'package:putra_scada/widget/videoStream.dart';

class dashboard extends StatefulWidget {
  dashboard(
      {super.key,
      required this.steamPreasure,
      required this.steamFlow,
      required this.waterLevel,
      required this.turbineFrequency});

  final double steamPreasure;
  final double steamFlow;
  final double waterLevel;
  final double turbineFrequency;

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(date);

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Video Streaming',
              style:
                  GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.w400)),
        ),
        const SizedBox(
          height: 10,
        ),
        videoStream(),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text('Realtime Data Stream $formattedTime Hour',
              style:
                  GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.w400)),
        ),
                Padding(
          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
          child: Container(
                            decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
            height: 50,
            width: double.infinity,
            child: Center(child: Text('120,456,485  KW')),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 25, 10, 10), // Add margin here
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: 150.0,
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: miniGauges(
                        type: 'Steam Preasure',
                        value: widget.steamPreasure,
                      )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin:
                      EdgeInsets.fromLTRB(10, 25, 25, 10), // Add margin here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 150.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: miniGauges(
                      type: 'Steam Flow',
                      value: widget.steamFlow,
                    ),
                  )),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  margin:
                      EdgeInsets.fromLTRB(25, 10, 10, 25), // Add margin here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 150.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: miniGauges(
                      type: 'Water Level',
                      value: widget.steamFlow,
                    ),
                  )),
            ),
            Expanded(
              child: Container(
                  margin:
                      EdgeInsets.fromLTRB(10, 10, 25, 25), // Add margin here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 150.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: miniGauges(
                      type: 'Turbine Frequency',
                      value: widget.steamFlow,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
