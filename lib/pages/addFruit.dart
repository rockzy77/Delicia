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

class AddFruit extends StatefulWidget {
  @override
  _AddFruitState createState() => _AddFruitState();
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

class _AddFruitState extends State<AddFruit> {
  DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('Fruits');
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

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_seasons);
    _selectedSeason = _dropdownMenuItems[0].value;
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
                  "Add Fruit",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      saveAnduploadProduct();
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
                      //Upload Image Box
                      InkWell(
                        onTap: () {
                          _showImageDialogueBox(context);
                        },
                        child: Container(
                            height: 200,
                            margin:
                                EdgeInsets.only(left: 65, right: 65, top: 25),
                            padding: EdgeInsets.all(35),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: _image == null
                                ? Center(
                                    child: Text(
                                    "Upload Image",
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ))
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  )),
                      ),

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

  //function to select image picking type
  void _showImageDialogueBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            title: Text("Choose Source"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  title: Text("Take A Photo"),
                  onTap: () {
                    _takeImage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Choose From Gallery"),
                  onTap: () {
                    _chooseImage();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  //function to take image from camera
  void _takeImage() async {
    try {
      final pickedImage = await picker.getImage(source: ImageSource.camera);
      if (pickedImage != null) {
        final cropped = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 300,
          maxWidth: 300,
          compressFormat: ImageCompressFormat.jpg,
          cropStyle: CropStyle.rectangle,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.orange,
            toolbarTitle: "Delicia Cropper",
            statusBarColor: Colors.deepOrange,
            backgroundColor: Colors.white,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        );

        if (cropped != null) {
          setState(() {
            _image = File(cropped.path);
          });
        } else {
          Fluttertoast.showToast(msg: "Image Not Cropped");
        }
      } else {
        Fluttertoast.showToast(msg: "No Image Selected!");
      }
    } on Exception catch (err) {
      Fluttertoast.showToast(msg: "$err");
    }
  }

  //function to choose image from gallery
  void _chooseImage() async {
    try {
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final cropped = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 300,
          maxWidth: 300,
          compressFormat: ImageCompressFormat.jpg,
          cropStyle: CropStyle.rectangle,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.orange,
            toolbarTitle: "Delicia Cropper",
            statusBarColor: Colors.deepOrange,
            backgroundColor: Colors.white,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        );

        if (cropped != null) {
          setState(() {
            _image = File(cropped.path);
          });
        } else {
          Fluttertoast.showToast(msg: "Image Not Cropped");
        }
      } else {
        Fluttertoast.showToast(msg: "No Image Selected!");
      }
    } on Exception catch (err) {
      Fluttertoast.showToast(msg: "$err");
    }
  }

  //function to validate and save the fruit to databse
  void saveAnduploadProduct() async {
    if (_formKey.currentState.validate()) {
      if (_image != null) {
        String imageUrl;
        String name = namecontroller.text;
        String season = _selectedSeason.season;
        String des = descontroller.text;
        double price = double.parse(pricecontroller.text);
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture =
            '$name${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        if (_selectedSeason.season == "Summer") {
          setState(() {
            loading = true;
          });
          UploadTask task = storage
              .ref()
              .child('summerFruits')
              .child(picture)
              .putFile(_image);

          TaskSnapshot snapshot = await task;
          imageUrl = await snapshot.ref.getDownloadURL();

          Map<String, dynamic> fruit = {
            'name': name,
            'season': season,
            'description': des,
            'price': price,
            'image': imageUrl,
          };

          _ref.child("summerFruit").push().set(fruit).then((value) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
            Fluttertoast.showToast(msg: "Fruit Added");
          });
        }

        if (_selectedSeason.season == "Winter") {
          setState(() {
            loading = true;
          });
          UploadTask task = storage
              .ref()
              .child('winterFruits')
              .child(picture)
              .putFile(_image);

          TaskSnapshot snapshot = await task;
          imageUrl = await snapshot.ref.getDownloadURL();

          Map<String, dynamic> fruit = {
            'name': name,
            'season': season,
            'description': des,
            'price': price,
            'image': imageUrl,
          };

          _ref.child("winterFruit").push().set(fruit).then((value) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
            Fluttertoast.showToast(msg: "Fruit Added");
          });
        }

        if (_selectedSeason.season == "Spring") {
          setState(() {
            loading = true;
          });
          UploadTask task = storage
              .ref()
              .child('springFruits')
              .child(picture)
              .putFile(_image);

          TaskSnapshot snapshot = await task;
          imageUrl = await snapshot.ref.getDownloadURL();

          Map<String, dynamic> fruit = {
            'name': name,
            'season': season,
            'description': des,
            'price': price,
            'image': imageUrl,
          };

          _ref.child("springFruit").push().set(fruit).then((value) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
            Fluttertoast.showToast(msg: "Fruit Added");
          });
        }

        if (_selectedSeason.season == "Fall") {
          setState(() {
            loading = true;
          });
          UploadTask task =
              storage.ref().child('fallFruits').child(picture).putFile(_image);

          TaskSnapshot snapshot = await task;
          imageUrl = await snapshot.ref.getDownloadURL();

          Map<String, dynamic> fruit = {
            'name': name,
            'season': season,
            'description': des,
            'price': price,
            'image': imageUrl,
          };

          _ref.child("fallFruit").push().set(fruit).then((value) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
            Fluttertoast.showToast(msg: "Fruit Added");
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Image Cannot Be Empty!");
      }
    }
  }
}
