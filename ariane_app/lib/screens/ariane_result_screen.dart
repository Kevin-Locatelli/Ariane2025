import 'package:flutter/material.dart';
import 'package:ariane_app/widgets/ariane_footer.dart';

class ArianeResultScreen extends StatelessWidget {
  const ArianeResultScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        title: const Text(
          'ARIANE',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
                    bottom: -5,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Game Mode Cards
            Expanded(
              child: ListView(
                children: [
                  _buildGameModeCard(
                    'Labyrinthe',
                    'Créer ton labyrinthe et laisse Michel le résoudre tout seul',
                    Colors.orange.withAlpha((255 * 0.3).round()),
                    Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeCard(
                    'Calcul',
                    'Résout les calculs de Michel',
                    Colors.blue.withAlpha((255 * 0.3).round()),
                    Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeCard(
                    'Scratch',
                    'Aide Michel à trouver son chemin',
                    Colors.pink.withAlpha((255 * 0.3).round()),
                    Colors.pink,
                  ),
                ],
              ),
            ),
            
            // Bottom Navigation
            ArianeFooter(
              selectedIndex: 0, // Assuming 'Résultat' is the selected index for the result screen
              onItemTapped: (index) {
                // Handle navigation based on index if needed, or let the footer handle it
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGameModeCard(String title, String description, Color backgroundColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((255 * 0.1).round()),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Icon and title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Maze icon
              SizedBox(
                width: 60,
                height: 60,
                child: CustomPaint(
                  painter: MiniMazePainter(strokeColor: Colors.grey[600]!),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 20),
          
          // Right side - Description with background
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [backgroundColor, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  
}

class MiniMazePainter extends CustomPainter {
  final Color strokeColor;
  final double strokeWidth;
  
  const MiniMazePainter({
    this.strokeColor = Colors.black87,
    this.strokeWidth = 1.5,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double w = size.width;
    final double h = size.height;

    // Draw simplified maze pattern
    // Outer rectangle
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), paint);
    
    // Inner rectangles
    canvas.drawRect(Rect.fromLTWH(w * 0.2, h * 0.2, w * 0.6, h * 0.6), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.4, h * 0.4, w * 0.2, h * 0.2), paint);
    
    // Some maze lines
    canvas.drawLine(Offset(0, h * 0.2), Offset(w * 0.6, h * 0.2), paint);
    canvas.drawLine(Offset(w * 0.8, 0), Offset(w * 0.8, h * 0.6), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}