import 'package:delicia/pages/editFruit.dart';
import 'package:delicia/pages/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class FruitDetails extends StatefulWidget {
  final name;
  final season;
  final des;
  final price;
  final image;
  final keys;

  FruitDetails(
      {this.des, this.name, this.price, this.season, this.image, this.keys});
  @override
  _FruitDetailsState createState() => _FruitDetailsState();
}

class _FruitDetailsState extends State<FruitDetails> {
  DatabaseReference _ref;
  String seasonref;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.orange, Colors.yellow],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    if (widget.season == "Summer") {
      seasonref = "summerFruit";
    }

    if (widget.season == "Winter") {
      seasonref = "winterFruit";
    }

    if (widget.season == "Spring") {
      seasonref = "springFruit";
    }

    if (widget.season == "Fall") {
      seasonref = "fallFruit";
    }

    _ref = FirebaseDatabase.instance.reference().child('Fruits');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.name,
          style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "${widget.name} Purchased");
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.purple, Colors.blue])),
                margin: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  "Buy Now",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.purple,
            onPressed: () {
              updateFruit(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red[700],
            onPressed: () {
              deleteFruit(context);
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.purple, Colors.blue]),
              ),
              padding: const EdgeInsets.all(18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10),
              child: Text(
                "Name: ${widget.name}",
                style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10),
              child: Text(
                "Price: Rs.${widget.price}",
                style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10),
              child: Text(
                "Season: ${widget.season}",
                style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10),
              child: Text(
                "Description: \n${widget.des}",
                style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteFruit(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Delete Fruit"),
      content: Text("Would you like to delete this fruit"),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {},
          child: Text("Cancel"),
        ),

        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            deleteFruitCom();
          },
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red[700]),
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void updateFruit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditFruit(
              name: widget.name,
              keys: widget.keys,
              price: widget.price,
              des: widget.des,
              image: widget.image,
              season: widget.season,
            )));
  }

  void deleteFruitCom() {
    _ref.child(seasonref).child(widget.keys).remove().whenComplete(() {
      Navigator.pop(context);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }
}
