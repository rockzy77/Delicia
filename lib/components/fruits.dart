import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Summer Fruits
class SummerFruits extends StatefulWidget {
  @override
  _SummerFruitsState createState() => _SummerFruitsState();
}

class _SummerFruitsState extends State<SummerFruits> {
  Query _ref = FirebaseDatabase.instance
      .reference()
      .child("Fruits")
      .child('summerFruit')
      .orderByChild('name');

  Widget _buildFruitItem({Map fruit}) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue]),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: fruit['image'].toString().isEmpty
                  ? Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Image(
                      width: 300,
                      image: NetworkImage(fruit['image']),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fruit['name'] == ""
                        ? "Loading.."
                        : "Name: " + fruit['name'],
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fruit['price'] == ""
                        ? "Loading.."
                        : "Price: Rs.${fruit['price'].toString()}/Kg",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int fruitlength;
    double height = 450.0 * 4;
    return Container(
      height: height,
      child: FirebaseAnimatedList(
        physics: NeverScrollableScrollPhysics(),
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map fruit = snapshot.value;
          fruitlength = index + 1;
          print("summer " + fruitlength.toString());
          return _buildFruitItem(fruit: fruit);
        },
      ),
    );
  }
}

//Winter Fruits
class WinterFruits extends StatefulWidget {
  @override
  _WinterFruitsState createState() => _WinterFruitsState();
}

class _WinterFruitsState extends State<WinterFruits> {
  Query _ref = FirebaseDatabase.instance
      .reference()
      .child("Fruits")
      .child('winterFruit')
      .orderByChild('name');

  Widget _buildFruitItem({Map fruit}) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue]),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: fruit['image'].toString().isEmpty
                  ? Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Image(
                      width: 300,
                      image: NetworkImage(fruit['image']),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fruit['name'] == ""
                        ? "Loading.."
                        : "Name: " + fruit['name'],
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fruit['price'] == ""
                        ? "Loading.."
                        : "Price: Rs.${fruit['price'].toString()}/Kg",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int fruitlength;
    double height = 450.0 * 3;
    return Container(
      height: height,
      child: FirebaseAnimatedList(
        physics: NeverScrollableScrollPhysics(),
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map fruit = snapshot.value;
          fruitlength = index;
          print(fruitlength.toString());
          return _buildFruitItem(fruit: fruit);
        },
      ),
    );
  }
}

//Spring Fruits
class SpringFruits extends StatefulWidget {
  @override
  _SpringFruitsState createState() => _SpringFruitsState();
}

class _SpringFruitsState extends State<SpringFruits> {
  Query _ref = FirebaseDatabase.instance
      .reference()
      .child("Fruits")
      .child('springFruit')
      .orderByChild('name');

  Widget _buildFruitItem({Map fruit}) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue]),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: fruit['image'].toString().isEmpty
                  ? Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Image(
                      width: 300,
                      image: NetworkImage(fruit['image']),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fruit['name'] == ""
                        ? "Loading.."
                        : "Name: " + fruit['name'],
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    fruit['price'] == ""
                        ? "Loading.."
                        : "Price: Rs.${fruit['price'].toString()}/Kg",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = 500.0 * 2;
    return Container(
      height: height,
      child: FirebaseAnimatedList(
        physics: NeverScrollableScrollPhysics(),
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map fruit = snapshot.value;
          return _buildFruitItem(fruit: fruit);
        },
      ),
    );
  }
}

//Fall Fruits
class FallFruits extends StatefulWidget {
  @override
  _FallFruitsState createState() => _FallFruitsState();
}

class _FallFruitsState extends State<FallFruits> {
  Query _ref = FirebaseDatabase.instance
      .reference()
      .child("Fruits")
      .child('fallFruit')
      .orderByChild('name');
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return null;
        },
      ),
    );
  }
}
