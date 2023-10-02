import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sdg/src/constants/text_strings.dart';
import 'package:sdg/src/screens/crud/EditMacroCount.dart';
import 'dart:convert';

import 'package:sdg/src/screens/dataview/DataViewBrand.dart';

class DataViewsCounts extends StatefulWidget {
  final String transect;
  final String beachID;

  const DataViewsCounts(
      {Key? key, required this.transect, required this.beachID})
      : super(key: key);

  @override
  State<DataViewsCounts> createState() => _DataViewsCountsState();
}

class _DataViewsCountsState extends State<DataViewsCounts> {
  Future<List> getData() async {
    var url = "http://$ipAddress/sdg/kcounts/getdata.php";
    final response = await http.post(Uri.parse(url), body: {
      'transect': widget.transect,
      'beachID': widget.beachID,
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro-Counts-Data'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DataViewsCounts(
                        beachID: widget.beachID,
                        transect: widget.transect,
                      )));
            },
            icon: const Icon(
              Icons.refresh,
              //color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DataViewsBrand(
                      beachID: widget.beachID,
                      transect: widget.transect,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward,
                //color: Colors.black,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print('error');
          }
          if (snapshot.hasData) {
            return Items(list: snapshot.data ?? []);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'BeachID',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Location',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Transect',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Start Dry',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Dry/Wet GPS',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'End Wet GPS',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Zone',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Category',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Item',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Weight',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Counts',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Modify Data',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    list == null ? 0 : list.length,
                    (index) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                            '${index + 1} )  ${list[index]['Dates'] ?? ''}')),
                        DataCell(Text(list[index]['BeachID'] ?? '')),
                        DataCell(Text(list[index]['Location'] ?? '')),
                        DataCell(Text(list[index]['Transect'] ?? '')),
                        DataCell(Text(list[index]['Startgps'] ?? '')),
                        DataCell(Text(list[index]['Centergps'] ?? '')),
                        DataCell(Text(list[index]['Endgps'] ?? '')),
                        DataCell(Text(list[index]['Zone'] ?? '')),
                        DataCell(Text(list[index]['Category'] ?? '')),
                        DataCell(Text(list[index]['Items'] ?? '')),
                        DataCell(Text(list[index]['Weight'] ?? '')),
                        DataCell(Text(list[index]['Counts'] ?? '')),
                        DataCell(
                          IconButton(
                            icon: const Icon(
                              //color: Colors.blueAccent,
                              Icons.edit_note,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EditMacroCount(
                                    listItem: list[index]['Items'],
                                    index: index,
                                    transect: list[index]['Transect'],
                                    zone: 'Transect1 > ${list[index]['Zone']}',
                                    selectedCategoryTag: list[index]['Category'],
                                    beachID: list[index]['BeachID'],
                                    count: list[index]['Counts'],
                                    weight: list[index]['Weight'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
