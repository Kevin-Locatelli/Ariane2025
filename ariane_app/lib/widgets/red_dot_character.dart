import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';

class RedDotCharacter extends StatelessWidget {
  final double size;

  const RedDotCharacter({Key? key, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red[700],
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ears
          Positioned(
            top: size * 0.05, // Adjusted for dynamic size
            left: size * 0.2, // Adjusted for dynamic size
            child: Container(
              width: size * 0.15, // Adjusted for dynamic size
              height: size * 0.15, // Adjusted for dynamic size
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.circular(size * 0.075),
              ),
            ),
          ),
          Positioned(
            top: size * 0.05, // Adjusted for dynamic size
            right: size * 0.2, // Adjusted for dynamic size
            child: Container(
              width: size * 0.15, // Adjusted for dynamic size
              height: size * 0.15, // Adjusted for dynamic size
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.circular(size * 0.075),
              ),
            ),
          ),
          // Face
          Container(
            width: size * 0.625, // Adjusted for dynamic size
            height: size * 0.625, // Adjusted for dynamic size
            decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: BorderRadius.circular(size * 0.3125),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Eyes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size * 0.075, // Adjusted for dynamic size
                      height: size * 0.075, // Adjusted for dynamic size
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(size * 0.0375),
                      ),
                    ),
                    Container(
                      width: size * 0.075, // Adjusted for dynamic size
                      height: size * 0.075, // Adjusted for dynamic size
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(size * 0.0375),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size * 0.05), // Adjusted for dynamic size
                // Mouth
                Container(
                  width: size * 0.1, // Adjusted for dynamic size
                  height: size * 0.05, // Adjusted for dynamic size
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(size * 0.025),
                  ),
                ),
              ],
            ),
          ),
          // Cape
          Positioned(
            bottom: -size * 0.05, // Adjusted for dynamic size
            child: Container(
              width: size * 0.375, // Adjusted for dynamic size
              height: size * 0.25, // Adjusted for dynamic size
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size * 0.175),
                  bottomRight: Radius.circular(size * 0.175),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}