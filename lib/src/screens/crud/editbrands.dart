import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';

class EditBrand extends StatefulWidget {
  final String listItem;
  final int index;
  final String transect;
  final String zone;

  const EditBrand(
      {Key? key,
      required this.index,
      required this.listItem,
      required this.transect,
      required this.zone})
      : super(key: key);

  @override
  State<EditBrand> createState() => _EditState();
}

class _EditState extends State<EditBrand> {
  TextEditingController controllerCounty = TextEditingController();
  TextEditingController controllerBrandCount = TextEditingController();
  var splitagZone;

  void editData() {
    var url = "http://$ipAddress/sdg/brands/editdata.php";
    splitagZone = widget.zone.split(" > ");
    http.post(Uri.parse(url), body: {
      'Transect': widget.transect,
      'Zone': splitagZone[1],
      'Brand': widget.listItem,
      'Counts': controllerBrandCount.text,
    });
    //print(widget.transect+' ,'+splitagZone[1]+' ,'+widget.listItem+' ,'+controllerBrandCount.text);
  }

  var responsedata;
  bool _visible = false;

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://$ipAddress/sdg/brands/getdata.php"));

    // data response convert to object
    responsedata = jsonDecode(response.body);
    var splitagZone = widget.zone.split(" > ");
    for (int i = 0; i < responsedata.length; i++) {
      if (responsedata[i]['Brand'] == widget.listItem &&
          responsedata[i]['Transect'] == widget.transect &&
          responsedata[i]['Zone'] == splitagZone[1]) {
        _visible = !_visible;
        setState(() {
          controllerBrandCount.text = responsedata[i]['Counts'];
        });
      }
    }
    return json.decode(response.body);
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

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      getData();
    });
    controllerCounty = TextEditingController(text: widget.listItem);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit ${widget.listItem} Details'),
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
                      builder: (BuildContext context) => EditBrand(
                          listItem: widget.listItem,
                          index: widget.index,
                          transect: widget.transect,
                          zone: widget.zone),
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
            Visibility(
                visible: !_visible,
                child: const Expanded(
                    child: Center(child: Text('No editable record found')))),
            Visibility(
              visible: _visible,
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                    ),
                    TextField(
                      controller: controllerCounty,
                      decoration: const InputDecoration(
                        hintText: 'Enter County Name',
                        suffixIcon: Icon(Icons.branding_watermark),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: controllerBrandCount,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter Beach Name',
                        suffixIcon: Icon(Icons.numbers_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        editData();
                        Future.delayed(Duration.zero, () async {
                          loader();
                        });
                        Navigator.of(context).pop();
                      },
                      color: Colors.blueAccent,
                      child: const Text('Edit Data'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
