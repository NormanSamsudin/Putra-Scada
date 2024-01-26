import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:putra_scada/screen/analyticsScreen.dart';
import 'package:putra_scada/screen/dashboardScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:putra_scada/rubbish/thresholdScreen.dart';
import 'package:putra_scada/screen/thresholdScreenV2.dart';
import 'package:putra_scada/screen/welcomeScreen.dart';
import 'package:putra_scada/widget/dashboard.dart';
import 'firebase_options.dart';
import 'package:flutter_vlc_player/src/flutter_vlc_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcm = FirebaseMessaging.instance;

  await fcm.requestPermission();

  final token = await fcm.getToken();
  print('token $token');
  setupPushNotification(token!);

  runApp(MyAppMain());
}

void setupPushNotification(String token) async {
  final url = Uri.https(
      'putra-scada-default-rtdb.asia-southeast1.firebasedatabase.app',
      'SmartPhone.json');

  final response = await http.put(url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'Token': token,
      }));

  print('response body : $response.body');
  print(response.statusCode);
}


class MyAppMain extends StatelessWidget {
  MyAppMain({super.key});

  static const appTitle = 'Drawer Demo';

  /////////////////
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    //super.initState();

    // Register the background message handler.
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    _configureFirebaseMessaging();
  }

  // Code ni broken lagi
  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final data = message.data;

      final title = notification?.title ?? "Default Title";
      final body = notification?.body ?? "Default Body";

      print("Received message - Title: $title, Body: $body");

      // Display the notification using fluttertoast.
    });
  }

  Future<void> _backgroundHandler(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    final title = notification?.title ?? "Default Title";
    final body = notification?.body ?? "Default Body";

    print("Handling a background message - Title: $title, Body: $body");

    // Handle the background message here.
  }

  ////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.orange,
          iconColor: Colors.black,
          prefixIconColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //elevation: 0,
            primary: Colors.orange,
            shape: const StadiumBorder(),
            //maximumSize: const Size(double.infinity, 56),
            //minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ),
      home: IntroPage(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOption = <Widget>[
    dashboardScreen(),
    thresholdScreenV2(),
    analyticScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Putra SCADA",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange),
                child: Column(
                  children: [
                    // const Text(
                    //   'Putra SCADA',
                    //   style: TextStyle(color: Colors.white),
                    // ),

                    Container(
                        height: 133,
                        width: 200,
                        child: Image.asset('lib/assets/logoPutraScada2.png')),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Dashboard'),
                leading: const Icon(Icons.home),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Threshold Setting'),
                leading: Icon(Icons.settings),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Analytics'),
                leading: Icon(Icons.auto_graph_sharp),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Exit'),
                leading: Icon(Icons.exit_to_app_rounded),
                onTap: () => exit(0),
              )
            ],
          ),
        ),
        body: _widgetOption[_selectedIndex]);
  }
}
