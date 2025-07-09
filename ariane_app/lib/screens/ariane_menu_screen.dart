import 'package:flutter/material.dart';
import 'package:ariane_app/widgets/ariane_footer.dart';
import 'package:ariane_app/screens/labyrinth_game_page.dart'; // Import the labyrinth game page
import 'package:ariane_app/screens/calcul_game_page.dart'; // Import the calcul game page
import 'package:ariane_app/constants.dart';

class ArianeMenuScreen extends StatelessWidget {
  const ArianeMenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: kCardColor,
        elevation: kElevation * 2,
        centerTitle: false,
        title: const Text(
          'ARIANE',
          style: TextStyle(
            fontSize: kFontSizeLarge - 4,
            fontWeight: FontWeight.bold,
            color: kInactiveColor,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kPaddingLarge),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ears
                  Positioned(
                    top: 2,
                    left: 8,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 8,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  // Face
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Eyes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        // Mouth
                        Container(
                          width: 4,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Cape
                  Positioned(
                    bottom: -2,
                    child: Container(
                      width: 15,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingLarge),
        child: Column(
          children: [
            // Menu Items
            Expanded(
              child: Column(
                children: [
                  // Labyrinthe Card
                  _buildMenuCard(
                    title: 'Labyrinthe',
                    description: 'Créer ton labyrinthe et laisse Michel le résoudre tout seul',
                    color: Colors.orange[200]!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LabyrinthePage()),
                      );
                    },
                  ),

                  const SizedBox(height: kPaddingLarge),

                  // Calcul Card
                  _buildMenuCard(
                    title: 'Calcul',
                    description: 'Résout les calculs de Michel',
                    color: Colors.purple[200]!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalculPage()),
                      );
                    },
                  ),

                  const SizedBox(height: kPaddingLarge),

                  // Scratch Card
                  _buildMenuCard(
                    title: 'Scratch',
                    description: 'Aide Michel à trouver son chemin',
                    color: Colors.pink[200]!,
                    onTap: () {
                      // Handle Scratch tapped
                    },
                  ),
                ],
              ),
            ),

            // Bottom Navigation
            ArianeFooter(
              selectedIndex: 1, // Assuming 'Jeux' is the selected index for the menu screen
              onItemTapped: (index) {
                // Handle navigation based on index if needed, or let the footer handle it
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(kPaddingExtraLarge),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((255 * 0.1).round()),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left side with maze icon and gradient
            Container(
              width: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withAlpha((255 * 0.7).round()), color.withAlpha((255 * 0.3).round())],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kPaddingExtraLarge),
                  bottomLeft: Radius.circular(kPaddingExtraLarge),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Maze icon
                  SizedBox(
                    width: kMascotSize,
                    height: kMascotSize,
                    child: CustomPaint(
                      painter: MiniMazePainter(),
                    ),
                  ),
                  const SizedBox(height: kPaddingSmall),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kInactiveColor,
                    ),
                  ),
                ],
              ),
            ),

            // Right side with description
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(kPaddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium, vertical: kPaddingSmall),
                      decoration: BoxDecoration(
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: kFontSizeExtraSmall,
                          color: kInactiveColor,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniMazePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kInactiveColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double w = size.width;
    final double h = size.height;

    // Draw simplified maze pattern
    // Outer rectangle
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), paint);

    // Inner rectangles
    canvas.drawRect(Rect.fromLTWH(w * 0.2, h * 0.2, w * 0.6, h * 0.6), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.4, h * 0.4, w * 0.2, h * 0.2), paint);

    // Some maze paths
    canvas.drawLine(Offset(0, h * 0.2), Offset(w * 0.6, h * 0.2), paint);
    canvas.drawLine(Offset(w * 0.8, 0), Offset(w * 0.8, h * 0.6), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
