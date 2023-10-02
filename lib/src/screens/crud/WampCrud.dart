import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdg/src/screens/crud/Details.dart';
import 'package:sdg/src/screens/crud/editdata.dart';
import 'package:sdg/src/screens/crud/newdata.dart';

class CrudOperation extends StatefulWidget {
  const CrudOperation({Key? key}) : super(key: key);

  @override
  State<CrudOperation> createState() => _CrudOperationState();
}

class _CrudOperationState extends State<CrudOperation> {
  final List<String> county = <String>[];
  final List<String> beachID = <String>[];

  TextEditingController countyController = TextEditingController();
  TextEditingController beachIdController = TextEditingController();

  String selectedCounty = "Select County";
  String selectedBeach = "Select Beach";

  final _dropdownFormKey = GlobalKey<FormState>();

  void addItemToList() {
    setState(() {
      county.insert(0, selectedCounty); //countyController.text);
      beachID.insert(0, selectedBeach);
    });
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownCountyItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select County", child: Text("Select County")),
      const DropdownMenuItem(
          value: "Mombasa County", child: Text("Mombasa County")),
      const DropdownMenuItem(
          value: "Kilifi County", child: Text("Kilifi County")),
      const DropdownMenuItem(value: "Lamu County", child: Text("Lamu County")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownBeachItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Beach", child: Text("Select Beach")),
      const DropdownMenuItem(
          value: "Shimoni Beach", child: Text("Shimoni Beach")),
      const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
      const DropdownMenuItem(
          value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
      const DropdownMenuItem(
          value: "Mkomani Beach", child: Text("Mkomani Beach")),
      const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
      const DropdownMenuItem(
          value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
      const DropdownMenuItem(
          value: "Bandarini Beach", child: Text("Bandarini Beach")),
      const DropdownMenuItem(
          value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
    ];
    return menuItems;
  }

  // This function is triggered when the floating buttion is pressed
  void _show(BuildContext ctx) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
          padding: EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
          child: Form(
            key: _dropdownFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Center(
                    child: Text(
                  'Transect Details',
                  style: TextStyle(
                      //color: Colors.white,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.bold,
                      //fontStyle: FontStyle.italic,
                      fontSize: 20.0),
                )),
                const SizedBox(
                  height: 30,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    validator: (value) =>
                        value == "Select County" ? "Select a county" : null,
                    //dropdownColor: Colors.blueAccent,
                    value: selectedCounty,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCounty = newValue!;
                      });
                    },
                    items: dropdownCountyItems),
                const SizedBox(
                  height: 30,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    validator: (value) =>
                        value == "Select Beach" ? "Select a beach" : null,
                    //dropdownColor: Colors.blueAccent,
                    value: selectedBeach,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBeach = newValue!;
                      });
                    },
                    items: dropdownBeachItems),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            // addItemToList();
                            // Navigator.pop(
                            //   context,
                            //   "This string will be passed back to the parent",
                            // );
                            // setState(() {
                            //   selectedCounty = '';
                            //   selectedBeach = '';
                            // });

                            if (_dropdownFormKey.currentState!.validate()) {
                              addItemToList();
                              //Add to Database
                              addData();

                              //valid flow
                              Navigator.pop(
                                context,
                                "This string will be passed back to the parent",
                              );
                              setState(() {
                                selectedCounty = "Select County";
                                selectedBeach = "Select Beach";
                              });
                            }
                          },
                          child: const Text('Submit')),
                    ),
                  ],
                )
              ],
            ),
          )),

      // Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const SizedBox(
      //       height: 15,
      //     ),
      //     const Center(
      //         child: Text(
      //           'County Details',
      //           style: TextStyle(
      //             //color: Colors.white,
      //               fontFamily: 'ProximaNova',
      //               fontWeight: FontWeight.bold,
      //               //fontStyle: FontStyle.italic,
      //               fontSize: 20.0),
      //         )),
      //     const SizedBox(
      //       height: 15,
      //     ),
      //     DropdownButtonFormField(
      //         decoration: InputDecoration(
      //           enabledBorder: OutlineInputBorder(
      //             borderSide: const BorderSide(
      //                 color: Colors.blue, width: 2),
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           border: OutlineInputBorder(
      //             borderSide: const BorderSide(
      //                 color: Colors.blue, width: 2),
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           filled: true,
      //           fillColor: Colors.transparent,
      //         ),
      //         validator: (value) => value == "Select County"
      //             ? "Select a transect"
      //             : null,
      //         dropdownColor: Colors.blueAccent,
      //         value: selectedValue,
      //         icon: const Icon(Icons.keyboard_arrow_down),
      //         onChanged: (String? newValue) {
      //           setState(() {
      //             selectedValue = newValue!;
      //           });
      //         },
      //         items: dropdownItems),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     Row(
      //       children: [
      //         Expanded(
      //           child: ElevatedButton(
      //               onPressed: () {
      //                 addItemToList();
      //                 Navigator.pop(
      //                   context,
      //                   "This string will be passed back to the parent",
      //                 );
      //                 setState(() {
      //                   selectedCounty = 'a';
      //                   selectedBeach = 'a';
      //                 });
      //               },
      //               child: const Text('Submit')),
      //         ),
      //       ],
      //     )
      //   ],
      // ),
    );
  }

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.2.106/sdg/getdata.php"));

    return json.decode(response.body);
  }

  void addData() {
    var url = "http://192.168.2.106/sdg/adddata.php";
    http.post(Uri.parse(url), body: {
      'county': selectedCounty,
      'beach': selectedBeach,
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Beach Details'),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Colors.grey,
          onPressed: () {
            //...
          },
          child: PopupMenuButton(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.grey,
                child: const Icon(Icons.download),
              ),
            ),
            onSelected: (value) {
              if (value == "download") {
                // add desired output
              } else if (value == "brand") {
                // add desired output
              } else if (value == "count") {
                // add desired output
              } else if (value == "upload") {
                // add desired output
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "download",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.download)),
                    Text(
                      'Download from Server',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "brand",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.logout)),
                    Text(
                      'Macro-Branding.xlxs',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "count",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.logout)),
                    Text(
                      'Macro-Counts.xlxs',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "upload",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.upload_file),
                    ),
                    Text(
                      'Upload to Server',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          heroTag: "btn2",
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add),
          onPressed: () => _show(context),
        ),
      ]),
      body:
      FutureBuilder<List>(
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
    if (list.isEmpty) {
      return const Center(
        child: Text('Press the + button to add a beach'),
      );
    }else {
      return ListView.separated(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Center(
                  child: Text(
                    list[list.length - 1 - index]['county'].substring(0, 1),
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  )),
            ),
            title: Text(list[list.length - 1 - index]['county']),
            subtitle: Text(list[list.length - 1 - index]['beach']),
            trailing: Wrap(
              spacing: -16,
              children: [
                IconButton(
                    icon: const Icon(Icons.edit_note),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Edit(list: list, index: list.length - 1 - index),
                        ),
                      );
                    }),
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () =>
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text(
                                'Warning',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'Are you sure you want to delete \n${list[list
                                    .length - 1 - index]['beach']}',
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Cancel');
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {

                                          var url =
                                              "http://192.168.2.106/sdg/deletedata.php";
                                          http.post(Uri.parse(url), body: {
                                            'id': list[list.length - 1 -
                                                index]['id'],
                                          });

                                          Navigator.pop(context);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              const CrudOperation(),
                                            ),
                                          );
                                        },
                                        //Navigator.pop(context, 'Yes'),
                                        child: const Text('Yes'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      ),
                ),
              ],
            ),
            // onTap: () {
            //   //print(county[county.length - 1 - index]);
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => TransectDetails(
            //           countyTag: list[list.length - 1 - index]['county'],
            //           beachID: list[list.length - 1 - index]['beach'])));
            // },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          );
        },
      );
    }
  }
}
