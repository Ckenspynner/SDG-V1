import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sdg/src/screens/crud/WampCrud.dart';
import 'dart:convert';

import 'package:sdg/src/screens/crud/editdata.dart';

class Details extends StatefulWidget {
  List list;
  int index;

  Details({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  void delete() {
    var url = "http://192.168.2.106/sdg/deletedata.php";
    http.post(Uri.parse(url), body: {
      'id': widget.list[widget.index]['id'],
    });
  }

  void confirm() {
    showDialog(context: context, builder: (builder)=>AlertDialog(
      content: const Text('Are you sure?'),
      actions: <Widget>[

        MaterialButton(
          onPressed: () {Navigator.pop(context, 'Cancel');},
          child: const Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () {
            delete();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const CrudOperation(),
              ),
            );
          },
          child: const Text('Yes'),
        ),

      ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['beach']}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  widget.list[widget.index]['county'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  widget.list[widget.index]['beach'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                MaterialButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Edit(list: widget.list, index: widget.index),
                    ),
                  ),
                  child: const Text('Edit'),
                ),
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    confirm();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
