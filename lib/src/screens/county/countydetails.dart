import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';
import 'dart:convert';

import 'package:sdg/src/screens/crud/editdata.dart';
import 'package:sdg/src/screens/transect/transectdetails.dart';

class CountyDetails extends StatefulWidget {
  const CountyDetails({Key? key}) : super(key: key);

  @override
  State<CountyDetails> createState() => _CountyDetailsState();
}

class _CountyDetailsState extends State<CountyDetails> {
  // final List<String> county1 = <String>[];
  // final List<String> beachID = <String>[];

  // TextEditingController countyController = TextEditingController();
  // TextEditingController beachIdController = TextEditingController();

  //Dropdown parameters definition
  // List<DropdownMenuItem<String>> get dropdownCountyItems {
  //   List<DropdownMenuItem<String>> menuItems = [
  //     const DropdownMenuItem(
  //         value: "Select County", child: Text("Select County")),
  //     const DropdownMenuItem(
  //         value: "Mombasa County", child: Text("Mombasa County")),
  //     const DropdownMenuItem(
  //         value: "Kilifi County", child: Text("Kilifi County")),
  //     const DropdownMenuItem(value: "Lamu County", child: Text("Lamu County")),
  //     const DropdownMenuItem(
  //         value: "Kwale County", child: Text("Kwale County")),
  //   ];
  //   return menuItems;
  // }

  //Dropdown parameters definition
  // List<DropdownMenuItem<String>> get dropdownBeachItems {
  //   print(selectedCounty);
  //   switch (selectedCounty) {
  //     case 'Mombasa County':
  //       List<DropdownMenuItem<String>> menuItems_1 = [
  //         const DropdownMenuItem(
  //             value: "Select Beach", child: Text("Select Beach")),
  //         const DropdownMenuItem(
  //             value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //         const DropdownMenuItem(
  //             value: "Gazi Beach", child: Text("Gazi Beach")),
  //         const DropdownMenuItem(
  //             value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //         const DropdownMenuItem(
  //             value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //         const DropdownMenuItem(
  //             value: "Nyali Beach", child: Text("Nyali Beach")),
  //         const DropdownMenuItem(
  //             value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
  //         const DropdownMenuItem(
  //             value: "Bandarini Beach", child: Text("Bandarini Beach")),
  //         const DropdownMenuItem(
  //             value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
  //         const DropdownMenuItem(
  //             value: "Baobab Beach", child: Text("Baobab Beach")),
  //         const DropdownMenuItem(
  //             value: "Coba cabbana Beach", child: Text("Coba cabbana Beach")),
  //         const DropdownMenuItem(
  //             value: "Gazi Beach", child: Text("Gazi Beach")),
  //         const DropdownMenuItem(
  //             value: "Domoni Beach", child: Text("Domoni Beach")),
  //         const DropdownMenuItem(
  //             value: "Forty Thieves Beach", child: Text("Forty Thieves Beach")),
  //         const DropdownMenuItem(
  //             value: "Nyali Beach", child: Text("Nyali Beach")),
  //         const DropdownMenuItem(
  //             value: "Gazi Beach", child: Text("Gazi Beach")),
  //         const DropdownMenuItem(
  //             value: "Kuruwitu Beach", child: Text("Kuruwitu Beach")),
  //         const DropdownMenuItem(
  //             value: "Kwa Ngala Beach", child: Text("Kwa Ngala Beach")),
  //         const DropdownMenuItem(
  //             value: "Maasai Beach", child: Text("Maasai Beach")),
  //         const DropdownMenuItem(
  //             value: "Maua Watamu Beach", child: Text("Maua Watamu Beach")),
  //         const DropdownMenuItem(
  //             value: "Gazi Beach", child: Text("Gazi Beach")),
  //         const DropdownMenuItem(
  //             value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //         const DropdownMenuItem(
  //             value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //         const DropdownMenuItem(
  //             value: "Nyali Beach", child: Text("Nyali Beach")),
  //         const DropdownMenuItem(
  //             value: "Mkwiro Beach", child: Text("Mkwiro Beach")),
  //         const DropdownMenuItem(
  //             value: "Msambweni Beach", child: Text("Msambweni Beach")),
  //         const DropdownMenuItem(
  //             value: "Nyali Beach", child: Text("Nyali Beach")),
  //         const DropdownMenuItem(
  //             value: "Pirates Beach", child: Text("Pirates Beach")),
  //         const DropdownMenuItem(
  //             value: "R. Sabaki Beach", child: Text("R. Sabaki Beach")),
  //         const DropdownMenuItem(
  //             value: "Gazi Beach", child: Text("Gazi Beach")),
  //         const DropdownMenuItem(
  //             value: "Scorpio Beach", child: Text("Scorpio Beach")),
  //         const DropdownMenuItem(
  //             value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //         const DropdownMenuItem(
  //             value: "Nyali Beach", child: Text("Nyali Beach")),
  //         const DropdownMenuItem(
  //             value: "Vanga Beach", child: Text("Vanga Beach")),
  //         const DropdownMenuItem(
  //             value: "Vidazini Beach", child: Text("Vidazini Beach")),
  //         const DropdownMenuItem(
  //             value: "Wasini Beach", child: Text("Wasini Beach")),
  //         const DropdownMenuItem(
  //             value: "Wiyoni Beach", child: Text("Wiyoni Beach")),
  //       ];
  //       return menuItems_1;
  //
  //     default:
  //       List<DropdownMenuItem<String>> menuItems_1 = [
  //         const DropdownMenuItem(
  //             value: "Select Beach", child: Text("Select Beach")),
  //       ];
  //       return menuItems_1;
  //   }
  //
  //   // if (selectedCounty == 'Mombasa County') {
  //   //   List<DropdownMenuItem<String>> menuItems_1 = [
  //   //     const DropdownMenuItem(
  //   //         value: "Select Beach", child: Text("Select Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Bandarini Beach", child: Text("Bandarini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Baobab Beach", child: Text("Baobab Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Coba cabbana Beach", child: Text("Coba cabbana Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Domoni Beach", child: Text("Domoni Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Forty Thieves Beach", child: Text("Forty Thieves Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kuruwitu Beach", child: Text("Kuruwitu Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kwa Ngala Beach", child: Text("Kwa Ngala Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maasai Beach", child: Text("Maasai Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maua Watamu Beach", child: Text("Maua Watamu Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkwiro Beach", child: Text("Mkwiro Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Msambweni Beach", child: Text("Msambweni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Pirates Beach", child: Text("Pirates Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "R. Sabaki Beach", child: Text("R. Sabaki Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Scorpio Beach", child: Text("Scorpio Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Vanga Beach", child: Text("Vanga Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Vidazini Beach", child: Text("Vidazini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wasini Beach", child: Text("Wasini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wiyoni Beach", child: Text("Wiyoni Beach")),
  //   //   ];
  //   //   return menuItems_1;
  //   // }
  //   // if (selectedCounty == 'Kilifi County') {
  //   //   List<DropdownMenuItem<String>> menuItems_2 = [
  //   //     const DropdownMenuItem(
  //   //         value: "Select Beach", child: Text("Select Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Bandarini Beach", child: Text("Bandarini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Baobab Beach", child: Text("Baobab Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Coba cabbana Beach", child: Text("Coba cabbana Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Domoni Beach", child: Text("Domoni Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Forty Thieves Beach", child: Text("Forty Thieves Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kuruwitu Beach", child: Text("Kuruwitu Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kwa Ngala Beach", child: Text("Kwa Ngala Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maasai Beach", child: Text("Maasai Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maua Watamu Beach", child: Text("Maua Watamu Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkwiro Beach", child: Text("Mkwiro Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Msambweni Beach", child: Text("Msambweni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Pirates Beach", child: Text("Pirates Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "R. Sabaki Beach", child: Text("R. Sabaki Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Scorpio Beach", child: Text("Scorpio Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Vanga Beach", child: Text("Vanga Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Vidazini Beach", child: Text("Vidazini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wasini Beach", child: Text("Wasini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wiyoni Beach", child: Text("Wiyoni Beach")),
  //   //   ];
  //   //   return menuItems_2;
  //   // }
  //   // if (selectedCounty == 'Lamu County') {
  //   //   List<DropdownMenuItem<String>> menuItems_3 = [
  //   //     const DropdownMenuItem(
  //   //         value: "Select Beach", child: Text("Select Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Bandarini Beach", child: Text("Bandarini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Baobab Beach", child: Text("Baobab Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Coba cabbana Beach", child: Text("Coba cabbana Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Domoni Beach", child: Text("Domoni Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Forty Thieves Beach", child: Text("Forty Thieves Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kuruwitu Beach", child: Text("Kuruwitu Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kwa Ngala Beach", child: Text("Kwa Ngala Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maasai Beach", child: Text("Maasai Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maua Watamu Beach", child: Text("Maua Watamu Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkwiro Beach", child: Text("Mkwiro Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Msambweni Beach", child: Text("Msambweni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Pirates Beach", child: Text("Pirates Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "R. Sabaki Beach", child: Text("R. Sabaki Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Scorpio Beach", child: Text("Scorpio Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Vanga Beach", child: Text("Vanga Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Vidazini Beach", child: Text("Vidazini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wasini Beach", child: Text("Wasini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wiyoni Beach", child: Text("Wiyoni Beach")),
  //   //   ];
  //   //   return menuItems_3;
  //   // }
  //   // if (selectedCounty == 'Kwale County') {
  //   //   List<DropdownMenuItem<String>> menuItems_4 = [
  //   //     const DropdownMenuItem(
  //   //         value: "Select Beach", child: Text("Select Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Bandarini Beach", child: Text("Bandarini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Baobab Beach", child: Text("Baobab Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Coba cabbana Beach", child: Text("Coba cabbana Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Domoni Beach", child: Text("Domoni Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Forty Thieves Beach", child: Text("Forty Thieves Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kuruwitu Beach", child: Text("Kuruwitu Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Kwa Ngala Beach", child: Text("Kwa Ngala Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maasai Beach", child: Text("Maasai Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Maua Watamu Beach", child: Text("Maua Watamu Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkomani Beach", child: Text("Mkomani Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Mkwiro Beach", child: Text("Mkwiro Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Msambweni Beach", child: Text("Msambweni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Pirates Beach", child: Text("Pirates Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "R. Sabaki Beach", child: Text("R. Sabaki Beach")),
  //   //     const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Scorpio Beach", child: Text("Scorpio Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Shimoni Beach", child: Text("Shimoni Beach")),
  //   //     const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
  //   //     const DropdownMenuItem(value: "Vanga Beach", child: Text("Vanga Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Vidazini Beach", child: Text("Vidazini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wasini Beach", child: Text("Wasini Beach")),
  //   //     const DropdownMenuItem(
  //   //         value: "Wiyoni Beach", child: Text("Wiyoni Beach")),
  //   //   ];
  //   //   return menuItems_4;
  //   // }
  // }

  // This function is triggered when the floating buttion is pressed
  // void _show(BuildContext ctx) {
  //   //print(selectedBeach_dropdown);
  //   showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
  //     ),
  //     isScrollControlled: true,
  //     elevation: 5,
  //     context: ctx,
  //     builder: (ctx) => Padding(
  //         padding: EdgeInsets.only(
  //             top: 25,
  //             left: 25,
  //             right: 25,
  //             bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
  //         child: Form(
  //           key: _dropdownFormKey,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               const Center(
  //                   child: Text(
  //                 'Beach Details',
  //                 style: TextStyle(
  //                     //color: Colors.white,
  //                     fontFamily: 'ProximaNova',
  //                     fontWeight: FontWeight.bold,
  //                     //fontStyle: FontStyle.italic,
  //                     fontSize: 20.0),
  //               )),
  //               const SizedBox(
  //                 height: 30,
  //               ),
  //               // DropdownButtonFormField(
  //               //     decoration: InputDecoration(
  //               //       enabledBorder: OutlineInputBorder(
  //               //         borderSide:
  //               //             const BorderSide(color: Colors.blue, width: 2),
  //               //         borderRadius: BorderRadius.circular(20),
  //               //       ),
  //               //       border: OutlineInputBorder(
  //               //         borderSide:
  //               //             const BorderSide(color: Colors.blue, width: 2),
  //               //         borderRadius: BorderRadius.circular(20),
  //               //       ),
  //               //       filled: true,
  //               //       fillColor: Colors.transparent,
  //               //     ),
  //               //     validator: (value) =>
  //               //         value == "Select County" ? "Select a county" : null,
  //               //     //dropdownColor: Colors.blueAccent,
  //               //     value: selectedCounty,
  //               //     icon: const Icon(Icons.keyboard_arrow_down),
  //               //     onChanged: (String? newValue) {
  //               //       setState(() {
  //               //         selectedCounty = newValue!;
  //               //       });
  //               //     },
  //               //     items: dropdownCountyItems),
  //               DropdownButtonFormField<String>(
  //                 isExpanded: true,
  //                 decoration: InputDecoration(
  //                   enabledBorder: OutlineInputBorder(
  //                     borderSide:
  //                         const BorderSide(color: Colors.blue, width: 2),
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   border: OutlineInputBorder(
  //                     borderSide:
  //                         const BorderSide(color: Colors.blue, width: 2),
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   filled: true,
  //                   fillColor: Colors.transparent,
  //                 ),
  //                 validator: (value) =>
  //                     value == "Select County" ? "Select a county" : null,
  //                 icon: const Icon(Icons.keyboard_arrow_down),
  //                 items:
  //                     selectedCounty_dropdown.map((String dropDownStringItem) {
  //                   return DropdownMenuItem<String>(
  //                     value: dropDownStringItem,
  //                     child: Text(dropDownStringItem),
  //                   );
  //                 }).toList(),
  //                 onChanged: (value) {
  //                   _onSelectedState(value!);
  //                 },
  //                 value: selectedCounty,
  //               ),
  //               const SizedBox(
  //                 height: 30,
  //               ),
  //
  //               // DropdownButtonFormField(
  //               //     decoration: InputDecoration(
  //               //       enabledBorder: OutlineInputBorder(
  //               //         borderSide:
  //               //             const BorderSide(color: Colors.blue, width: 2),
  //               //         borderRadius: BorderRadius.circular(20),
  //               //       ),
  //               //       border: OutlineInputBorder(
  //               //         borderSide:
  //               //             const BorderSide(color: Colors.blue, width: 2),
  //               //         borderRadius: BorderRadius.circular(20),
  //               //       ),
  //               //       filled: true,
  //               //       fillColor: Colors.transparent,
  //               //     ),
  //               //     validator: (value) =>
  //               //         value == "Select Beach" ? "Select a beach" : null,
  //               //     //dropdownColor: Colors.blueAccent,
  //               //     value: selectedBeach,
  //               //     icon: const Icon(Icons.keyboard_arrow_down),
  //               //     onChanged: (String? newValue) {
  //               //       setState(() {
  //               //         selectedBeach = newValue!;
  //               //       });
  //               //     },
  //               //     items: dropdownBeachItems),
  //               _isLoading
  //                   ? const CircularProgressIndicator()
  //                   : DropdownButtonFormField<String>(
  //                       //isExpanded: true,
  //                       decoration: InputDecoration(
  //                         enabledBorder: OutlineInputBorder(
  //                           borderSide:
  //                               const BorderSide(color: Colors.blue, width: 2),
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                         border: OutlineInputBorder(
  //                           borderSide:
  //                               const BorderSide(color: Colors.blue, width: 2),
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                         filled: true,
  //                         fillColor: Colors.transparent,
  //                       ),
  //                       validator: (value) =>
  //                           value == "Select Beach" ? "Select a beach" : null,
  //                       icon: const Icon(Icons.keyboard_arrow_down),
  //                       items: selectedBeach_dropdown
  //                           .map((String dropDownStringItem) {
  //                         return DropdownMenuItem<String>(
  //                           value: dropDownStringItem,
  //                           child: Text(dropDownStringItem),
  //                         );
  //                       }).toList(),
  //                       // onChanged: (value) => print(value),
  //                       onChanged: (value) {
  //                         _onSelectedLGA(value!);
  //                       },
  //                       value: selectedBeach,
  //                     ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: ElevatedButton(
  //                         onPressed: () {
  //                           if (_dropdownFormKey.currentState!.validate()) {
  //                             //addItemToList();
  //                             //Add to Database
  //                             addData();
  //
  //                             // Future.delayed(Duration.zero, () async {
  //                             //   loader();
  //                             // });
  //
  //                             //valid flow
  //                             Navigator.pop(
  //                               context,
  //                               "This string will be passed back to the parent",
  //                             );
  //                             setState(() {
  //                               selectedCounty = "Select County";
  //                               selectedBeach = "Select Beach";
  //                             });
  //                           }
  //                         },
  //                         child: const Text('Submit')),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         )),
  //   );
  // }

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://$ipAddress/sdg/beach/getdata.php"));

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Beach Details'),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            //color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const CountyDetails(),
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.grey,
      //   onPressed: () {  },
      //   child: const Icon(Icons.add),
      //   //onPressed: () => _show(context),
      // ),

      body: FutureBuilder<List>(
        future: getData(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print('error');
          }
          if (snapshot.hasData) {
            return BeachItems(list: snapshot.data ?? []);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
      //home: const Text('data'),
    );
  }
}

class BeachItems extends StatefulWidget {
  List list;

  BeachItems({Key? key, required this.list}) : super(key: key);

  @override
  State<BeachItems> createState() => _BeachItemsState();
}

class _BeachItemsState extends State<BeachItems> {
  List<String> selectedCounty_dropdown = ["Select County"];
  List<String> selectedBeach_dropdown = ["Select Beach"];
  String selectedCounty = "Select County";
  String selectedBeach = "Select Beach";
  bool _isLoading = false;
  bool _toggleView = false;
  bool _toggletext = true;

  final _dropdownFormKey = GlobalKey<FormState>();

  final List<Map> _myJson_county = [
    {"county": "Select County"},
    {"county": "Mombasa County"},
    {"county": "Kilifi County"},
    {"county": "Kwale County"},
    {"county": "Lamu County"}
  ];

  final List<Map> _myJson_beach = [
    {"county": "Mombasa County", "beach": "Select Beach"},
    {"county": "Kilifi County", "beach": "Select Beach"},
    {"county": "Lamu County", "beach": "Select Beach"},
    {"county": "Kwale County", "beach": "Select Beach"},
    {'county': 'Kilifi County', 'beach': 'Baobab Beach'},
    {'county': 'Kilifi County', 'beach': 'Coba cabbana Beach'},
    {'county': 'Kilifi County', 'beach': 'Jetty Beach'},
    {'county': 'Kilifi County', 'beach': 'Kuruwitu  Beach'},
    {'county': 'Kilifi County', 'beach': 'Kwa Ngala  Beach'},
    {'county': 'Kilifi County', 'beach': 'Malindi Jetty Beach'},
    {'county': 'Kilifi County', 'beach': 'Maua watamu Beach'},
    {'county': 'Kilifi County', 'beach': 'R. Sabaki Beach'},
    {'county': 'Kilifi County', 'beach': 'Scorpio Beach'},
    {'county': 'Kilifi County', 'beach': 'Vidazini Beach'},
    {'county': 'Kwale County', 'beach': 'Forty Thieves Beach'},
    {'county': 'Kwale County', 'beach': 'Gazi  Beach'},
    {'county': 'Kwale County', 'beach': 'Mkwiro Beach'},
    {'county': 'Kwale County', 'beach': 'Msambweni Beach'},
    {'county': 'Kwale County', 'beach': 'Shimoni Beach'},
    {'county': 'Kwale County', 'beach': 'Tradewinds Beach'},
    {'county': 'Kwale County', 'beach': 'Vanga Beach'},
    {'county': 'Kwale County', 'beach': 'Wasini Beach'},
    {'county': 'Lamu County', 'beach': 'Domoni Beach'},
    {'county': 'Lamu County', 'beach': 'Wiyoni Beach'},
    {'county': 'Mombasa County', 'beach': 'Kenyatta  Beach'},
    {'county': 'Mombasa County', 'beach': 'Maasai Beach'},
    {'county': 'Mombasa County', 'beach': 'Mkomani  Beach'},
    {'county': 'Mombasa County', 'beach': 'Nyali Beach'},
    {'county': 'Mombasa County', 'beach': 'Pirates Beach'}
  ];

  @override
  void initState() {
    selectedCounty_dropdown = _myJson_county.map((Map map) {
      return map["county"].toString();
    }).toList();

    super.initState();
  }

  void _onSelectedState(String value) async {
    setState(() {
      selectedBeach = "Select Beach";
      selectedCounty = value;
      selectedBeach_dropdown = ["Select Beach"];
      _isLoading = true;
    });

    selectedBeach_dropdown = _myJson_beach
        .where((value) => value["county"] == selectedCounty)
        .map((value) {
      //print(value["beach"].toString());
      return value["beach"].toString();
    }).toList();

    setState(() {
      _isLoading = false;
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => selectedBeach = value);
    //print(selectedBeach_dropdown);
  }

  void addData() {
    var url = "http://$ipAddress/sdg/beach/adddata.php";
    http.post(Uri.parse(url), body: {
      'county': selectedCounty.toTitleCase(),
      'beach': selectedBeach.toTitleCase(),
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
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

  //Text('Press the + button to add a beach'),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.grey,
        backgroundColor: _toggleView ? Colors.blueAccent : Colors.grey,
        //child: const Icon(Icons.add),
        child: _toggleView ? const Icon(Icons.close) : const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _toggleView = !_toggleView;
            selectedCounty = "Select County";
            selectedBeach = "Select Beach";
          });
          //print(!_toggleView);
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            Visibility(
              visible: !_toggleView,
              child: Visibility(
                visible: !_toggleView
                    ? widget.list.isEmpty
                        ? true
                        : false
                    : widget.list.isEmpty
                        ? false
                        : true,
                child: const Expanded(
                  child: Center(
                    child: Text('Press the + button to add a beach'),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !_toggleView,
              child: Expanded(
                child: ListView.separated(
                  itemCount: widget.list == null ? 0 : widget.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        child: Center(
                            child: Text(
                          widget.list[widget.list.length - 1 - index]['beach']
                              .substring(0, 1),
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        )),
                      ),
                      title: Text(
                          widget.list[widget.list.length - 1 - index]['beach']),
                      subtitle: Text(widget.list[widget.list.length - 1 - index]
                          ['county']),
                      trailing: Wrap(
                        spacing: -16,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit_note),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Edit(
                                        list: widget.list,
                                        index: widget.list.length - 1 - index),
                                  ),
                                );
                              }),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Warning',
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  'Are you sure you want to delete \n${widget.list[widget.list.length - 1 - index]['beach']}',
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
                                                "http://$ipAddress/sdg/beach/deletedata.php";
                                            http.post(Uri.parse(url), body: {
                                              'id': widget.list[
                                                  widget.list.length -
                                                      1 -
                                                      index]['id'],
                                            });

                                            // Future.delayed(Duration.zero, () async {
                                            //   loader();
                                            // });

                                            Navigator.pop(context);
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const CountyDetails(),
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
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => TransectDetails(
                                countyTag:
                                    widget.list[widget.list.length - 1 - index]
                                        ['county'],
                                beachID:
                                    widget.list[widget.list.length - 1 - index]
                                        ['beach'])));
                        //print(list[list.length - 1 - index]['county']);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 0.5,
                      indent: 20,
                      endIndent: 20,
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: _toggleView,
              child: Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _dropdownFormKey,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
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
                            validator: (value) => value == "Select County"
                                ? "Select a county"
                                : null,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: selectedCounty_dropdown
                                .map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _onSelectedState(value!);
                            },
                            value: selectedCounty,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : DropdownButtonFormField<String>(
                                  isExpanded: true,
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
                                  validator: (value) => value == "Select Beach"
                                      ? "Select a beach"
                                      : null,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: selectedBeach_dropdown
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  // onChanged: (value) => print(value),
                                  onChanged: (value) {
                                    _onSelectedLGA(value!);
                                  },
                                  value: selectedBeach,
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_dropdownFormKey.currentState!
                                          .validate()) {
                                        //addItemToList();
                                        //Add to Database
                                        addData();

                                        Future.delayed(Duration.zero, () async {
                                          loader();
                                        });

                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const CountyDetails(),
                                          ),
                                        );
                                        // print(
                                        //     '$selectedCounty > $selectedBeach');

                                        //valid flow
                                        // Navigator.pop(
                                        //   context,
                                        //   "This string will be passed back to the parent",
                                        // );
                                        setState(() {
                                          selectedCounty = "Select County";
                                          selectedBeach = "Select Beach";
                                          _toggleView = !_toggleView;
                                        });
                                      }
                                    },
                                    child: const Text('Submit')),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 100,
                          // ),
                        ],
                      ),
                    ),
                  ),

                  // child: Column(
                  //     //mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [Text('data'),]
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //}
  }
}

// import 'package:flutter/material.dart';
// import 'package:sdg/src/screens/transect/transectdetails.dart';
//
// class CountyDetails extends StatefulWidget {
//   const CountyDetails({super.key});
//
//   @override
//   _CountyDetailsState createState() => _CountyDetailsState();
// }
//
// class _CountyDetailsState extends State<CountyDetails> {
//   final List<String> county = <String>[];
//   final List<String> beachID = <String>[];
//
//   TextEditingController countyController = TextEditingController();
//   TextEditingController beachIdController = TextEditingController();
//
//   String selectedCounty = "Select County";
//   String selectedBeach = "Select Beach";
//
//   final _dropdownFormKey = GlobalKey<FormState>();
//
//   void addItemToList() {
//     setState(() {
//       county.insert(0, selectedCounty); //countyController.text);
//       beachID.insert(0, selectedBeach);
//     });
//   }
//
//   //Dropdown parameters definition
//   List<DropdownMenuItem<String>> get dropdownCountyItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       const DropdownMenuItem(
//           value: "Select County", child: Text("Select County")),
//       const DropdownMenuItem(
//           value: "Mombasa County", child: Text("Mombasa County")),
//       const DropdownMenuItem(
//           value: "Kilifi County", child: Text("Kilifi County")),
//       const DropdownMenuItem(value: "Lamu County", child: Text("Lamu County")),
//     ];
//     return menuItems;
//   }
//
//   //Dropdown parameters definition
//   List<DropdownMenuItem<String>> get dropdownBeachItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       const DropdownMenuItem(
//           value: "Select Beach", child: Text("Select Beach")),
//       const DropdownMenuItem(
//           value: "Shimoni Beach", child: Text("Shimoni Beach")),
//       const DropdownMenuItem(value: "Gazi Beach", child: Text("Gazi Beach")),
//       const DropdownMenuItem(
//           value: "Tradewinds Beach", child: Text("Tradewinds Beach")),
//       const DropdownMenuItem(
//           value: "Mkomani Beach", child: Text("Mkomani Beach")),
//       const DropdownMenuItem(value: "Nyali Beach", child: Text("Nyali Beach")),
//       const DropdownMenuItem(
//           value: "Malindi Jetty Beach", child: Text("Malindi Jetty Beach")),
//       const DropdownMenuItem(
//           value: "Bandarini Beach", child: Text("Bandarini Beach")),
//       const DropdownMenuItem(
//           value: "Kijangwani Beach", child: Text("Kijangwani Beach")),
//     ];
//     return menuItems;
//   }
//
//   // This function is triggered when the floating buttion is pressed
//   void _show(BuildContext ctx) {
//     showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//       ),
//       isScrollControlled: true,
//       elevation: 5,
//       context: ctx,
//       builder: (ctx) => Padding(
//           padding: EdgeInsets.only(
//               top: 25,
//               left: 25,
//               right: 25,
//               bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
//           child: Form(
//             key: _dropdownFormKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Center(
//                     child: Text(
//                   'Transect Details',
//                   style: TextStyle(
//                       //color: Colors.white,
//                       fontFamily: 'ProximaNova',
//                       fontWeight: FontWeight.bold,
//                       //fontStyle: FontStyle.italic,
//                       fontSize: 20.0),
//                 )),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       filled: true,
//                       fillColor: Colors.transparent,
//                     ),
//                     validator: (value) =>
//                         value == "Select County" ? "Select a county" : null,
//                     //dropdownColor: Colors.blueAccent,
//                     value: selectedCounty,
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedCounty = newValue!;
//                       });
//                     },
//                     items: dropdownCountyItems),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       filled: true,
//                       fillColor: Colors.transparent,
//                     ),
//                     validator: (value) =>
//                         value == "Select Beach" ? "Select a beach" : null,
//                     //dropdownColor: Colors.blueAccent,
//                     value: selectedBeach,
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedBeach = newValue!;
//                       });
//                     },
//                     items: dropdownBeachItems),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                           onPressed: () {
//                             // addItemToList();
//                             // Navigator.pop(
//                             //   context,
//                             //   "This string will be passed back to the parent",
//                             // );
//                             // setState(() {
//                             //   selectedCounty = '';
//                             //   selectedBeach = '';
//                             // });
//
//                             if (_dropdownFormKey.currentState!.validate()) {
//                               addItemToList();
//                               //valid flow
//                               Navigator.pop(
//                                 context,
//                                 "This string will be passed back to the parent",
//                               );
//                               setState(() {
//                                 selectedCounty = "Select County";
//                                 selectedBeach = "Select Beach";
//                               });
//                             }
//                           },
//                           child: const Text('Submit')),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )),
//
//       // Column(
//       //   mainAxisSize: MainAxisSize.min,
//       //   crossAxisAlignment: CrossAxisAlignment.start,
//       //   children: [
//       //     const SizedBox(
//       //       height: 15,
//       //     ),
//       //     const Center(
//       //         child: Text(
//       //           'County Details',
//       //           style: TextStyle(
//       //             //color: Colors.white,
//       //               fontFamily: 'ProximaNova',
//       //               fontWeight: FontWeight.bold,
//       //               //fontStyle: FontStyle.italic,
//       //               fontSize: 20.0),
//       //         )),
//       //     const SizedBox(
//       //       height: 15,
//       //     ),
//       //     DropdownButtonFormField(
//       //         decoration: InputDecoration(
//       //           enabledBorder: OutlineInputBorder(
//       //             borderSide: const BorderSide(
//       //                 color: Colors.blue, width: 2),
//       //             borderRadius: BorderRadius.circular(20),
//       //           ),
//       //           border: OutlineInputBorder(
//       //             borderSide: const BorderSide(
//       //                 color: Colors.blue, width: 2),
//       //             borderRadius: BorderRadius.circular(20),
//       //           ),
//       //           filled: true,
//       //           fillColor: Colors.transparent,
//       //         ),
//       //         validator: (value) => value == "Select County"
//       //             ? "Select a transect"
//       //             : null,
//       //         dropdownColor: Colors.blueAccent,
//       //         value: selectedValue,
//       //         icon: const Icon(Icons.keyboard_arrow_down),
//       //         onChanged: (String? newValue) {
//       //           setState(() {
//       //             selectedValue = newValue!;
//       //           });
//       //         },
//       //         items: dropdownItems),
//       //     const SizedBox(
//       //       height: 30,
//       //     ),
//       //
//       //     const SizedBox(
//       //       height: 30,
//       //     ),
//       //     Row(
//       //       children: [
//       //         Expanded(
//       //           child: ElevatedButton(
//       //               onPressed: () {
//       //                 addItemToList();
//       //                 Navigator.pop(
//       //                   context,
//       //                   "This string will be passed back to the parent",
//       //                 );
//       //                 setState(() {
//       //                   selectedCounty = 'a';
//       //                   selectedBeach = 'a';
//       //                 });
//       //               },
//       //               child: const Text('Submit')),
//       //         ),
//       //       ],
//       //     )
//       //   ],
//       // ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Beach Details'),
//         ),
//
//         floatingActionButton: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               FloatingActionButton(
//                 heroTag: "btn1",
//                 backgroundColor: Colors.grey,
//                 onPressed: () {
//                   //...
//                 },
//                 child: PopupMenuButton(
//                   child: ClipRRect(
//
//                     borderRadius: BorderRadius.circular(100),
//                     child: Container(
//                       color: Colors.grey,
//                       child: const Icon(Icons.download),
//                     ),
//                   ),
//                   onSelected: (value) {
//                     if (value == "download") {
//                       // add desired output
//                     }else if(value == "brand"){
//                       // add desired output
//                     }else if(value == "count"){
//                       // add desired output
//                     }else if(value == "upload"){
//                       // add desired output
//                     }
//                   },
//                   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//
//                     const PopupMenuItem(
//                       value: "download",
//                       child: Row(
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.only(right: 8.0),
//                               child: Icon(Icons.download)
//                           ),
//                           Text(
//                             'Download from Server',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: "brand",
//                       child: Row(
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.only(right: 8.0),
//                               child: Icon(Icons.logout)
//                           ),
//                           Text(
//                             'Macro-Branding.xlxs',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: "count",
//                       child: Row(
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.only(right: 8.0),
//                               child: Icon(Icons.logout)
//                           ),
//                           Text(
//                             'Macro-Counts.xlxs',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: "upload",
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(right: 8.0),
//                             child: Icon(Icons.upload_file),
//                           ),
//                           Text(
//                             'Upload to Server',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               FloatingActionButton(
//                 heroTag: "btn2",
//                 backgroundColor: Colors.grey,
//                 child: const Icon(Icons.add),
//                 onPressed: () => _show(context),
//               ),
//             ]
//         ),
//         // The bottom sheet here
//
//         body: Column(children: <Widget>[
//           Expanded(
//               child: ListView.separated(
//             padding: const EdgeInsets.all(8),
//             itemCount: county.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 leading: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: Colors.grey,
//                   child: Center(
//                       child: Text(
//                     county[county.length - 1 - index].substring(0, 1),
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontFamily: 'ProximaNova',
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.white,
//                     ),
//                   )),
//                 ),
//                 title: Text(county[county.length - 1 - index]),
//                 subtitle: Text(beachID[beachID.length - 1 - index]),
//                 trailing: const Icon(Icons.more_vert),
//                 onTap: () {
//                   //print(county[county.length - 1 - index]);
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => TransectDetails(
//                           countyTag: county[county.length - 1 - index],
//                           beachID: beachID[beachID.length - 1 - index])));
//                 },
//               );
//             },
//             separatorBuilder: (context, index) {
//               return const Divider(
//                 thickness: 0.5,
//                 indent: 20,
//                 endIndent: 20,
//               );
//             },
//           ))
//         ]));
//   }
// }
