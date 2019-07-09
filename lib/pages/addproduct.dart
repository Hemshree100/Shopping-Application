import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProduct extends StatefulWidget {

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int id;
  String name;
  String desc;
  double price;
  String url;
  addRecordInDb()  {
    Map<String, Object> map = <String, Object>{
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'url': url
    };
    print("Map is $map");
    final DocumentReference documentReference =
    Firestore.instance.document("prods/" + id.toString());
    //Prods is collection and id is record
    print("Document Reference is $documentReference");
    documentReference.setData(map).then((data){
      print("Record Added SuccessFully ");
    }).catchError((err){
      print("Error During Add $err");
    });
//    documentReference.setData(map).whenComplete(() {
//      print("Document Added..............");
//    }).catchError((e) => print("Error is::::::::: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Shopping Application'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
          ),

        ],

      ),
      body: ListView(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            autofocus: true,
            onChanged: (str) => id = int.parse(str),
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(hintText: 'Type Id Here'),
          ),
          TextField(
            maxLength: 30,
            keyboardType: TextInputType.text,
            onChanged: (str) => name = str,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(hintText: 'Type Name Here'),
          ),
          TextField(
            keyboardType: TextInputType.text,
            maxLines: 5,
            maxLength: 500,
            onChanged: (str) => desc = str,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(hintText: 'Type Desc Here'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (str) => price = double.parse(str),
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone), hintText: 'Type Price Here'),
          ),
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (str) => url = str,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type URL Here',
                prefixIcon: Icon(Icons.web)),
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              'Add Product',
              style: TextStyle(fontSize: 20),
            ),
            elevation: 3,
            onPressed: () {
              print(
                  "Id is $id NAme is $name Desc is $desc Price is $price URL is $url");
              addRecordInDb();

            },
          ),
        ],
      ),

      );

  }
}
