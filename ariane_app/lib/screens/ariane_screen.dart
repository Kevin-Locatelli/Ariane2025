import 'package:flutter/material.dart';
import 'package:ariane_app/screens/ariane_menu_screen.dart';

class ArianeScreen extends StatelessWidget {
  const ArianeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Maze Logo
              SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: MazePainter(),
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Title
              const Text(
                'ARIANE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Red Panda Characters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Left red panda
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange[700],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ears
                            Positioned(
                              top: 5,
                              left: 15,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.orange[800],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 15,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.orange[800],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            // Face
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange[600],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Eyes
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // Mouth
                                  Container(
                                    width: 8,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Arm waving
                      Container(
                        width: 20,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.orange[700],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                  
                  // Speech bubble
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: const Text(
                      'BLA\nBLA\nBLA',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  // Right red panda
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ears
                            Positioned(
                              top: 5,
                              left: 15,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 15,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            // Face
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Eyes
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // Mouth
                                  Container(
                                    width: 8,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Cape
                      Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 80),
              
              // Start Button
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ArianeMenuScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  child: const Text(
                    'COMMENCER',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MazePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double w = size.width;
    final double h = size.height;

    // Draw maze pattern - simplified version
    // Outer rectangle
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), paint);
    
    // Inner rectangles to create maze effect
    canvas.drawRect(Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.7, h * 0.7), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.3, h * 0.3, w * 0.4, h * 0.4), paint);
    canvas.drawRect(Rect.fromLTWH(w * 0.45, h * 0.45, w * 0.1, h * 0.1), paint);
    
    // Add some maze paths
    // Horizontal lines
    canvas.drawLine(Offset(0, h * 0.15), Offset(w * 0.7, h * 0.15), paint);
    canvas.drawLine(Offset(w * 0.3, h * 0.85), Offset(w, h * 0.85), paint);
    
    // Vertical lines
    canvas.drawLine(Offset(w * 0.85, 0), Offset(w * 0.85, h * 0.7), paint);
    canvas.drawLine(Offset(w * 0.15, h * 0.3), Offset(w * 0.15, h), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}