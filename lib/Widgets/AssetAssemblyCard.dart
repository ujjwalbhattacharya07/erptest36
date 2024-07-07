import 'package:flutter/material.dart';
import 'package:hackathon/Widgets/Translucent%20card.dart';
class AssetCard extends StatelessWidget {
  const AssetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        gradient: LinearGradient(
          colors: [
            Color(0xFF182871),
            Color(0xFF182871),
            Color(0xFF141414),
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),

      ),

      child: FrostedGlassBox(path: "assets/images/assets_inventory.svg", title: "Assets Inventory",
          description: "The asset inventory for Volvo Warehouse in  Bengaluru, Karnataka ensures efficient tracking, documentation, and maintenance of  warehouse assets for streamlined operations.")

    );
  }
}
