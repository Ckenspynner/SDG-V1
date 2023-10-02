import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sdg/src/constants/text_strings.dart';
import 'package:sdg/src/screens/crud/EditMacroBrands.dart';
import 'dart:convert';

class DataViewsBrand extends StatefulWidget {
  final String transect;
  final String beachID;

  const DataViewsBrand(
      {Key? key, required this.transect, required this.beachID})
      : super(key: key);

  @override
  State<DataViewsBrand> createState() => _DataViewsBrandState();
}

class _DataViewsBrandState extends State<DataViewsBrand> {
  Future<List> getData() async {
    var url = "http://$ipAddress/sdg/kbrands/getdata.php";
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
        title: const Text('Micro-Branding-Data'),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DataViewsBrand(
                      beachID: widget.beachID,
                      transect: widget.transect,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.refresh,
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
                        'Brand',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Manufacturer',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Origin Country',
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
                        'Type Of Product',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Type Of Material',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Type Of Layer',
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
                        DataCell(Text(list[index]['Brand'] ?? '')),
                        DataCell(Text(list[index]['Manufacturer'] ?? '')),
                        DataCell(Text(list[index]['Country'] ?? '')),
                        DataCell(Text(list[index]['Zone'] ?? '')),
                        DataCell(Text(list[index]['TypeOfProduct'] ?? '')),
                        DataCell(Text(list[index]['TypeOfMaterial'] ?? '')),
                        DataCell(Text(list[index]['TypeOfLayer'] ?? '')),
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
                                        EditMacroBrand(
                                      listItem: list[index]['Brand'],
                                      index: index,
                                      transect: list[index]['Transect'],
                                      zone:
                                          'Transect1 > ${list[index]['Zone']}',
                                      beachID: list[index]['BeachID'],
                                      countID: list[index]['Counts'],
                                      manufacturerID: list[index]['Manufacturer'],
                                      countryID: list[index]['Country'],
                                    ),
                                  ),
                                );
                              }),
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
