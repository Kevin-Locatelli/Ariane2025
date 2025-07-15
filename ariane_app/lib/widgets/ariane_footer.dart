import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:ariane_app/screens/ariane_menu_screen.dart';
import 'package:ariane_app/screens/parameter_page.dart';
import 'package:ariane_app/screens/ariane_all_results_screen.dart';
import 'package:ariane_app/constants.dart';

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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(kBorderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
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
            label: AppStrings.get(context, 'resultats'),
            index: 0,
            onTap: () {
              onItemTapped(0);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ArianeAllResultsScreen()),
              );
            },
          ),
          _buildBottomNavItem(
            context,
            selectedIndex: selectedIndex,
            icon: Icons.sports_esports,
            label: AppStrings.get(context, 'jeux'),
            index: 1,
            onTap: () {
              onItemTapped(1);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ArianeMenuScreen()),
              );
            },
          ),
          _buildBottomNavItem(
            context,
            selectedIndex: selectedIndex,
            icon: Icons.settings,
            label: AppStrings.get(context, 'parametres'),
            index: 2,
            onTap: () {
              onItemTapped(2);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ParametrePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context, {
    required int selectedIndex,
    required IconData icon,
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedIndex == index;
    final Color color = isSelected ? Theme.of(context).colorScheme.primary : kTextColorSecondary;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
