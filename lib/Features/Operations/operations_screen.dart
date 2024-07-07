import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/Widgets/Features_Card.dart';

import '../../Widgets/BottomNavBar.dart';
class OperationsList extends StatelessWidget {
  const OperationsList({super.key});
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

                    },
                    child: FeaturesCard(svgAsset: "$path/asset_assembly.svg", title: "Assets Assembly")),
                FeaturesCard(svgAsset: "$path/inspection.svg", title: "Inspection"),
              ],
            ),]

        ),

        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
