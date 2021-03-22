import 'dart:io';

import 'package:delicia/components/loading.dart';
import 'package:delicia/pages/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditFruit extends StatefulWidget {
  final name;
  final price;
  String keys;
  final image;
  final des;
  final season;

  EditFruit(
      {this.des, this.image, this.keys, this.name, this.price, this.season});
  @override
  _EditFruitState createState() => _EditFruitState();
}

class Season {
  int id;
  String season;

  Season({this.id, this.season});

  static List<Season> getSeason() {
    return <Season>[
      Season(id: 1, season: "Summer"),
      Season(id: 2, season: "Winter"),
      Season(id: 3, season: "Spring"),
      Season(id: 4, season: "Fall"),
    ];
  }
}

class _EditFruitState extends State<EditFruit> {
  DatabaseReference _ref;
  List<Season> _seasons = Season.getSeason();
  List<DropdownMenuItem<Season>> _dropdownMenuItems;
  File _image;
  final picker = ImagePicker();
  Season _selectedSeason;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool loading = false;
  List<Data> dataList;
  String seasonref;
  String seasonrefstorage;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_seasons);
    print(widget.season);
    if (widget.season == "Summer") {
      seasonref = "summerFruit";
      _selectedSeason = _dropdownMenuItems[0].value;
    }
    if (widget.season == "Winter") {
      seasonref = "winterFruit";
      _selectedSeason = _dropdownMenuItems[1].value;
    }
    if (widget.season == "Spring") {
      seasonref = "springFruit";
      _selectedSeason = _dropdownMenuItems[2].value;
    }
    if (widget.season == "Fall") {
      seasonref = "fallFruit";
      _selectedSeason = _dropdownMenuItems[3].value;
    }

    _ref = FirebaseDatabase.instance.reference().child('Fruits');

    getFruitData();
    super.initState();
  }

//DropDownMenuItems
  List<DropdownMenuItem<Season>> buildDropDownMenuItems(List seasons) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<Season>> items = List();
    for (Season season in seasons) {
      items.add(DropdownMenuItem(
        value: season,
        child: Text(season.season),
      ));
    }
    return items;
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.orange, Colors.yellow],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  onChangeDropDownItem(Season selectedSeason) {
    setState(() {
      _selectedSeason = selectedSeason;
    });
  }
//End DropDownMenuItems

  @override
  Widget build(BuildContext context) {
    return loading
        ? Load()
        : MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              //AppBar
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Edit Fruit",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      submitForm();
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
              body: Container(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      //Add Name Input Box
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          "Fruit Name",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: namecontroller,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Name Cannot Be Empty";
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Eg: Apple",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),

                      //Select Season Drop Down Menu
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          "Select Season",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          value: _selectedSeason,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropDownItem,
                        ),
                      ),

                      //Add Description Box
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          "Fruit Description",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: descontroller,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Description Cannot Be Empty";
                            }
                            if (value.length < 20) {
                              return "Description cannot be less than 20 words";
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Eg: Healthy Fruit",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),

                      //Add Price Box
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          "Fruit Price/Kg",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: pricecontroller,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Price Cannot Be Empty";
                            }

                            if (double.parse(value) < 10) {
                              return "Price must be grater than 10rs/Kg";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Eg: 100",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  //function to edit fruit

  void submitForm() async {
    String name = namecontroller.text;
    String season = _selectedSeason.season;
    double price = double.parse(pricecontroller.text);
    String des = descontroller.text;
    String postSeason = widget.season;

    setState(() {
      loading = true;
    });

    if (postSeason != season) {
      _ref.child(seasonref).child(widget.keys).remove().whenComplete(() =>
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home())));

      if (season == "Summer") {
        seasonref = "summerFruit";
      }
      if (season == "Winter") {
        seasonref = "winterFruit";
      }
      if (season == "Spring") {
        seasonref = "springFruit";
      }
      if (season == "Fall") {
        seasonref = "fallFruit";
      }

      Map<String, dynamic> fruit = {
        'name': name,
        'season': season,
        'description': des,
        'price': price,
        'image': widget.image,
      };

      _ref.child(seasonref).push().set(fruit).then((value) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: "Fruit Edited");
      });
    } else {
      if (season == "Summer") {
        seasonref = "summerFruit";
      }
      if (season == "Winter") {
        seasonref = "winterFruit";
      }
      if (season == "Spring") {
        seasonref = "springFruit";
      }
      if (season == "Fall") {
        seasonref = "fallFruit";
      }

      Map<String, dynamic> fruit = {
        'name': name,
        'season': season,
        'description': des,
        'price': price,
        'image': widget.image,
      };

      _ref.child(seasonref).child(widget.keys).update(fruit).then((value) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: "Fruit Edited");
      });
    }
  }

  getFruitData() async {
    namecontroller.text = widget.name;
    pricecontroller.text = widget.price.toString();
    descontroller.text = widget.des;
  }
}

class Data {
  String imgUrl, name, des, season, key;
  int price;

  Data({this.des, this.imgUrl, this.name, this.price, this.season, this.key});
}
