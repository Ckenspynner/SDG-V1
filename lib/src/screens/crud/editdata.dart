import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';
import 'package:sdg/src/screens/county/countydetails.dart';

import 'package:sdg/src/screens/crud/WampCrud.dart';

class Edit extends StatefulWidget {
  final List list;
  final int index;

  const Edit({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController controllerCounty = TextEditingController();
  TextEditingController controllerBeach = TextEditingController();

  void editData() {
    var url = "http://$ipAddress/sdg/beach/editdata.php";
    http.post(Uri.parse(url), body: {
      'id': widget.list[widget.index]['id'],
      'county': controllerCounty.text,
      'beach': controllerBeach.text,
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
  }

  @override
  void initState() {
    // TODO: implement initState

    controllerCounty =
        TextEditingController(text: widget.list[widget.index]['county']);
    controllerBeach =
        TextEditingController(text: widget.list[widget.index]['beach']);

    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const CountyDetails(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              //color: Colors.black,
            ),
          ),

        centerTitle: true,
        title: Text('Edit ${widget.list[widget.index]['beach']} Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
            ),
            TextField(
              controller: controllerCounty,
              decoration: const InputDecoration(hintText: 'Enter County Name'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: controllerBeach,
              decoration: const InputDecoration(hintText: 'Enter Beach Name'),
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const CountyDetails(),
                  ),
                );
              },
              color: Colors.blueAccent,
              child: const Text('Edit Data'),
            )
          ],
        ),
      ),
    );
  }
}
