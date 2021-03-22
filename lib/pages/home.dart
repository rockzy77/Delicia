import 'package:delicia/components/fruits.dart';
import 'package:delicia/components/fruitslist.dart';
import 'package:delicia/components/hrlist.dart';
import 'package:delicia/components/searchBar.dart';
import 'package:delicia/pages/addFruit.dart';
import 'package:delicia/pages/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String season = "Summer";
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.orange, Colors.yellow],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,

        //AppBar
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Delicia",
            style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = linearGradient),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.orange,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddFruit()));
              },
            ),
          ],
        ),

        //End AppBar
        body: Container(
          child: ListView(
            children: [
              //Header
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.purple, Colors.blue])),
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Delicious Fruits For Your Favourable Season",
                    style: GoogleFonts.poppins(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),

              // InkWell(
              //     child: SearchBar(),
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => SearchQueryPage()));
              //     }),

              //Horizontal List to Select the Favourable Season
              HRList(
                //Function to Call
                winter: () {
                  setState(() {
                    season = "Winter";
                  });
                },
                spring: () {
                  setState(() {
                    season = "Spring";
                  });
                },
                fall: () {
                  setState(() {
                    season = "Fall";
                  });
                },
                summer: () {
                  setState(() {
                    season = "Summer";
                  });
                },
              ),

              season == "Summer"
                  ? SummerFruitsList()
                  : season == "Winter"
                      ? WinterFruitsList()
                      : season == "Spring"
                          ? SpringFruitsList()
                          : FallFruitsList(),
            ],
          ),
        ),
      ),
    );
  }
}
