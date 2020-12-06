import 'package:flutter/material.dart';

import 'success_loading.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: FlatButton(
          color: Colors.cyanAccent,
          textColor: Colors.blueGrey,
          child: Text("Pay"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CheckMarkLoading()));
          },
        ),
      )),
    );
  }
}
