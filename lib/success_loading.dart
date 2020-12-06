import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'home.dart';

class CheckMarkLoading extends StatefulWidget {
  CheckMarkLoading({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CheckMarkLoadingState createState() => _CheckMarkLoadingState();
}

class _CheckMarkLoadingState extends State<CheckMarkLoading> {
  var isLoadingFinished;
  Timer _timer;
  int _start = 02;

  bool get isPlaying => _controller?.isActive ?? false;

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/checkmarkanime.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('anime'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );

    isLoadingFinished =
        new Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: _riveArtboard == null
          ? const SizedBox()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: Rive(artboard: _riveArtboard),
                ),
                SizedBox(height: 25.0),
                Center(
                  child: Text(
                    "Payment made successfully",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
                SizedBox(height: 50.0),
                Center(
                  child: Text(
                    "Redirecting to Home screen in 0:$_start sec",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
              ],
            ),
    );
  }
}
