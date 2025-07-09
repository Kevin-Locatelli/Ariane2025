import 'package:flutter/material.dart';
import 'package:ariane_app/screens/ariane_result_screen.dart';
import 'package:ariane_app/screens/ariane_menu_screen.dart';
import 'package:ariane_app/screens/parameter_page.dart';

class ArianeFooter extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const ArianeFooter({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((255 * 0.1).round()),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(
            context,
            selectedIndex: selectedIndex,
            icon: Icons.emoji_events,
            label: 'Résultat',
            index: 0,
            onTap: () {
              onItemTapped(0);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ArianeResultScreen()),
              );
            },
          ),
          _buildBottomNavItem(
            context,
            selectedIndex: selectedIndex,
            icon: Icons.sports_esports,
            label: 'Jeux',
            index: 1,
            onTap: () {
              onItemTapped(1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ArianeMenuScreen()),
              );
            },
          ),
          _buildBottomNavItem(
            context,
            selectedIndex: selectedIndex,
            icon: Icons.settings,
            label: 'Paramètre',
            index: 2,
            onTap: () {
              onItemTapped(2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParametrePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _buildBottomNavItem(
    BuildContext context, {
    required int selectedIndex,
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80, // Increased width for larger hitbox
        height: 80, // Increased height for larger hitbox
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: selectedIndex == index ? Colors.blue : Colors.black87, // Highlight selected item
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selectedIndex == index ? Colors.blue : Colors.black87, // Highlight selected item
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
