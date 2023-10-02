import 'dart:convert';
import 'dart:core';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';
import 'package:http/http.dart' as http;

class CategoryItems extends StatefulWidget {
  final String selectedCategoryTag;
  final String selectedCategoryTransectTag;
  final String transectID;
  final String countyID;
  final String beachID;
  final String startDryGPS;
  final String centerGPS;
  final String endWetGPS;
  final String zone;
  final double distanceInMeters;

  const CategoryItems({
    Key? key,
    required this.selectedCategoryTag,
    required this.selectedCategoryTransectTag,
    required this.transectID,
    required this.countyID,
    required this.beachID,
    required this.startDryGPS,
    required this.centerGPS,
    required this.endWetGPS,
    required this.zone,
    required this.distanceInMeters,
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  var controllerWeight = TextEditingController();
  var controllerCount = TextEditingController();

  var combinedCheckboxValueSelected = '';
  var splitagItem, splitagValues, splitagZone;

  List multipleSelected = [];
  List checkListItems = [];

  String? _iteminputString, _save_button_status = 'Save';

  static const List<String> _kOptionsItems = <String>[
    'Aluminum Foil',
    'Asbestos',
    'Baloon',
    'Basin',
    'Bathing Rug',
    'Battery',
    'Battery Lid',
    'Beverage Bottle',
    'Beverage Can',
    'Blister Packs',
    'Boat Fibre',
    'Books',
    'Buoy',
    'Burnt Plastic',
    'Button',
    'Caps/Lids/Rings',
    'Carrier Bag',
    'Carton',
    'Cello Tape',
    'Ceramic',
    'Cigarette Butt',
    'Cigarette Lighter',
    'Cigarette Packet',
    'Cloth Mask',
    'Clothes',
    'Comb',
    'Condom',
    'Cosmetic Container',
    'Cotton Buds',
    'Credit Card',
    'Cups And Plates',
    'Diaper',
    'Electric Cable',
    'Fishing Line',
    'Fishing Net',
    'Fishing Rope',
    'Flipflop',
    'Flipflop Fragments',
    'Foam',
    'Food Container',
    'Food Wrapper',
    'Glass Bottle',
    'Glass Fragment',
    'Handle Brush',
    'Hard Plastic',
    'Hdpe Container',
    'Household Wrappers',
    'Ice Cream Stick',
    'Jerican',
    'Kinangop Milk',
    'Leather Bag',
    'Lighter',
    'Manilaa Rope',
    'Mattress',
    'Medicine Blister Packs',
    'Medicine Blister Packs Bottle',
    'Medicine Blister Packs Sachet',
    'Metal',
    'Metal Can',
    'Metal Cap',
    'Metal Fragment',
    'Metal Sheet',
    'Metal Wire',
    'Mosquito Net',
    'Nails',
    'Net',
    'Newspaper',
    'Oil Container',
    'Paper',
    'Paper Bag',
    'Peg Fragments',
    'Pens',
    'Pet Bottle',
    'Pet Fragment',
    'Phone Cable',
    'Phone Cover',
    'Pipe Pvc',
    'Plastic Caps',
    'Plastic Cups',
    'Plastic Fragments',
    'Plastic Rope',
    'Plastic Torch',
    'Plate',
    'Poker Cards',
    'Porcelain',
    'Processed Wood',
    'Pvc Canvas',
    'Pvc Carpet',
    'Pvc Pipe',
    'Razor Blade',
    'Receipt',
    'Rope',
    'Rubber Fragment',
    'Sack',
    'Sandpaper',
    'Sanitary Towel',
    'Sanitary Towel Wrapper',
    'Scratch Card',
    'Seal',
    'Sheeting',
  ];

  bool changeColor = false;

  String combinedCheckboxValue = '', itemName = '';
  double itemWeight = 0.0;
  int itemCounts = 0;

  final ScrollController _controllerCheckboxTile = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controllerCheckboxTile.animateTo(
      _controllerCheckboxTile.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   int x = -1;
  //   for (int i = 0; i < checkListItems1.length; i++) {
  //     if (checkListItems1[i]["Category"] == widget.selectedCategoryTag) {
  //       x++;
  //
  //       checkListItems.insert(x, {
  //         "value": false,
  //         "title": checkListItems1[i]["title"],
  //         "Category": widget.selectedCategoryTag,
  //         "count": "0",
  //         "weight": "0",
  //       });
  //     } else {
  //       continue;
  //     }
  //   }
  //   super.initState();
  // }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                'Are you sure you want to leave this page all unsaved entries will be lost.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    "This string will be passed back to the parent",
                  );
                  Navigator.pop(context, 'Yes');
                },
                //Navigator.pop(context, 'Yes'),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
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

  String currentDate = DateFormat('d/M/yyyy').format(DateTime.now());

  void addData() {
    var url = "http://$ipAddress/sdg/counts/adddata.php";
    http.post(Uri.parse(url), body: {
      'Date': currentDate,
      'Location': widget.countyID.toTitleCase(),
      'BeachID': widget.beachID.toTitleCase(),
      'Transect': widget.transectID,
      'StartDry': widget.startDryGPS,
      'CenterDryWet': widget.centerGPS,
      'EndWet': widget.endWetGPS,
      'Zone': splitagZone[1],
      'Distance': '${widget.distanceInMeters}',
      'Category': widget.selectedCategoryTag,
      'Items': '${splitagItem[0]}'.toTitleCase(),
      'Count': splitagValues[1],
      'Weight': splitagValues[3],
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
  }

  var itemRowCount;

  Future<List> getData() async {
    var url = "http://$ipAddress/sdg/kcounts/getdata.php";
    final response = await http.post(Uri.parse(url), body: {
      'transect': widget.transectID,
      'beachID': widget.beachID,
    });
    var responsedata = jsonDecode(response.body);

    setState(() {
      itemRowCount = responsedata.length;
    });
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.blue,
            splashRadius: 20.0,
            onPressed: () {
              if (_save_button_status == 'Saved') {
                Navigator.pop(
                  context,
                  "This string will be passed back to the parent",
                );
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Warning'),
                    content: const Text(
                        'Are you sure you want to leave this page all unsaved entries will be lost.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            "This string will be passed back to the parent",
                          );
                          Navigator.pop(context, 'Yes');
                        },
                        //Navigator.pop(context, 'Yes'),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text('${widget.transectID} > ${widget.selectedCategoryTag}'),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                '$itemRowCount',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.bold,
                  //color: Colors.black,
                ),
              )),
            ),
          ],
        ),
        //backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(20),
            controller: _controllerCheckboxTile,
            itemCount: checkListItems.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                checkboxShape: const CircleBorder(),
                activeColor: Colors.blue,
                // secondary: Card(
                //   //color: Colors.,
                //   child: TextButton(
                //     style: TextButton.styleFrom(
                //       foregroundColor: Colors.white,
                //     ),
                //     onPressed: () {
                //       var splitag = checkListItems[index]["title"].split(",");
                //       itemName = splitag[0];
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => //const CategoryItems()
                //           BrandItems(
                //               selectedBrandTag: itemName,
                //               selectedBrandTransectTag:
                //               widget.selectedCategoryTag,
                //               countyID: widget.countyID,
                //               beachID: widget.beachID,
                //               zone: widget.zone,
                //               transect: widget.transectID)));
                //     },
                //     child: const Text('+ Brands'),
                //   ),
                // ),
                dense: true,
                title: Text(
                  checkListItems[index]["title"],
                  style: const TextStyle(
                    fontSize: 16.0,
                    //color: Colors.black,
                  ),
                ),
                value: checkListItems[index]["value"],
                onChanged: (value) {
                  //-----------------------------------------------------------------------------------------------------

                  setState(() {
                    checkListItems[index]["value"] = value;
                    if (value == true) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.custom,
                        barrierDismissible: true,
                        confirmBtnText: 'Save',
                        cancelBtnText: 'Cancel',
                        widget: Column(
                          children: [
                            Text(
                              checkListItems[index]["title"],
                              style: const TextStyle(
                                  //color: Colors.white,
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.bold,
                                  //fontStyle: FontStyle.italic,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controllerCount,
                              decoration: InputDecoration(
                                hintText: 'Total Count',
                                prefixIcon: const Icon(
                                  Icons.pending_actions,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controllerCount.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controllerWeight,
                              decoration: InputDecoration(
                                hintText: 'Total Weight',
                                prefixIcon: const Icon(
                                  Icons.auto_delete,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controllerWeight.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // Weight = value;
                                // setState(() {
                                //   Weight = value;
                                //   //controllerCount.clear();
                                // });
                              },
                            ),
                          ],
                        ),
                        closeOnConfirmBtnTap: false,
                        onConfirmBtnTap: () async {
                          //-----------------------------------------------------------------------------------------------------

                          if (controllerCount.text.isEmpty ||
                              controllerWeight.text.isEmpty) {
                            setState(() {
                              checkListItems[index]["value"] = false;
                            });
                          } else {
                            itemCounts = int.parse(controllerCount.text);
                            itemWeight = double.parse(controllerWeight.text);
                          }
                          combinedCheckboxValue =
                              '${checkListItems[index]["title"]}, \n$itemCounts Items $itemWeight kgs ';

                          combinedCheckboxValueSelected =
                              '${checkListItems[index]["title"]}, $itemCounts Items $itemWeight kgs ';

                          if (controllerCount.text.isEmpty ||
                              controllerWeight.text.isEmpty) {
                          } else {
                            setState(() {
                              checkListItems[index]
                                  ["title"] = checkListItems[index][
                                      '${checkListItems.indexWhere((item) => item["title"] == checkListItems[index]["title"])}'] =
                                  combinedCheckboxValue;

                              multipleSelected
                                  .add(combinedCheckboxValueSelected);
                            });
                          }
                          controllerCount.text = '';
                          controllerWeight.text = '';

                          Navigator.of(context).pop();
                        },
                      );
                    } else {
                      multipleSelected.remove(combinedCheckboxValueSelected);

                      var splitag = checkListItems[index]["title"].split(",");
                      itemName = splitag[0];

                      checkListItems.isNotEmpty
                          ? checkListItems
                              .removeAt(index) //removes the item at index 1
                          : null;
                      checkListItems.insert(index, {
                        "value": false,
                        "title": itemName,
                        "count": itemCounts,
                        "weight": itemWeight,
                      });
                    }
                  });

                  //-----------------------------------------------------------------------------------------------------
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
              );
            },
          )),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: changeColor ? Colors.grey : Colors.blue,
                    ),
                    onPressed: () {
                      if (multipleSelected.isNotEmpty &&
                          _save_button_status != 'Saved') {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'Are your sure you want to save this data.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Yes');
                                  if (_save_button_status == 'Save') {
                                    Future.delayed(Duration.zero, () async {
                                      loader();
                                    });

                                    changeColor = !changeColor;

                                    for (int i = 0;
                                        i < multipleSelected.length;
                                        i++) {
                                      splitagItem =
                                          multipleSelected[i].split(",");
                                      splitagValues = splitagItem[1].split(" ");
                                      splitagZone = widget.zone.split(" > ");

                                      addData();
                                      // print(
                                      //     '$currentDate , ${widget.countyID} , ${widget.beachID} , ${widget.transectID} , '
                                      //         '${widget.startDryGPS} , ${widget.centerGPS} , ${widget.endWetGPS} , '
                                      //         '${splitagZone[1]} , ${widget.selectedCategoryTag} , ${splitagItem[0]} , '
                                      //         '${splitagValues[1]} , ${splitagValues[3]}');
                                    }

                                    setState(() {
                                      _save_button_status = 'Saved';
                                    });
                                  }
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        if (_save_button_status != 'Saved') {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Information'),
                              content: const Text('Your item list is empty.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Information'),
                              content: const Text('Already Saved.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text('$_save_button_status'),
                  ),
                ),
                Visibility(
                  visible: !changeColor,
                  child: const SizedBox(
                    width: 20,
                  ),
                ),
                Visibility(
                  visible: !changeColor,
                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _scrollDown();

                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.custom,
                          barrierDismissible: true,
                          confirmBtnText: 'Add to list',
                          cancelBtnText: 'Cancel',
                          widget: Column(
                            children: [
                              const Text(
                                'Enter item name',
                                style: TextStyle(
                                    //color: Colors.white,
                                    fontFamily: 'ProximaNova',
                                    fontWeight: FontWeight.bold,
                                    //fontStyle: FontStyle.italic,
                                    fontSize: 20.0),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Autocomplete<String>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text == '') {
                                    return const Iterable<String>.empty();
                                  }

                                  setState(() {
                                    _iteminputString = textEditingValue.text;
                                  });

                                  return _kOptionsItems.where((String option) {
                                    return option.toTitleCase().contains(
                                        textEditingValue.text.toTitleCase());
                                  });
                                },
                                fieldViewBuilder: ((context,
                                    textEditingController,
                                    focusNode,
                                    onFieldSubmitted) {
                                  return TextFormField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    onEditingComplete: onFieldSubmitted,
                                    decoration: InputDecoration(
                                      hintText: 'Item Name',
                                      prefixIcon: const Icon(
                                        Icons.pending_actions,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          textEditingController.clear();
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          closeOnConfirmBtnTap: false,
                          onConfirmBtnTap: () async {
                            if (_iteminputString == null) {
                            } else {
                              //-----------------------------------------------------------------------------------------------------
                              setState(() {
                                checkListItems.insert(checkListItems.length, {
                                  "value": false,
                                  "title": _iteminputString,
                                  "Category": widget.selectedCategoryTag,
                                  // "weight": itemWeight,
                                });

                                _iteminputString = '';
                              });
                            }
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      child: const Text('Add Item'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
