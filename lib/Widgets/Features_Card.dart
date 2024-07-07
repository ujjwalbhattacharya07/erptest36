import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeaturesCard extends StatelessWidget {
  final String svgAsset;
  final String title;

  const FeaturesCard({
    Key? key,
    required this.svgAsset,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Color(0xFF202A44), Colors.white.withOpacity(0.3), Color(0xFF141414)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(svgAsset),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 20),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
