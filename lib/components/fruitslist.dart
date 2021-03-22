import 'package:delicia/pages/fruitDetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Data {
  String imgUrl, name, des, season, key;
  int price;

  Data({this.des, this.imgUrl, this.name, this.price, this.season, this.key});
}

//Summer
class SummerFruitsList extends StatefulWidget {
  @override
  _SummerFruitsListState createState() => _SummerFruitsListState();
}

class _SummerFruitsListState extends State<SummerFruitsList> {
  List<Data> dataList = [];

  @override
  void initState() {
    DatabaseReference _ref = FirebaseDatabase.instance
        .reference()
        .child('Fruits')
        .child('summerFruit');
    _ref.once().then((DataSnapshot snapshot) {
      dataList.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        Data data = new Data(
            name: values[key]['name'],
            des: values[key]['description'],
            price: values[key]['price'],
            season: values[key]['season'],
            imgUrl: values[key]['image'],
            key: key.toString());
        dataList.add(data);
      }

      print(dataList.length);
      setState(() {
        //Set States
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.length == 0) {
      return Container(
        child: Center(
          child: Column(
            children: [
              Image(
                width: 300,
                image: AssetImage("assets/dog.png"),
              ),
              Text("No Fruits Available",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 25)),
            ],
          ),
        ),
      );
    } else {
      double height = 170.0 * dataList.length;
      return Container(
        height: height,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (_, index) {
              return CardUI(
                  dataList[index].name,
                  dataList[index].des,
                  dataList[index].imgUrl,
                  dataList[index].price,
                  dataList[index].season,
                  dataList[index].key,
                  context);
            }),
      );
    }
  }
}

//Winter
class WinterFruitsList extends StatefulWidget {
  @override
  _WinterFruitsListState createState() => _WinterFruitsListState();
}

class _WinterFruitsListState extends State<WinterFruitsList> {
  List<Data> dataList = [];

  @override
  void initState() {
    DatabaseReference _ref = FirebaseDatabase.instance
        .reference()
        .child('Fruits')
        .child('winterFruit');
    _ref.once().then((DataSnapshot snapshot) {
      dataList.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        Data data = new Data(
            name: values[key]['name'],
            des: values[key]['description'],
            price: values[key]['price'],
            season: values[key]['season'],
            imgUrl: values[key]['image'],
            key: key.toString());
        dataList.add(data);
      }

      print(dataList.length);
      setState(() {
        //Set States
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.length == 0) {
      return Container(
        child: Center(
          child: Column(
            children: [
              Image(
                width: 300,
                image: AssetImage("assets/dog.png"),
              ),
              Text("No Fruits Available",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 25)),
            ],
          ),
        ),
      );
    } else {
      double height = 170.0 * dataList.length;
      return Container(
        height: height,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (_, index) {
              return CardUI(
                  dataList[index].name,
                  dataList[index].des,
                  dataList[index].imgUrl,
                  dataList[index].price,
                  dataList[index].season,
                  dataList[index].key,
                  context);
            }),
      );
    }
  }
}

//Spring
class SpringFruitsList extends StatefulWidget {
  @override
  _SpringFruitsListState createState() => _SpringFruitsListState();
}

class _SpringFruitsListState extends State<SpringFruitsList> {
  List<Data> dataList = [];

  @override
  void initState() {
    DatabaseReference _ref = FirebaseDatabase.instance
        .reference()
        .child('Fruits')
        .child('springFruit');
    _ref.once().then((DataSnapshot snapshot) {
      dataList.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        Data data = new Data(
            name: values[key]['name'],
            des: values[key]['description'],
            price: values[key]['price'],
            season: values[key]['season'],
            imgUrl: values[key]['image'],
            key: key.toString());
        dataList.add(data);
      }

      print(dataList.length);
      setState(() {
        //Set States
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.length == 0) {
      return Container(
        child: Center(
          child: Column(
            children: [
              Image(
                width: 300,
                image: AssetImage("assets/dog.png"),
              ),
              Text("No Fruits Available",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 25)),
            ],
          ),
        ),
      );
    } else {
      double height = 170.0 * dataList.length;
      return Container(
        height: height,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (_, index) {
              return CardUI(
                  dataList[index].name,
                  dataList[index].des,
                  dataList[index].imgUrl,
                  dataList[index].price,
                  dataList[index].season,
                  dataList[index].key,
                  context);
            }),
      );
    }
  }
}

//Fall
//Spring
class FallFruitsList extends StatefulWidget {
  @override
  _FallFruitsListState createState() => _FallFruitsListState();
}

class _FallFruitsListState extends State<FallFruitsList> {
  List<Data> dataList = [];

  @override
  void initState() {
    DatabaseReference _ref = FirebaseDatabase.instance
        .reference()
        .child('Fruits')
        .child('fallFruit');
    _ref.once().then((DataSnapshot snapshot) {
      dataList.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        Data data = new Data(
            name: values[key]['name'],
            des: values[key]['description'],
            price: values[key]['price'],
            season: values[key]['season'],
            imgUrl: values[key]['image'],
            key: key.toString());
        dataList.add(data);
      }

      print(dataList.length);
      setState(() {
        //Set States
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.length == 0) {
      return Container(
        child: Center(
          child: Column(
            children: [
              Image(
                width: 300,
                image: AssetImage("assets/dog.png"),
              ),
              Text("No Fruits Available",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 25)),
            ],
          ),
        ),
      );
    } else {
      double height = 170.0 * dataList.length;
      return Container(
        height: height,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (_, index) {
              return CardUI(
                  dataList[index].name,
                  dataList[index].des,
                  dataList[index].imgUrl,
                  dataList[index].price,
                  dataList[index].season,
                  dataList[index].key,
                  context);
            }),
      );
    }
  }
}

Widget CardUI(String name, String des, String image, int price, String season,
    String key, BuildContext context) {
  int counter = 0;
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FruitDetails(
                name: name,
                price: price,
                image: image,
                des: des,
                season: season,
                keys: key,
              )));
    },
    child: Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.purple, Colors.blue]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          image != null
              ? Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(image),
                      width: 130,
                    ),
                  ),
                )
              : Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                ),
          Column(
            children: [
              Text(name,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
              Text("Rs.$price/Kg",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    ),
  );
}
