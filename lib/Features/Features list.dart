import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/Features/Asset%20Inventory/AssetAssembly.dart';
import 'package:hackathon/Features/Operations/operations_screen.dart';
import 'package:hackathon/Widgets/Features_Card.dart';

import '../Widgets/BottomNavBar.dart';
class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});
  final String path ="assets/images";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0XFF182871),

          title: Text("Volvo",style: TextStyle(
              fontSize:18,fontWeight: FontWeight.bold,fontFamily: "Inter"   ,color: Colors.white       //this will be a variable text area, e.g. ffetch from the users name
          ),),

          leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),

          ),

          // titleSpacing: 0,
        ),
        body: ListView(
              children: [ Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssetAssembly(),
                        ),
                      );
                    },
                      child: FeaturesCard(svgAsset: "$path/assets_inventory.svg", title: "Assets Inventory")),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OperationsList()));
                    },
                      child: FeaturesCard(svgAsset: "$path/operations-icon.svg", title: "Operations")),
                  FeaturesCard(svgAsset: "$path/services-icon.svg", title: "Spare Parts Management"),
                  FeaturesCard(svgAsset: "$path/workshop-icon.svg", title: "Maintenance"),
                  FeaturesCard(svgAsset: "$path/target-line-icon.svg", title: "Ideal/SOPs")
                ],
              ),]

        ),

        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
