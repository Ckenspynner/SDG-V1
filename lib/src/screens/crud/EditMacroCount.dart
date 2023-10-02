import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';
import 'package:sdg/src/screens/dataview/DataView.dart';

class EditMacroCount extends StatefulWidget {
  final String listItem;
  final int index;
  final String transect;
  final String zone;
  final String beachID;
  final String selectedCategoryTag;
  final String count;
  final String weight;

  const EditMacroCount({
    Key? key,
    required this.index,
    required this.listItem,
    required this.transect,
    required this.zone,
    required this.selectedCategoryTag,
    required this.beachID,
    required this.count,
    required this.weight,
  }) : super(key: key);

  @override
  State<EditMacroCount> createState() => _EditMacroCountState();
}

class _EditMacroCountState extends State<EditMacroCount> {
  TextEditingController controllerCounty = TextEditingController();
  TextEditingController controllerCategoryCount = TextEditingController();
  TextEditingController controllerCategoryWeight = TextEditingController();

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
  String? _brandinputString, _autoItems;
  var splitagZone;

  var responsedata;

  //bool _visible = false;

  var splitagListItem;

  void editData() {
    var url = "http://$ipAddress/sdg/counts/editdata.php";
    splitagZone = widget.zone.split(" > ");
    http.post(Uri.parse(url), body: {
      'Count': controllerCategoryCount.text,
      'Weight': controllerCategoryWeight.text,
      'Items': splitagListItem[0],
      'ItemsUpdate': '$_brandinputString'.toTitleCase(),
      'Transect': widget.transect,
      'Zone': splitagZone[1],
      'Category': widget.selectedCategoryTag,
    });
    //print(widget.transect+' ,'+splitagZone[1]+' ,'+splitagListItem[0]+' ,'+controllerCategoryCount.text+' ,'+controllerCategoryWeight.text);
  }

  // Future<List> getData() async {
  //   final response =
  //       await http.get(Uri.parse("http://$ipAddress/sdg/counts/getdata.php"));
  //
  // data response convert to object
  // responsedata = jsonDecode(response.body);
  //print(responsedata);
  // var splitagZone = widget.zone.split(" > ");
  //
  // for (int i = 0; i < responsedata.length; i++) {
  //   if (responsedata[i]['Items'] == splitagListItem[0] &&
  //       responsedata[i]['Transect'] == widget.transect &&
  //       responsedata[i]['Zone'] == splitagZone[1]) {
  //     _visible = !_visible;
  //     setState(() {
  //       controllerCategoryCount.text = responsedata[i]['Counts'];
  //       controllerCategoryWeight.text = responsedata[i]['Weight'];
  //     });
  //   }
  // }
  // return json.decode(response.body);
  // }

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

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero, () async {
    //   getData();
    // });
    splitagListItem = widget.listItem.split(",");
    controllerCounty = TextEditingController(text: splitagListItem[0]);
    controllerCategoryCount.text = widget.count;
    controllerCategoryWeight.text = widget.weight;
    _autoItems = widget.listItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit ${splitagListItem[0]} Details'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => DataViewsCounts(
                  transect: widget.transect,
                  beachID: widget.beachID,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            //color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => EditMacroCount(
                        listItem: widget.listItem,
                        index: widget.index,
                        transect: widget.transect,
                        zone: widget.zone,
                        selectedCategoryTag: widget.selectedCategoryTag,
                        beachID: widget.beachID,
                        count: widget.count,
                        weight: widget.weight,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
        child: Column(
          children: [
            // Visibility(
            //     visible: !_visible,
            //     child: const Expanded(
            //         child: Center(child: Text('No editable record found')))),
            // Visibility(
            //   visible: _visible,
            //   child:
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  // TextField(
                  //   controller: controllerCounty,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Enter Brand Name',
                  //     suffixIcon: Icon(Icons.branding_watermark),
                  //   ),
                  // ),

                  Autocomplete<String>(
                    initialValue: TextEditingValue(text: '$_autoItems'),
                    optionsBuilder:
                        (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }

                      setState(() {
                        _brandinputString = textEditingValue.text;
                      });

                      return _kOptionsItems.where((String option) {
                        return option.toTitleCase().contains(
                            textEditingValue.text.toTitleCase());
                      });
                    },
                    fieldViewBuilder: ((context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onEditingComplete: onFieldSubmitted,
                        decoration: InputDecoration(
                          hintText: 'Item Name',
                          suffixIcon: IconButton(
                            onPressed: () {
                              textEditingController.clear();
                            },
                            icon: const Icon(
                              Icons.branding_watermark,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: controllerCategoryCount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter Counts',
                      suffixIcon: Icon(Icons.numbers_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: controllerCategoryWeight,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter Weight',
                      suffixIcon: Icon(Icons.numbers_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        _brandinputString ??= widget.listItem;
                      });
                      editData();

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => DataViewsCounts(
                            transect: widget.transect,
                            beachID: widget.beachID,
                          ),
                        ),
                      );
                      //Navigator.of(context).pop();
                    },
                    color: Colors.blueAccent,
                    child: const Text('Edit Data'),
                  )
                ],
              ),
            ),
            //),
          ],
        ),
      ),
    );
  }
}
