// import 'package:delicia/pages/fruitDetails.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SearchQueryPage extends StatefulWidget {
//   @override
//   _SearchQueryPageState createState() => _SearchQueryPageState();
// }

// class Data {
//   String imgUrl, name, des, season, key;
//   int price;

//   Data({this.des, this.imgUrl, this.name, this.price, this.season, this.key});
// }

// class _SearchQueryPageState extends State<SearchQueryPage> {
//   DatabaseReference _ref;
//   List<Data> dataList = [];
//   bool load = false;
//   List<Data> searchResult = [];
//   TextEditingController searchController = TextEditingController();
//   @override
//   void initState() {
//     getDataSummer();
//     getDataWinter();
//     getDataSpring();
//     // getDataFall();
//     searchResult = dataList;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         iconTheme: IconThemeData(color: Colors.white),
//         elevation: 0,
//         title: TextFormField(
//           controller: searchController,
//           onChanged: (value) => showResult(value),
//           decoration: InputDecoration(
//             suffixIcon: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.search),
//             ),
//             hintText: "Enter Fruit Name Here",
//             filled: true,
//             fillColor: Colors.grey[100],
//           ),
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.only(top: 15),
//         child: ListView(
//           children: [
//             searchResult.length == 0
//                 ? Container(
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Image(
//                             width: 300,
//                             image: AssetImage("assets/dog.png"),
//                           ),
//                           Text("No Fruits Available",
//                               style: GoogleFonts.poppins(
//                                   color: Colors.black, fontSize: 25)),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Container(
//                     height: searchResult.length * 165.0,
//                     child: ListView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: searchResult.length,
//                         itemBuilder: (_, index) {
//                           return CardUI(
//                               searchResult[index].name,
//                               searchResult[index].des,
//                               searchResult[index].imgUrl,
//                               searchResult[index].price,
//                               searchResult[index].season,
//                               searchResult[index].key,
//                               context);
//                         }),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget CardUI(String name, String des, String image, int price, String season,
//       String key, BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => FruitDetails(
//                   name: name,
//                   price: price,
//                   image: image,
//                   des: des,
//                   season: season,
//                   keys: key,
//                 )));
//       },
//       child: Container(
//         margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [Colors.purple, Colors.blue]),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             image != null
//                 ? Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.only(top: 0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image(
//                         image: NetworkImage(image),
//                         width: 130,
//                       ),
//                     ),
//                   )
//                 : Container(
//                     height: 100,
//                     width: 100,
//                     color: Colors.red,
//                   ),
//             Column(
//               children: [
//                 Text(name,
//                     style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400)),
//                 Text("Rs.$price/Kg",
//                     style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void getDataSummer() {
//     DatabaseReference _ref = FirebaseDatabase.instance
//         .reference()
//         .child('Fruits')
//         .child('summerFruit');
//     _ref.once().then((DataSnapshot snapshot) {
//       var keys = snapshot.value.keys;
//       var values = snapshot.value;
//       for (var key in keys) {
//         Data data = new Data(
//             name: values[key]['name'],
//             des: values[key]['description'],
//             price: values[key]['price'],
//             season: values[key]['season'],
//             imgUrl: values[key]['image'],
//             key: key.toString());
//         dataList.add(data);
//       }
//       print(dataList.length);
//     });
//   }

//   void getDataWinter() {
//     DatabaseReference _ref = FirebaseDatabase.instance
//         .reference()
//         .child('Fruits')
//         .child('winterFruit');
//     _ref.once().then((DataSnapshot snapshot) {
//       var keys = snapshot.value.keys;
//       var values = snapshot.value;

//       for (var key in keys) {
//         Data data = new Data(
//             name: values[key]['name'],
//             des: values[key]['description'],
//             price: values[key]['price'],
//             season: values[key]['season'],
//             imgUrl: values[key]['image'],
//             key: key.toString());
//         dataList.add(data);
//       }
//       print(dataList.length);
//     });
//   }

//   void getDataSpring() {
//     _ref = FirebaseDatabase.instance
//         .reference()
//         .child('Fruits')
//         .child('springFruit');
//     _ref.once().then((DataSnapshot snapshot) {
//       var keys = snapshot.value.keys;
//       var values = snapshot.value;

//       for (var key in keys) {
//         Data data = new Data(
//             name: values[key]['name'],
//             des: values[key]['description'],
//             price: values[key]['price'],
//             season: values[key]['season'],
//             imgUrl: values[key]['image'],
//             key: key.toString());
//         dataList.add(data);
//       }
//       print(dataList.length);
//       setState(() {
//         load = true;
//       });
//     });
//   }

//   void getDataFall() {
//     DatabaseReference _ref = FirebaseDatabase.instance
//         .reference()
//         .child('Fruits')
//         .child('fallFruit');
//     _ref.once().then((DataSnapshot snapshot) {
//       if (snapshot.value.keys != null) {
//         var keys = snapshot.value.keys;
//         var values = snapshot.value;
//         for (var key in keys) {
//           Data data = new Data(
//               name: values[key]['name'],
//               des: values[key]['description'],
//               price: values[key]['price'],
//               season: values[key]['season'],
//               imgUrl: values[key]['image'],
//               key: key.toString());
//           dataList.add(data);
//         }
//         print(dataList.length);
//       } else {
//         print("No Data");
//       }
//     });
//   }

//   void changedValue(String value) {
//     print(value);
//     if (value == "") {
//       setState(() {
//         searchResult.clear();
//         searchResult = dataList;
//       });
//     }
//   }

//   void showResult(String value) {
//     if (value == "") {
//       setState(() {
//         searchResult.clear();
//         searchResult = dataList;
//         print(dataList);
//       });
//     }
//     print(dataList.length);
//     for (int i = 0; i < dataList.length; i++) {
//       print(dataList[i].name);
//       if (dataList[i]
//           .name
//           .toLowerCase()
//           .contains(searchController.text.toLowerCase())) {
//         String name = dataList[i].name;
//         double price = dataList[i].price + 0.0;
//         String image = dataList[i].imgUrl;
//         String season = dataList[i].season;
//         String des = dataList[i].season;

//         print(name + price.toString() + des + season + image);

//         Data result = new Data(
//           name: name,
//           price: price.toInt(),
//           imgUrl: image,
//           season: season,
//           des: des,
//         );

//         setState(() {
//           searchResult.clear();
//           searchResult.add(result);
//         });
//         print("done");
//       }
//     }
//     print(dataList.length);
//   }
// }
