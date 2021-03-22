import 'package:flutter/material.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        child: Container(
            padding: EdgeInsets.only(left: 45, right: 45),
            child: Center(
                child: LinearProgressIndicator(
              backgroundColor: Colors.red,
            ))),
      ),
    );
  }
}
