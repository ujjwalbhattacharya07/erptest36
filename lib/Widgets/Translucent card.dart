import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

class FrostedGlassBox extends StatelessWidget {
  final String path;
  final String title;
  final String description;

  const FrostedGlassBox({
    Key? key,
    required this.path,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.13)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.05),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Blur effect (third layer of stack)
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.5,
                sigmaY: 1.5,
              ),
              child: Container(
                color: Colors.white.withOpacity(0.5), // Adjust opacity for blur effect
              ),
            ),
            // Child content (second layer of stack)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, // Align to start for better layout control
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        path,
                        width: 40,
                        height: 40,
                        color: Colors.white, // Example color, adjust as needed
                      ),
                      SizedBox(width: 20), // Add space between icon and title
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
