import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:putra_scada/screen/editThreshold.dart';

class setting extends StatefulWidget {
  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  String? _error;
  double? steamPreasure = 0;
  double? steamFlow = 0;
  double? waterLevel = 0;
  double? turbineFrequency = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadThreshold();
    sleep(Duration(seconds: 5));
  }

  Future<void> _loadThreshold() async {
    final url = Uri.https(
        'putra-scada-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/Threshold.json');

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later';
        });
      }

      print(response.body);

      if (response.body == 'null') {
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      //debug
      print('var 1 : ${listData['steamFlow']}');
      print('var 2 : ${listData['steamPressure']}');
      print('var 3 : ${listData['turbineFrequency']}');
      print('var 4 : ${listData['waterLevel']}');
      print('LISTDATA $listData');

      //assign to variable
      steamFlow = listData['steamFlow'];
      steamPreasure = listData['steamPressure'];
      turbineFrequency = listData['turbineFrequency'];
      waterLevel = listData['waterLevel'];
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Threshold Seting',
                style: GoogleFonts.lexend(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 250, 202, 58)),
              //color: Color.fromARGB(255, 235, 230, 213),
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                      top: 30,
                      left: 30,
                      child: Row(
                        children: [
                          Text(
                            'Minimum Threshold ',
                            style: GoogleFonts.lexend(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.info),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )),
                  Positioned(
                      top: 80,
                      left: 40,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Steam Preasure',
                              style: GoogleFonts.lexend(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              '${steamPreasure!.toStringAsFixed(2)}    bar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          )
                        ],
                      )),
                  Positioned(
                      top: 170,
                      left: 40,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Steam Flow',
                              style: GoogleFonts.lexend(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              '${steamFlow!.toStringAsFixed(2)}    T/H',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          )
                        ],
                      )),
                  Positioned(
                      top: 260,
                      left: 40,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Water Level',
                              style: GoogleFonts.lexend(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              '${waterLevel!.toStringAsFixed(2)}    %',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          )
                        ],
                      )),
                  Positioned(
                      top: 350,
                      left: 40,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Turbine Frequency',
                              style: GoogleFonts.lexend(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              '${turbineFrequency!.toStringAsFixed(2)}    Hz',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editThreshold(),
                      ));
                    },
                    child: const Text('Edit'),
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
