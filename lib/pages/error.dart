import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Errors extends StatefulWidget {
  @override
  _ErrorsState createState() => _ErrorsState();
}

class _ErrorsState extends State<Errors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/dog.png"),
              ),
              Text(
                "Something Error Happened",
                style: GoogleFonts.poppins(color: Colors.red, fontSize: 24),
              ),
              Text(
                "Try again after checking your network",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
