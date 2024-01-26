import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:putra_scada/main.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';


class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyKebun',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroductionScreen(),
    );
  }
}

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int _timerSeconds = 3;
  bool _timerActive = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _timerActive = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
        startTimer();
      } else {
        // Timer has ended, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
                child: Image.asset(
                  "lib/assets/logoPutraScada.png",
                  height: 350,
                  width: 400,
                )),
            Text(
              "Engineering's Steam Turbine",
               style: 
               GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none
                )
            ),
            Text(
               "Monitoring Solution!",
               style: 
               GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none
                )
            ),
            SizedBox(height: 20,),
            Container(
              height: 250,
              width: 250,
              child: Lottie.asset('lib/assets/lottie/loading.json',)
              ),
            
          ],
        ),
      ),
    );
  }
}
