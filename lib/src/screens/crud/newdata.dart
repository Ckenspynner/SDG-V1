import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdg/src/screens/crud/WampCrud.dart';

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);

  @override
  State<NewData> createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController controllerCounty = TextEditingController();
  TextEditingController controllerBeach = TextEditingController();

  void addData() {
    var url = "http://192.168.2.106/sdg/adddata.php";
    http.post(Uri.parse(url), body: {
      'county': controllerCounty.text,
      'beach': controllerBeach.text,
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Data'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: controllerCounty,
            decoration: const InputDecoration(hintText: 'Enter County Name'),
          ),
          TextField(
            controller: controllerBeach,
            decoration: const InputDecoration(hintText: 'Enter Beach Name'),
          ),
          MaterialButton(
            onPressed: () {
              addData();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const CrudOperation(),
                ),
              );
            },
            color: Colors.redAccent,
            child: const Text('Add Data'),
          )
        ],
      ),
    );
  }
}
