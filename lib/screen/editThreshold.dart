import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class editThreshold extends StatefulWidget {
  editThreshold({super.key});

  @override
  State<editThreshold> createState() => _editThresholdState();
}

class _editThresholdState extends State<editThreshold> {
  // key untuk
  final _formKey = GlobalKey<FormState>();
  var databaseReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref();
  }

  double? _enterSteamPressure;
  double? _enterSteamFlow;
  double? _enterwaterLevel;
  double? _enterTurbineFreq;

  Future<void> _editThresholdValue() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    print(
        '----------------------------------------------------------------------');
    print(_enterSteamPressure);
    print(_enterSteamFlow);
    print(_enterTurbineFreq);
    print(_enterwaterLevel);
    print(
        '----------------------------------------------------------------------');

    final url = Uri.https(
        'putra-scada-default-rtdb.asia-southeast1.firebasedatabase.app',
        'Threshold.json');
    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'steamFlow': _enterSteamFlow,
          'steamPressure': _enterSteamPressure,
          'turbineFrequency': _enterTurbineFreq,
          'waterLevel': _enterwaterLevel,
        }));

    print(response.body);
    print(response.statusCode); 


    Navigator.of(context).pop();

    // print('Reference ${databaseReference.root}');
    // final nodePath = 'Threshold';

    // Map<String, dynamic> newValue = {
    //   'steamFlow': _enterSteamFlow.toString(),
    //   'steamPressure': _enterSteamPressure.toString(),
    //   'turbineFrequency': _enterTurbineFreq.toString(),
    //   'waterLevel': _enterwaterLevel.toString(),
    // };

    // await databaseReference.child(nodePath).set(newValue).then((value) {
    //   print('Data updated successfully');
    //   Navigator.of(context).pop();
    // }).catchError((error) => print('Failed to update data'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange, Colors.orangeAccent],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height, // screen height
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                'Edit Threshold',
                style: GoogleFonts.lexend(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    )),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              height: 220,
                              width: 220,
                              child: Image.asset('lib/assets/limited.png')),
                          const SizedBox(
                            height: 60,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Row(
                              children: [
                                Text('Steam Pressure',
                                    style: TextStyle(fontSize: 18)),
                                Spacer()
                              ],
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Steam Pressure',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.numbers_sharp,
                                  ),
                                )),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.contains(RegExp(r'[A-Z]'))) {
                                return 'Please enter a valid value';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enterSteamPressure = double.parse(newValue!);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Row(
                              children: [
                                Text('Steam Flow',
                                    style: TextStyle(fontSize: 18)),
                                Spacer()
                              ],
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Steam Flow',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.numbers_sharp,
                                  ),
                                )),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.contains(RegExp(r'[A-Z]'))) {
                                return 'Please enter a valid value';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enterSteamFlow = double.parse(newValue!);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Row(
                              children: [
                                Text('Turbine Frequency',
                                    style: TextStyle(fontSize: 18)),
                                Spacer()
                              ],
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Turbine Frequency',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.numbers_sharp,
                                  ),
                                )),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.contains(RegExp(r'[A-Z]'))) {
                                return 'Please enter a valid value';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enterTurbineFreq = double.parse(newValue!);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Row(
                              children: [
                                Text('Water Level',
                                    style: TextStyle(fontSize: 18)),
                                Spacer()
                              ],
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Water Level',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.numbers_sharp,
                                  ),
                                )),
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.contains(RegExp(r'[A-Z]'))) {
                                return 'Please enter a valid value';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enterwaterLevel = double.parse(newValue!);
                            },
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back_ios),
                                  label: Text('Back')),
                              const SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                  onPressed: () => _editThresholdValue(),
                                  child: Text('Submit'))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )),
                ),
              ),
            ),
          ],
        )),
      ),
    ));
  }
}
