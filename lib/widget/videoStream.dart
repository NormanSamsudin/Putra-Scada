import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:firebase_database/firebase_database.dart';

class videoStream extends StatefulWidget {
  videoStream({
    super.key,
  });

  @override
  State<videoStream> createState() => _videoStreamState();
}

class _videoStreamState extends State<videoStream> {
  String wifiIPAddress = '';
  VlcPlayerController? _vlcViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('invoke');
    getIpAddressCamera();
    print('end');
  }

  // create reference
  DatabaseReference databases = FirebaseDatabase.instance.ref();

  void getIpAddressCamera() {
    databases.child('Camera/IPAddressCamera/').onValue.listen(
      (event) {
        String temp = event.snapshot.value.toString();
        print('temp ${temp == null}');
        print('temp value ${temp}');
        setState(() {
          wifiIPAddress = temp.toString();
          print('address $wifiIPAddress');
          // Create a new VlcPlayerController with the updated URL.
          _vlcViewController = VlcPlayerController.network(
            wifiIPAddress,
            autoPlay: true,
            // networkCachingDuration: 0,
            // fileCaching: 0,
            // hardwareAcceleration: false,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (_vlcViewController != null)
            VlcPlayer(
              placeholder: Text('Video Stream'),
              controller: _vlcViewController!,
              aspectRatio: 4 / 3,
              
              //placeholder: Text("Hello World"),
            ),
          // VlcPlayer(
          //   controller: _vlcViewController!,
          //   aspectRatio: 4 / 3,
          //   placeholder: const Text("Hello World"),
          // ),
          const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Take picture'),
          // ),
          
        ],
      ),
    );
  }
}
