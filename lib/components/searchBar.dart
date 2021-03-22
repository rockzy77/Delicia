import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
      height: 45,
      padding: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "Search For Fruit",
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ),
    );
  }
}
