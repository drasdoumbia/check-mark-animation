import 'package:checkmark_anime/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Home Page"),
            ),
            Center(
              child: FlatButton(
                color: Colors.cyanAccent,
                textColor: Colors.blueGrey,
                child: Text("Go Back"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
