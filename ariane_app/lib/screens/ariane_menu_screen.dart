import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:ariane_app/widgets/ariane_footer.dart';
import 'package:ariane_app/screens/labyrinth_game_page.dart'; // Import the labyrinth game page
import 'package:ariane_app/screens/calcul_game_page.dart'; // Import the calcul game page
import 'package:ariane_app/screens/scratch_game_page.dart'; // Import the scratch game page
import 'package:ariane_app/constants.dart';

class ArianeMenuScreen extends StatelessWidget {
  const ArianeMenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.get(context, 'title'),
          style: TextStyle(
            fontSize: kFontSizeLarge - 4,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1,
          ),
        ),
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
                    context: context,
                    title: AppStrings.get(context, 'labyrinthe'),
                    description: AppStrings.get(context, 'labyrinthe_description'),
                    color: Theme.of(context).colorScheme.secondary,
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
                    context: context,
                    title: AppStrings.get(context, 'calcul'),
                    description: AppStrings.get(context, 'calcul_description'),
                    color: Theme.of(context).colorScheme.primary,
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
                    context: context,
                    title: AppStrings.get(context, 'scratch'),
                    description: AppStrings.get(context, 'scratch_description'),
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScratchPage()),
                      );
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
    required BuildContext context,
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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kPaddingExtraLarge),
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left side with icon and gradient
            Container(
              width: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.7), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kPaddingExtraLarge),
                  bottomLeft: Radius.circular(kPaddingExtraLarge),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Icon(Icons.gamepad, color: Colors.white, size: kMascotSize),
                  const SizedBox(height: kPaddingSmall),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: kFontSizeExtraSmall,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
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
