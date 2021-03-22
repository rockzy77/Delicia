import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRList extends StatefulWidget {
  final void Function() summer;
  final void Function() winter;
  final void Function() spring;
  final void Function() fall;

  HRList({
    this.fall,
    this.spring,
    this.summer,
    this.winter,
  });
  @override
  _HRListState createState() => _HRListState();
}

class _HRListState extends State<HRList> {
  //Colors for Season Texts
  Color summercolor = Colors.orange;
  Color wintercolor = Colors.black;
  Color springcolor = Colors.black;
  Color fallcolor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      margin: EdgeInsets.only(top: 10, left: 10),
      height: 60,
      //List view to show the season options
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          //Season Options

          //Summer
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
            child: InkWell(
              onTap: () {
                setState(() {
                  wintercolor = Colors.black;
                  summercolor = Colors.orange;
                  springcolor = Colors.black;
                  fallcolor = Colors.black;
                });
                widget.summer();
              },
              child: Text(
                "Summer",
                style: GoogleFonts.poppins(color: summercolor, fontSize: 18),
              ),
            ),
          ),

          //Winter
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
            child: InkWell(
              onTap: () {
                setState(() {
                  wintercolor = Colors.orange;
                  summercolor = Colors.black;
                  springcolor = Colors.black;
                  fallcolor = Colors.black;
                });
                widget.winter();
              },
              child: Text(
                "Winter",
                style: GoogleFonts.poppins(color: wintercolor, fontSize: 18),
              ),
            ),
          ),

          //Spring
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
            child: InkWell(
              onTap: () {
                setState(() {
                  wintercolor = Colors.black;
                  summercolor = Colors.black;
                  springcolor = Colors.orange;
                  fallcolor = Colors.black;
                });
                widget.spring();
              },
              child: Text(
                "Spring",
                style: GoogleFonts.poppins(color: springcolor, fontSize: 18),
              ),
            ),
          ),

          //Fall
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
            child: InkWell(
              onTap: () {
                setState(() {
                  wintercolor = Colors.black;
                  summercolor = Colors.black;
                  springcolor = Colors.black;
                  fallcolor = Colors.orange;
                });
                widget.fall();
              },
              child: Text(
                "Fall",
                style: GoogleFonts.poppins(color: fallcolor, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
