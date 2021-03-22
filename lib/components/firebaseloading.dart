import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FLoad extends StatefulWidget {
  @override
  _FLoadState createState() => _FLoadState();
}

class _FLoadState extends State<FLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
              Text("Wait While App Is Loading..",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
