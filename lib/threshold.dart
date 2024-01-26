import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Putra SCADA"),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, top: 16),
                  child: Text(
                    'Minimum Threshold',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', // Use your desired font family
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(80, 40, 0, 0),
                    padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.edit, size: 20,)
                      //Image.asset('lib/assets/image/pencil.png', width: 15, height: 15),

                    ],

                  )
                )
              ],
            ),


            Row(
              children: [

                // Steam Pressure Container
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 16, 16, 16),
                    padding: EdgeInsets.all(16),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('lib/assets/image/pressure.png', width: 64, height: 64),
                        SizedBox(height: 12),
                        Text(
                          'Steam Pressure',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '35 bar', // Replace with your steam pressure value
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Steam Flow Container
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 25, 16),
                    padding: EdgeInsets.all(16),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('lib/assets/image/flow.png', width: 70, height: 70),
                        SizedBox(height: 6),
                        Text(
                          'Steam Flow',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '22 T/H', // Replace with your steam pressure value
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: [

                // Water Level Container
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 16, 16, 16),
                    padding: EdgeInsets.all(16),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('lib/assets/image/water-level.png', width: 58, height: 58),
                        SizedBox(height: 16),
                        Text(
                          'Water Level',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '30 %', // Replace with your steam pressure value
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Turbine Frequency Container
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 25, 16),
                    padding: EdgeInsets.all(16),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('lib/assets/image/turbine.png', width: 58, height: 58),
                        SizedBox(height: 16),
                        Text(
                          'Turbine Frequency',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '43 Hz', // Replace with your steam pressure value
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
