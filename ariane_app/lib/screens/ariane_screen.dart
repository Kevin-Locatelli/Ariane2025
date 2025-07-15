import 'package:ariane_app/screens/ariane_menu_screen.dart';
import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ArianeScreen extends StatelessWidget {
  const ArianeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Maze Logo
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CustomPaint(
                    painter: MazePainter(color: Theme.of(context).primaryColor),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Title
                Text(
                  AppStrings.get(context, 'title'),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      AppStrings.get(context, 'commencer'),
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
      ),
    );
  }
}

class MazePainter extends CustomPainter {
  final Color color;

  MazePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
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