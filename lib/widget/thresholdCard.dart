import 'package:flutter/material.dart';
import 'package:putra_scada/screen/editThreshold.dart';

class thresholdCard extends StatelessWidget {
  thresholdCard(
      {super.key,
      required this.steamFlow,
      required this.steamPressure,
      required this.turbineFrequency,
      required this.waterLevel});

  final String steamPressure;
  final String steamFlow;
  final String waterLevel;
  final String turbineFrequency;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [

        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, top: 30),
              child: const Text(
                'Minimum Threshold',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', // Use your desired font family
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            // Steam Pressure Container
            Expanded(
              child: Container(
                height: 300,
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
                    Image.asset('lib/assets/image/pressure.png',
                        width: 110, height: 110),
                    SizedBox(height: 12),
                    Text(
                      'Steam Pressure',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$steamPressure bar', // Replace with your steam pressure value
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 33,
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
                height: 300,
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
                    Image.asset('lib/assets/image/flow.png',
                        width: 110, height: 110),
                    SizedBox(height: 6),
                    Text(
                      'Steam Flow',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$steamFlow T/H', // Replace with your steam pressure value
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 33,
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
                height: 300,
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
                    Image.asset('lib/assets/image/water-level.png',
                        width: 70, height: 70),
                    SizedBox(height: 16),
                    const Text(
                      'Water Level',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$waterLevel %', // Replace with your steam pressure value
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 33,
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
                height: 300,
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
                    Image.asset('lib/assets/image/turbine.png',
                        width: 70, height: 70),
                    SizedBox(height: 16),
                    Text(
                      'Turbine Frequency',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$turbineFrequency Hz', // Replace with your steam pressure value
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 30,),

        InkWell(
              onTap: () {
                
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => editThreshold(),
                ));
              },
              child: Container(
                height: 50,
                  margin: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange,
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.edit,
                        size: 20,
                      )
                      //Image.asset('lib/assets/image/pencil.png', width: 15, height: 15),
                    ],
                  )),
            )

        
      ],
    );
  }
}
