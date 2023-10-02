import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:http/http.dart' as http;
import 'package:sdg/src/constants/text_strings.dart';

class BrandItems extends StatefulWidget {
  final String selectedBrandTag;
  final String selectedBrandTransectTag;
  final String countyID;
  final String beachID;
  final String zone;
  final String transect;

  const BrandItems({
    Key? key,
    required this.selectedBrandTag,
    required this.selectedBrandTransectTag,
    required this.countyID,
    required this.beachID,
    required this.zone,
    required this.transect,
  }) : super(key: key);

  @override
  State<BrandItems> createState() => _BrandItemsState();
}

class _BrandItemsState extends State<BrandItems> {
  var controllerCounts = TextEditingController();

  List multipleSelected = [];
  List checkListItems = [];
  List checkListItems11 = [
    {
      "id": 0,
      "value": false,
      "title": "PK",
      "item": "Food Wrapper",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 1,
      "value": false,
      "title": "Nuvita Bisquits",
      "item": "Food Wrapper",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Big daddy",
      "item": "Food Wrapper",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 3,
      "value": false,
      "title": "Sure",
      "item": "Condom",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 4,
      "value": false,
      "title": "Trust",
      "item": "Condom",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Coca Cola",
      "item": "Plastic bottles",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Azam",
      "item": "Plastic bottles",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Power Play",
      "item": "Plastic bottles",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Bata",
      "item": "Slippers",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Air Force",
      "item": "Shoes",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Guinness",
      "item": "Glass bottle",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Kingfisher",
      "item": "Glass bottle",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Tusker Cider",
      "item": "Glass bottle",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "White Cap",
      "item": "Glass bottle",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Panasonic",
      "item": "Radio",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "Tusker Can",
      "item": "Cans",
      "count": "0",
      "weight": "0",
    },
    {
      "id": 2,
      "value": false,
      "title": "White Cap",
      "item": "Cans",
      "count": "0",
      "weight": "0",
    },
  ];

  String combinedCheckboxValue = '', itemName = '';
  double itemWeight = 0.0;
  int itemCounts = 0;

  //Bottom sheet
  String selectedValue1 = "Select Type of Product";
  String selectedValue2 = "Select Type of Material";
  String selectedValue3 = "Select Type of Layer";
  final _dropdownFormKey = GlobalKey<FormState>();
  String brandItem = '';

  final ScrollController _controllerCheckboxTile = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controllerCheckboxTile.animateTo(
      _controllerCheckboxTile.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Type of Product",
          child: Text("Select Type of Product")),
      const DropdownMenuItem(value: "FP", child: Text("Food Product (FP)")),
      const DropdownMenuItem(
          value: "HP", child: Text("Household Product (HP)")),
      const DropdownMenuItem(value: "0", child: Text("Others (O)")),
      const DropdownMenuItem(value: "PC", child: Text("Personal Care (PC)")),
      const DropdownMenuItem(value: "SM", child: Text("Smoking Material (SM)")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Type of Material",
          child: Text("Select Type of Material")),
      const DropdownMenuItem(
          value: "HDPE", child: Text("High Density Polyethylene (HDPE)")),
      const DropdownMenuItem(
          value: "LDPE", child: Text("Low Density Polyethylene (LDPE)")),
      const DropdownMenuItem(value: "O", child: Text("Others (O)")),
      const DropdownMenuItem(
          value: "PET", child: Text("Polyethylene Terephthalate (PET)")),
      const DropdownMenuItem(value: "PP", child: Text("Polyethylene (PP)")),
      const DropdownMenuItem(value: "PVC", child: Text("Polyvinylchloride (PVC)")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Type of Layer", child: Text("Select Type of Layer")),
      const DropdownMenuItem(value: "SL", child: Text("Single Layer (SL)")),
      const DropdownMenuItem(value: "ML", child: Text("Multi Layer (ML)")),
    ];
    return menuItems;
  }

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

  static const List<String> _kOptionsBrands = <String>[
    'Brand',
    '210 Baking Flour',
    'Addafin Water',
    'Adistin',
    'Advance Shell Label',
    'Aerial Soap Wrappers',
    'Afia',
    'Afia Label',
    'Airtel Credit',
    'Airtel Scratch Cards',
    'Ajab Flour',
    'Akley Bread',
    'Alpha Vegetable Fat Label',
    'Amara Cocoa Butter',
    'Americana',
    'Aqua Clear Label',
    'Aqua Clear Seal',
    'Aquadrops',
    'Aquamist',
    'Ariel',
    'Arimis',
    'Atis Biscuits',
    'Austmat Kiu Label',
    'Austmat Kiu Seal',
    'Azam',
    'Azam Embe Label',
    'Azam Energy Drink',
    'Babycare',
    'Balozi',
    'Bamba Water Label',
    'Banana Wafers',
    'Bazuu Energy Drink',
    'Bazuu Energy Label',
    'Bedew Water',
    'Best Drink',
    'Bic',
    'Bidco Africa Ltd',
    'Bidco Seal',
    'Big Daddy',
    'Big Giant Lolipop',
    'Big Mama Lolipop',
    'Biodeal',
    'Bites Bites',
    'Black And White',
    'Blue Ice Vodka',
    'Blue Shoe Tecks',
    'Blueband',
    'Brava',
    'Brava Dark Coffee',
    'Brava Label',
    'Brava Orange',
    'Bravado Energy Drink',
    'Bravado Energy Drink Label',
    'Brookside',
    'Brookside Label',
    'Butter Hard Candy',
    'Butter Toast',
    'Candica',
    'Care',
    'Carolight',
    'Chioco Kiko',
    'Chioco Kiko Seal',
    'Chocolate',
    'Chocolate Cake',
    'Chokomo',
    'Chrome Vodka',
    'Ckl Chewing Gum',
    'Classic Bar Soap',
    'Classic Sour Cream',
    'Close Up Toothpaste',
    'Clovers Cocoa Powder',
    'Club Cola',
    'Club Lemon Lime',
    'Club Orange',
    'Club Pineapple',
    'Club Soda',
    'Club Soda Label',
    'Club Tangawizi',
    'Coca Cola Label',
    'Coca-Cola',
    'Coke',
    'Colgate Tube',
    'Cool Cow',
    'Cosmos',
    'Cough Drops',
    'Country Bakers',
    'County Bread',
    'County Water Label',
    'Creambell',
    'Creamy Yoghurt Lollipop',
    'Cribaz',
    'Daima Maziwa',
    'Daima Milk',
    'Daima Yogurt',
    'Dairy Milk',
    'Dairy Top',
    'Dallas Gin',
    'Dama Yogurt',
    'Dasani',
    'Dasani Label',
    'Delamere Yogurt Label',
    'Delight Bread',
    'Delight Yogurt Seal',
    'Delite Yoghurt',
    'Destiny',
    'Dexe Hair Dye',
    'Diclofenac',
    'Downy Concentrate',
    'Drinking Chocolate',
    'Dura Net',
    'Easy Clean Steelwool',
    'Eclairs',
    'Eden Tea',
    'Elgon Purified Water',
    'Emami Mentho Plus',
    'Emoji Sweet',
    'Energy Biscuits',
    'Equator Feel Good',
    'Equator Milk',
    'Eversprings',
    'Excel',
    'Excel Quencher',
    'Excel Quencher Label',
    'Exe Seal',
    'Exe Unga',
    'Exotic Afia Energy Drink',
    'Fahari Ya Kenya',
    'Family Biscuits',
    'Fanta',
    'Fanta Label',
    'Farasi Paper',
    'Farm Milk',
    'Farmily Milk',
    'Faxe',
    'Flora Tissue',
    'Fresh',
    'Fresh Chewing Gum',
    'Fresh Menthol',
    'Fresha Milk',
    'Fresha Yogurt',
    'Fresha Yogurt Label',
    'Fruit Dale Drink',
    'Fruit Drops',
    'Fruitvalle',
    'Fruitz Fruit Drink',
    'Fukukawa',
    'Geisha',
    'Giloil Sabuni',
    'Ginger Biscuits',
    'Glacier Water',
    'Glucose Biscuits',
    'Go Fruity',
    'Goal',
    'Goal Candy',
    'Gold Crown Milk',
    'Golden Lion',
    'Golden Lion Box',
    'Golden Lion Label',
    'Golden Malted Biscuits',
    'Gomba',
    'Goodie Bakers Biscuits',
    'GracieS Yogurt',
    'Grants',
    'Guarana',
    'Guinness',
    'Halal Corned Beef Label',
    'Happy Happy Biscuits',
    'Hill Milk Packet',
    'Hola Energy',
    'Hot Cakes',
    'Hunters Choice',
    'Ice Cube Drinking Water',
    'Ice Lolly',
    'Ice Pop',
    'Ice Springs',
    'Icy Cool Spring Water',
    'Imperia Leather Soap',
    'Indomie',
    'Inspaya Water',
    'Jaja',
    'Janus',
    'Jekof Syrup',
    'Jianxing',
    'Juicy Fruit',
    'Jumbo Dairyland',
    'Jumbo Water Label',
    'Jus4Ever',
    'Kabazi Drinking Water Label',
    'Kaluma Strong',
    'Kane Extra',
    'Kcc Fresh Milk',
    'Kcc Mala',
    'Kcc Maziwa',
    'Kenchic Chicken',
    'Kensalt',
    'Kenya Tomato Paste',
    'Kenya Yetu',
    'Keringet',
    'Ketepa Tea',
    'Kevian',
    'Kevian Bottle Cap',
    'Kevian Lable',
    'Ki Sweets',
    'Kibos Sugar',
    'Kibuyu',
    'Kibuyu Bar Soap',
    'Kibuyu Soap',
    'Kibuyu Soap Wrapper',
    'Kifaru',
    'Kik Boxxer Lollipop',
    'Kinangop Milk',
    'Kinangop Yogurt',
    'Kinangop Yogurt Seal',
    'Kiu Water Label',
    'Kiu Water Seal',
    'Kiyindi Landing Site',
    'Kleensoft Detergent',
    'Koh Kubwa',
    'Kol Chilli Sauce',
    'Kol Water',
    'Konyagi',
    'Korie Rice',
    'Krest',
    'Krest Label',
    'Kristal',
    'Kristal Aqua',
    'Krystal Aqua Seal',
    'KSL Sweets',
    'Lab',
    'Lacheka 2T Oil',
    'Lanzo Soap',
    'Lato Milk',
    'Lit Mint Heaven',
    'Loafa Bread',
    'Lolipop',
    'Lotta Cream',
    'Lotta Toffee Sweets',
    'Lotus Flour',
    'Lucky Flavoured Drink',
    'Lyons Ice Lolly',
    'Maccoffee',
    'Maji Safi',
    'Makiti Bread',
    'Mall Mall Cigarettes Packet',
    'Malted Milk Biscuits',
    'Manji',
    'Manji Wafers',
    'Mara Moja',
    'Mara Sugar',
    'Marcella Bread',
    'Marie Biscuits',
    'Maruti Rice',
    'Masafi Water',
    'Mayers Water',
    'Maziwa',
    'Maziwa Lala',
    'Melvin Tangawizi',
    'Menengai Bar Soap',
    'Menengai Cream Washing Bar',
    'Menengai Oil Seal',
    'Mentho Plus',
    'Mfalme Ugali',
    'Mile Bathing Soap',
    'Milk Biscuits',
    'Milk Power',
    'Milk Power Biscuits',
    'Milk Sweets',
    'Milk Toffee',
    'Milkees',
    'Milkies Clown',
    'Milkman Whole Milk',
    'Milkpop',
    'Milkstar',
    'Mill Sugar',
    'Millwhite Sugar',
    'Minute Maid',
    'Minute Maid Label',
    'Mirinda',
    'Misomi Drink Powder',
    'Moisten Cool',
    'Mooz Maziwa',
    'Mount Kenya Milk',
    'Movit Jelly',
    'Mr BerryS Juice Drops',
    'Mr Twista',
    'Mr Twista Label',
    'Msafi',
    'Muguka Sweet',
    'Mwea Pishori',
    'Naivas Bread',
    'Ndhiwa Sugar',
    'Ndovu Baking Flour',
    'Ndume Bar Soap',
    'Ndume Cream',
    'Ndume Soap Wrappers',
    'Ndume Washing Powder',
    'Nescafe Classic',
    'Ngarisha Steelwool',
    'Nice Biscuits',
    'Nice One Washing Powder',
    'Njoo Njema Cake',
    'Njoro Cool Waters',
    'Njugu Karanga',
    'Novida Schweeps',
    'Nureen Pasta',
    'Nuvita  Biscuits',
    'Old Farm Tea',
    'Omo',
    'Orie Biscuits',
    'Orle Glucose Biscuits',
    'Out Of Africa Cashews',
    'Oven Fresh Bread',
    'P&G Water Purifier',
    'Pan Masala',
    'Panga Bar Soap',
    'Parle Flavoured Cookies',
    'Parle Ginger Biscuits',
    'Parle Kreams Biscuits',
    'Parle Nice',
    'Parle Orle',
    'Pascha',
    'Patco',
    'Patco Mint',
    'Peptang Tomato Paste',
    'Piivale Drinking Water',
    'Piivale Label',
    'Piivale Seal',
    'Pilipili Candy',
    'Pilipili Kohoa',
    'Pilsner',
    'Pipi Masala',
    'Pipi Maziwa',
    'Pipi Siagi',
    'PK',
    'Planet Aqua Label',
    'Planet Aqua Seal',
    'Planet Orange',
    'Play Energy Drink',
    'Please Replace Cup',
    'Popco Citrus Fresh',
    'Potato Ketchup',
    'Power Loaf',
    'Power Pop Mint Candy',
    'Predator Energy Drink',
    'Predator Energy Label',
    'Predator Energy Seal',
    'Premium Fresh Milk',
    'Pure Water',
    'Pvc Tape',
    'Q -Drops Pet',
    'Qua Water',
    'Quecher Label',
    'Radiant Hair Spray',
    'Raha Cocoa',
    'Raha Drinking Chocolate',
    'Rebound',
    'Redcat',
    'Relcer Gel',
    'Replace Cap',
    'Reviera Drinking Water',
    'Rich Bake Bread',
    'Riham Cap',
    'Riham Drink Label',
    'Ringoz',
    'Roosters',
    'Roth ManS',
    'Royco Cubes',
    'Royco Mchuzi Mix',
    'Rusf Supplementary Food',
    'Sabuni Bar Soap',
    'Saf Instant',
    'Safari King Water',
    'Safari Lemonade',
    'Safari Lemonade Label',
    'Safaricom Credit',
    'Safi Seal',
    'Sawa Bathing Soap',
    'Sawa Hotel Soap',
    'Sawa Soap Wrappers',
    'Schweppes Novida',
    'Schweppes Novida Label',
    'Shell Advance 2T Oil',
    'Sifa Toilet Paper',
    'Simba Energy Drink',
    'Simba Energy Drink Seal',
    'Sinking Ball Point Pen',
    'Sky View Carbonated Drink',
    'Smart Bites Cake',
    'Smirnoff Ice',
    'Smirnoff Vodka',
    'Smokies',
    'Snap',
    'Softcare Sanitary Towel',
    'Sokoni Steelwool',
    'Somo Cooking Oil',
    'Sona Moja',
    'Sossi',
    'Special Gomba Bubble Gum',
    'Spring Montagne',
    'Sprite',
    'Sprite Label',
    'Star Vodka',
    'Steam Energy Drink',
    'Steam Energy Drink Label',
    'Steam Energy Label',
    'Stoney Tangawizi',
    'Sudso Soap',
    'Sunbest Bread',
    'Sunlight',
    'Sunsalt',
    'Sunveat Ginger biscuits',
    'Supa Loaf',
    'Super Cereal',
    'Super Drink Orange',
    'Supermatch Cigarette',
    'Superstar Lolipop',
    'Sure Condom',
    'Sweet Maziwa',
    'Taifa Milk',
    'Tamtam Tomato Sauce',
    'Teabag',
    'Teepee Toothpick',
    'T-Guard Toothpaste',
    'Top Chips',
    'Topex Bleach',
    'Topnut Peanut',
    'Toss Detergent',
    'Toss Wrapper',
    'Total Energies',
    'Total Energies oil',
    'Total Energies oil label',
    'Total Hi Perf Oil Label',
    'Tower Bar Soap',
    'Tropical Heat',
    'Tropical Mint',
    'Tropical Mint Lolipop',
    'Tropical Mint Sweet',
    'Trufoods',
    'Tulasha Spring Water Label',
    'Tulasha Water',
    'Tusker',
    'Tusker Cider',
    'Tusker Lager',
    'Tusker Light Metal Can',
    'Tusker Lite',
    'Tutti Fruity Lolipop',
    'Tuzo Whole Milk',
    'Tuzo Yogurt',
    'Twisty Mint',
    'Two Springs',
    'U-Fresh Label',
    'Ukwaju Candy',
    'Umoja',
    'Umoja Ni Tamu Wheat Flour',
    'Urban Bites Crips',
    'Ushindi Soap',
    'Valon',
    'Vaseline Blueseal',
    'Viceroy',
    'Wet Wipes',
    'Wetlands Springs',
    'White Bread',
    'White Candica Candy',
    'White Cap Metal Can',
    'White Pearl',
    'Whitecap',
    'Wosh Detergent',
    'Yamaha Genuine boat oil',
    'Yego Ginger Biscuits',
    'Zenta Washing Powder',
    'Zito Milk',
    'Zoe Naturals',
    'Zuummbaa',
  ];
  static const List<String> _kOptionsManufacturer = <String>[
    'Bidcoy Africa',
    'Ddafin Enterprises',
    'Cadila Healthcare',
    'Totalenergies',
    'Procter & Gamble',
    'Kevian K Ltd',
    'Airtel Kenya',
    'Grain Industries Limited',
    'Akley Bakers',
    'Kapa Oil Refineries Ltd',
    'Haco Industries Kenya Ltd',
    'Tamu Tamu Manufacturer',
    'Devyani Food Industries',
    'Aquadrops Pure Water Limited',
    'Aquamist Ltd',
    'Tri-Clover Industries Ltd',
    'Balaji Group Ea Ltd',
    'Austmat Ltd',
    'Bakhresa Food Products Ltd',
    'Mamujee Products',
    'East Africa Breweries Ltd',
    'Maji Asili Ltd',
    'Manji Food Industries Ltd',
    'Highlands Drink Ltd',
    'Bedew Beverages Ltd',
    'Kwal',
    'BidcoÿAfrica',
    'Mzuri Sweets Ltd',
    'Swibco Inc.',
    'Biodeal Laboratories Ltd',
    'KO Drops Ltd',
    'James Buchanan & Co',
    'Patiala Distillers',
    'Qingdao Three Stars Nailery',
    'Upfield Kenya Ltd',
    'Brava Food Industries Ltd',
    'Brookside Dairy Ltd',
    'Patco Industries',
    'Mini-Bakers Ltd',
    'Mombasa Polythene Bags Ltd',
    'Rinku Industries',
    'Angel Cosmetic Ltd Tanzanis',
    'Heemankshi Bakers Pvt Ltd India,Kwl Ltd Ke',
    'Africa Star Ltd',
    'Chokomo Investment Ltd',
    'Candy Kenya Ltd',
    'Kenafric Industries Ltd',
    'Happy Cow Ltd',
    'Unileaver',
    'Highlands Mineral Water Co. Ltd',
    'The Coca  Cola Company Ltd',
    'Colgate-Palmolove Co., Ltd',
    'Kenya Sweets Ltd',
    'KEMSA',
    'Tilja Investments',
    'Golden Raindrops Ltd',
    'County General Supplies',
    'Sameer Agriculture & Livestock Limited',
    'Norda Industries Ltd',
    'Excel Quencher Ltd',
    'Lakeside Dairy Ltd',
    'Zheng Hong Ltd',
    'Dessra  Ventures Ltd',
    'New Kenya Cooperative Creameries',
    'Destiny Springs Ltd',
    'Dexe',
    'Elam Pharma',
    'Modern Industries Company',
    'Safeflex International Ltd.',
    'Easy Clean Africa Ltd',
    'Karirani Tea Estates',
    'Milimani Beach Resort Ltd',
    'Supa Brewer Ltd',
    'Mogotio Fcs Ltd',
    'Compass Manufacturer Ltd',
    'Unga Group Plc',
    'Kenya Tea Packers Ltd',
    'Sunveat Foods Limited',
    'Match Masters Ltd',
    'Pat Farms',
    'Highland Creamers And Foods Ltd',
    'Royal Unibrew',
    'African Cotoon Industries',
    'Fresha Dairy Products',
    'Agri Pro-Pak Ltd',
    'The Furukawa Company',
    'Giloil Company Ltd',
    'Raa Limited Kenya',
    'Hydrolab Ltd',
    'Gold CrownÿBeverages (K) Ltd',
    'Golden Lion Co. Ltd',
    'Trufoods Ltd',
    'Demka Dairy',
    'Liquor Square Ltd',
    'Kenya Breweries Ltd',
    'Kenya Meat Commission',
    'Parle G',
    'Bamscos Cooperatives Union Kenya',
    'Maisha Beverages Ltd',
    'Home Bakers Ltd',
    'Kenya Wine Agencies Ltd',
    'Ice Cube Ltd',
    'Rok Ltd',
    'Ratco Ltd',
    'Generation Bottling Company Ltd',
    'Pz Cussons East Africa Ltd',
    'Salim Wazaran Kenya Co.Ltd',
    'Inspaya Investments',
    'Nutri Co Ltd',
    'Buffalo Millers Limited',
    'Woakes Pharma',
    'Jianxing',
    'Mars Wrigley Confectionery Kenya Ltd',
    'Glacier Products Ltd',
    'Water Life Bottlers Ltd',
    'Cartubox Industries E.A Ltd',
    'Orange Pharma Ltd',
    'The Kenya Cooperative Creameries',
    'Kenchic Ltd',
    'Kensalt Ltd',
    'Kenya Ochird Ltd',
    'Menengai Oil Refineries Ltd',
    'Mugalu Alitubera Fishing Company',
    'Keds Tanzania Company Ltd',
    'Njoro Canning Factory Ltd',
    'Joro Canning Factory Ltd',
    'Tanzania Distilleries Ltd',
    'Mw Millers',
    'Alsafa Industries',
    'Lab & Allied Ltd',
    'Global Enterprise',
    'Pearl Dairy Farms Ltd',
    'Bakeville Ltd',
    'Premier Flour Mills Ltd',
    'Sunshare Investment Co Ltd',
    'Food Empire Holdings',
    'Nzoia Water Company Services',
    'Makiti Ventures Ltd',
    'B.A.T Kenya',
    'Mjengo Ltd',
    'Sugar Company Ltd',
    'Marcella Food Company',
    'Maruti Traders',
    'Mayers Water',
    'Melvin Marsh International',
    'Label Converters Ltd',
    'Goodie Bakers',
    'Vital Tomosi Dairy',
    'Social Bites Ltd',
    'Sukari Industries Ltd',
    'Miranda East Africa Group',
    'Misomi',
    'Paramound Manufactures',
    'Meru Dairy Cooperative Union Ltd',
    'Movit Products Ltd',
    'N Ice Rice Millers',
    'Naivas Kenya',
    'Sugar Mills Kenya',
    'Mombasa Maize Millers',
    'Pwani Oils Product Ltd',
    'Nestle Kenya Ltd',
    'Napro Industries Ltd',
    'Kilimanjaro Biscuits Ltd',
    'Hillalium & Sons Ltd (Tanzania)',
    'Njoo Njema Bakers',
    'Njoro Cool Ltd',
    'Monty Kenya Limited',
    'Nustar',
    'Tea Talk Kenya Ltd',
    'Out Of Africa Lts',
    'Khetias Drops Ltd',
    'Diamond Industries Ltd',
    'Uplands Premium Dairies  Foods Ltd',
    'Premier Food Ltd',
    'Zagro',
    'Energy Beverages Llc Europe For Nairobi Bottlers Ltd',
    'Sademai Ltd',
    'Roc Industries,',
    'Equator Bottles Lts',
    'Lucky Dairies Ltd',
    'The Water Shop Naivasha Ltd',
    'Ningbo Dongsheng Adhesive Products Corporation',
    'Q Ventures Ltd Kenya',
    'EPZ Kenya',
    'Ramji Haridhai Devani Ltd',
    'Glenmark Pharmaceuticals (K) Ltd.',
    'Barakat Bakers Ltd',
    'Harris International Ltd',
    'Lukinya International Enterprises',
    'USAID',
    'Lesaffre',
    'Bounty Ltd',
    'Safaricom',
    'Skylark Ltd Kenya',
    'Www.Harissint.Com',
    'Vakenya Smart Bakers Ltd',
    'Smirnoff',
    'Farmers Choice',
    'Sunda Kenya Industrial Company',
    'Steelwool Africa Ltd',
    'Promasidor Kenya Ltd',
    'Spring Montagne',
    'Pez Distillers Ltd',
    'Fabricado',
    'Mayfair Holding Ltd',
    'Fabrique Par/Gbl',
    'Innolatex Ltd',
    'Tamtam Ltd',
    'Mbogo Valley Tea Factory',
    'Teepeey Brushy Manufacturersy Ltd',
    'Sunda Investments Company Limited',
    'Yemken Kenya Ltd',
    'Supersleek Ltd',
    'Topnut Enterprises Ltd Kenya',
    'Tulasha Enterprises',
    'Topserve Limited Kenya',
    'Two Springs Investment Ltd',
    'U-Fresh Enterprise Ltd',
    'Umoja',
    'Umoja Flour Mills',
    'Valon (K) Ltd',
    'Aryuv Agencies',
    'Josmis Suppliers',
    'Tumaini Bakers',
    'London Distillers Ltd',
    'KDL Group Ltd',
    'Ngk Spark Plug Co Ltd',
    'Royal Converters Ltd',
    'Golden Africa Kenya Ltd',
    'Githunguri Dairies',
    'Flame Tree Africa Ltd',
  ];
  static const List<String> _kOptionsCountry = <String>[
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Cote d Ivoire',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czechia',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates (UAE)',
    'United Kingdom (UK)',
    'United States of America (USA)',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City (Holy See)',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];

  var brandRowCount;

  Future<List> getData() async {
    var url = "http://$ipAddress/sdg/kbrands/getdata.php";
    final response = await http.post(Uri.parse(url), body: {
      'transect': widget.transect,
      'beachID': widget.beachID,
    });
    var responsedata = jsonDecode(response.body);

    setState(() {
      brandRowCount = responsedata.length;
    });
    return json.decode(response.body);
  }

  //Bottom sheet
  void _show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => Form(
        key: _dropdownFormKey,
        child: SafeArea(
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 50,
                          left: 25,
                          right: 25,
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                splashColor: Colors.blue,
                                splashRadius: 20.0,
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Warning'),
                                        content: const Text(
                                            'Are you sure you want to leave this page all unsaved entries will be lost.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'Cancel'),
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
                                ),
                                icon: const Icon(
                                  Icons.close,
                                ),
                              ),
                              Text(
                                '$brandRowCount',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          Center(
                              child: Text(
                            brandItem,
                            style: const TextStyle(
                                fontFamily: 'ProximaNova',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          )),
                          const SizedBox(
                            height: 30,
                          ),
                          Autocomplete<String>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }

                              setState(() {
                                _manufacturerinputString =
                                    textEditingValue.text;
                              });

                              return _kOptionsManufacturer
                                  .where((String option) {
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
                                  hintText: 'Manufacturer',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      textEditingController.clear();
                                    },
                                    icon: const Icon(
                                      Icons.groups,
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                                _countryinputString = textEditingValue.text;
                              });

                              return _kOptionsCountry.where((String option) {
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
                                  hintText: 'Country of Origin',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      textEditingController.clear();
                                    },
                                    icon: const Icon(
                                      Icons.add_location_alt,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controllerCounts,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Counts',
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.numbers,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Total Counts";
                              } else {
                                if (int.parse(controllerCounts.text) <= 0) {
                                  return "Total Counts can't be 0 or Less than 0";
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
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
                              validator: (value) =>
                                  value == "Select Type of Product"
                                      ? "Select Type of Product"
                                      : null,
                              //dropdownColor: Colors.blueAccent,
                              value: selectedValue1,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue1 = newValue!;
                                });
                              },
                              items: dropdownItems1),
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
                              validator: (value) =>
                                  value == "Select Type of Material"
                                      ? "Select Type of Material"
                                      : null,
                              //dropdownColor: Colors.blueAccent,
                              value: selectedValue2,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue2 = newValue!;
                                });
                              },
                              items: dropdownItems2),
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
                              validator: (value) =>
                                  value == "Select Type of Layer"
                                      ? "Select Type of Layer"
                                      : null,
                              //dropdownColor: Colors.blueAccent,
                              value: selectedValue3,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue3 = newValue!;
                                });
                              },
                              items: dropdownItems3),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      // _getUserLocation();
                                      // addItemToList();

                                      // print('$currentDate , '
                                      //     '${widget.countyID} , '
                                      //     '${widget.beachID}, '
                                      //     '$brandItem, '
                                      //     '$_manufacturerinputString, '
                                      //     '$_countryinputString, '
                                      //     '$selectedValue1, '
                                      //     '$selectedValue2, '
                                      //     '$selectedValue3, '
                                      //     '${controllerCounts.text}');

                                      if (_dropdownFormKey.currentState!
                                          .validate()) {
                                        addData();
                                        //valid flow
                                        Navigator.pop(
                                          context,
                                          "This string will be passed back to the parent",
                                        );
                                        //editData();
                                        Future.delayed(Duration.zero, () async {
                                          loader();
                                        });

                                        controllerCounts.text = '';
                                        selectedValue3 = 'Select Type of Layer';
                                        selectedValue2 =
                                            'Select Type of Material';
                                        selectedValue1 =
                                            'Select Type of Product';
                                      }
                                    },
                                    child: const Text("Save")),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String currentDate = DateFormat('d/M/yyyy').format(DateTime.now());

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

  var splitagZone;
  String? _brandinputString, _manufacturerinputString, _countryinputString;

  void addData() {
    var url = "http://$ipAddress/sdg/brands/adddata.php";
    splitagZone = widget.zone.split(" > ");
    http.post(Uri.parse(url), body: {
      'Date': currentDate,
      'BeachID': widget.beachID.toTitleCase(),
      'Location': widget.countyID.toTitleCase(),
      'Transect': widget.transect,
      'Zone': splitagZone[1],
      'Brand': brandItem.toTitleCase(),
      'Manufacturer': '$_manufacturerinputString'.toTitleCase(),
      'Country': '$_countryinputString'.toTitleCase(),
      'TypeOfProduct': selectedValue1,
      'TypeOfMaterial': selectedValue2,
      'TypeOfLayer': selectedValue3,
      'Count': controllerCounts.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //     '${widget.selectedBrandTransectTag} > ${widget.selectedBrandTag} brands'),
        title: Text(widget.selectedBrandTag),
        centerTitle: true,
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
              contentPadding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10),
              checkboxShape: const CircleBorder(),
              activeColor: Colors.blue,
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

                Future.delayed(Duration.zero, () async {
                  getData();
                });

                setState(() {
                  checkListItems[index]["value"] = value;
                  if (value == true) {
                    brandItem = checkListItems[index]["title"];
                    _show(context);
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
                  onPressed: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.custom,
                      barrierDismissible: true,
                      confirmBtnText: 'Add To List',
                      cancelBtnText: 'Cancel',
                      widget: Column(
                        children: [
                          const Text(
                            'Enter brand name',
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
                                _brandinputString = textEditingValue.text;
                              });

                              return _kOptionsBrands.where((String option) {
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
                                  hintText: 'Brand Name',
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
                        // if (controllerItemCount.text.isEmpty) {
                        // } else {
                        // //-----------------------------------------------------------------------------------------------------
                        // setState(() {
                        // checkListItems.insert(checkListItems.length, {
                        // "value": false,
                        // "title": controllerItemCount.text,
                        // // "count": itemCounts,
                        // // "weight": itemWeight,
                        // });
                        //
                        // controllerItemCount.text = '';
                        // });
                        // }

                        if (_brandinputString==null) {
                        } else {
                          _scrollDown();
                          //-----------------------------------------------------------------------------------------------------
                          setState(() {
                            checkListItems.insert(checkListItems.length, {
                              "value": false,
                              "title": _brandinputString,
                              // "count": itemCounts,
                              // "weight": itemWeight,
                            });

                            _brandinputString = '';
                          });
                        }

                        //print(_brandinputString);

                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: const Text('Add Brand'),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
