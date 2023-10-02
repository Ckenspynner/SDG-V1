import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';
import 'package:sdg/src/screens/categories/kcategory.dart';
import 'dart:convert';

import 'package:sdg/src/screens/county/countydetails.dart';

class TransectDetails extends StatefulWidget {
  final String countyTag;
  final String beachID;

  const TransectDetails(
      {super.key, required this.countyTag, required this.beachID});

  @override
  State<StatefulWidget> createState() => _TransectDetailsState();
}

class _TransectDetailsState extends State<TransectDetails> {
  // This function is triggered when the floating buttion is pressed

  final List<String> transect = <String>[];
  final List<String> dry = <String>[];
  final List<String> center = <String>[];
  final List<String> wet = <String>[];

  String selectedValue = "Select Transect";
  int gpsTextField = 0;
  final _dropdownFormKey = GlobalKey<FormState>();

  TextEditingController dryController = TextEditingController();
  TextEditingController centerController = TextEditingController();
  TextEditingController wetController = TextEditingController();

  /*
  serviceEnabled and permissionGranted are used
  to check if location service is enable and permission is granted
  */
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  LocationData? _userLocation;

  // This function will get user location
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _userLocation = locationData;
    });
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Transect", child: Text("Select Transect")),
      const DropdownMenuItem(value: "T1", child: Text("T1")),
      const DropdownMenuItem(value: "T2", child: Text("T2")),
      const DropdownMenuItem(value: "T3", child: Text("T3")),
      const DropdownMenuItem(value: "T4", child: Text("T4")),
      const DropdownMenuItem(value: "T5", child: Text("T5")),
      const DropdownMenuItem(value: "T6", child: Text("T6")),
      const DropdownMenuItem(value: "T7", child: Text("T7")),
      const DropdownMenuItem(value: "T8", child: Text("T8")),
      const DropdownMenuItem(value: "T9", child: Text("T9")),
    ];
    return menuItems;
  }

  //Loader configurations
  Future<void> loader() async {
    OverlayLoadingProgress.start(context,
        gifOrImagePath: 'assets/loading.gif',
        barrierDismissible: true,
        widget: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.black38,
          color: darkBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  size: 50,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const DefaultTextStyle(
                style: TextStyle(decoration: TextDecoration.none),
                child: Text(
                  'Marine Litter\nSDG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
    await Future.delayed(const Duration(seconds: 1));
    OverlayLoadingProgress.stop();
  }

  double distanceInMeters = 0.0;
  var splitagStart, splitagEnd;

  // This function is triggered when the floating buttion is pressed
  void _show(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 25,
                  left: 25,
                  right: 25,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
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
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) => value == "Select Transect"
                              ? "Select a transect"
                              : null,
                          //dropdownColor: Colors.blueAccent,
                          value: selectedValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: dropdownItems),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: dryController,
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Start Dry',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _getUserLocation();
                              gpsTextField = 1;
                              if (gpsTextField == 1) {
                                dryController.text =
                                    'lat: ${_userLocation?.latitude} , long: ${_userLocation?.longitude}';
                              }
                            },
                            icon: const Icon(
                              Icons.wb_sunny_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: centerController,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'End Dry / Start Wet',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _getUserLocation();
                              gpsTextField = 2;
                              if (gpsTextField == 2) {
                                centerController.text =
                                    'lat: ${_userLocation?.latitude} , long: ${_userLocation?.longitude}';
                              }
                            },
                            icon: const Icon(
                              Icons.share_location,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: wetController,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'End Wet',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _getUserLocation();
                              gpsTextField = 3;
                              if (gpsTextField == 3) {
                                wetController.text =
                                    'lat: ${_userLocation?.latitude} , long: ${_userLocation?.longitude}';
                              }
                            },
                            icon: const Icon(
                              Icons.water_drop_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  _getUserLocation();
                                  //addItemToList();
                                  if (_dropdownFormKey.currentState!
                                      .validate()) {
                                    Future.delayed(Duration.zero, () async {
                                      loader();
                                    });

                                    splitagStart =
                                        dryController.text.split(",");
                                    splitagEnd = dryController.text.split(",");

                                    // print('${splitagStart[0].substring(5)} ${splitagStart[1].substring(7)}');
                                    // print('${splitagEnd[0].substring(5)} ${splitagEnd[1].substring(7)}');

                                    distanceInMeters =
                                        Geolocator.distanceBetween(
                                            double.parse(
                                                splitagStart[0].substring(5)),
                                            double.parse(
                                                splitagStart[1].substring(7)),
                                            double.parse(
                                                splitagEnd[0].substring(5)),
                                            double.parse(
                                                splitagEnd[1].substring(7)));
                                    //print(distanceInMeters);
                                    addData();

                                    //valid flow
                                    Navigator.pop(
                                      context,
                                      "This string will be passed back to the parent",
                                    );

                                    setState(() {
                                      selectedValue = "Select Transect";
                                      dryController.text = '';
                                      centerController.text = '';
                                      wetController.text = '';
                                    });
                                  }
                                },
                                child: const Text("Submit")),
                          ),
                        ],
                      )
                    ],
                  )),
            ));
  }

  Future<List> getData() async {
    var url = "http://$ipAddress/sdg/transect/getdata.php";
    final response = await http.post(Uri.parse(url), body: {
      'beachID': widget.beachID,
    });

    return json.decode(response.body);
  }

  void addData() {
    var url = "http://$ipAddress/sdg/transect/adddata.php";
    http.post(Uri.parse(url), body: {
      'transect': selectedValue,
      'startgps': dryController.text,
      'centergps': centerController.text,
      'endgps': wetController.text,
      'beachID': widget.beachID,
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.beachID} Transects'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const CountyDetails()));
            //print(countyTag);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TransectDetails(
                      countyTag: widget.countyTag, beachID: widget.beachID)));
            },
            icon: const Icon(
              Icons.refresh,
              //color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
        onPressed: () => _show(context),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            //print('error');
          }
          if (snapshot.hasData) {
            return TransectItems(
                list: snapshot.data ?? [],
                countyTag: widget.countyTag,
                beachID: widget.beachID,
                distanceInMeters: distanceInMeters);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}

class TransectItems extends StatelessWidget {
  List list;
  final String countyTag;
  final String beachID;

  final double distanceInMeters;

  TransectItems(
      {Key? key,
      required this.list,
      required this.countyTag,
      required this.beachID,
      required this.distanceInMeters})
      : super(key: key);

  TextEditingController _inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(
        child: Text('Press the + button to add a transect'),
      );
    } else {
      return ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Center(
                  child: Text(
                list[index]['transect'],
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              )),
            ),
            title: Text(
              'Transect ${list[index]['transect'].substring(1, 2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'ProximaNova',
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            trailing: Wrap(spacing: -5, children: [
              IconButton(
                  icon: const Icon(
                    Icons.wb_sunny_outlined,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KCategory(
                              selectedTransectZoneTag:
                                  'Transect ${list[index]['transect'].substring(1, 2)} > Dry',
                              selectedTransectTag: 'Transect ${index + 1}',
                              transectID: list[index]['transect'],
                              countyID: countyTag,
                              beachID: beachID,
                              distanceInMeters: distanceInMeters,
                              startDryGPS: list[index]['startgps'],
                              centerGPS: list[index]['centergps'],
                              endWetGPS: list[index]['endgps'],
                            )));
                    //print(countyTag);
                  }),
              IconButton(
                icon: const Icon(
                  Icons.water_drop_outlined,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KCategory(
                            selectedTransectZoneTag:
                                'Transect ${list[index]['transect'].substring(1, 2)} > Wet',
                            selectedTransectTag: 'Transect ${index + 1}',
                            transectID: list[index]['transect'],
                            countyID: countyTag,
                            beachID: beachID,
                            distanceInMeters: distanceInMeters,
                            startDryGPS: list[index]['startgps'],
                            centerGPS: list[index]['centergps'],
                            endWetGPS: list[index]['endgps'],
                          )));
                  //print(countyTag);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.blueAccent,
                ),
                // onPressed: () {
                //
                // },
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Warning',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      'Are you sure you want to delete \n${list[index]['transect']}',
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
                                Navigator.pop(context, 'Yes');
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Verify Action !',
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontFamily: 'ProximaNova',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.close_outlined,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context, 'Yes');
                                                },
                                              ),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller:
                                                    _inputTextController,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "Confirm"),
                                                onChanged: (value) {
                                                  if (value.toTitleCase() ==
                                                      'Confirm') {
                                                    _inputTextController
                                                        .clear();

                                                    var url =
                                                        "http://$ipAddress/sdg/transect/deletedata.php";
                                                    http.post(Uri.parse(url),
                                                        body: {
                                                          'id': list[index]
                                                              ['id'],
                                                        });
                                                    Navigator.pop(context);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            TransectDetails(
                                                          countyTag: countyTag,
                                                          beachID: beachID,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ));
                              },
                              child: const Text('Yes'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
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
