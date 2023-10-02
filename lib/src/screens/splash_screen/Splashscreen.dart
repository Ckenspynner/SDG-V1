import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/screens/county/countydetails.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 60),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    const CountyDetails()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkBlue,
        //child:FlutterLogo(size:MediaQuery.of(context).size.height)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
              size: 70,
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
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
