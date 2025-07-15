import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ariane_app/constants.dart';
import 'package:ariane_app/screens/ariane_result_screen.dart';
import 'package:ariane_app/utils/score_manager.dart';

class ScratchPage extends StatefulWidget {
  const ScratchPage({super.key});

  @override
  ScratchPageState createState() => ScratchPageState();
}

class ScratchPageState extends State<ScratchPage> with TickerProviderStateMixin {
  final List<CodeBlock> _codeBlocks = [];
  double _characterX = 50;
  double _characterY = 50;
  double _characterRotation = 0;
  AnimationController? _animationController;
  bool _isRunning = false;
  final GlobalKey _gameAreaKey = GlobalKey();
  int _score = 0; // Score for Scratch game

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Scratch',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: kFontSizeMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Main game area
          Expanded(
            child: Container(
              margin: EdgeInsets.all(kPaddingLarge),
              child: Row(
                children: [
                  // Left side - Code blocks area
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(kSmallBorderRadius),
                      ),
                      child: Column(
                        children: [
                          // Available blocks palette
                          Container(
                            padding: EdgeInsets.all(kPaddingSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Blocs disponibles:',
                                  style: TextStyle(
                                    fontSize: kFontSizeExtraSmall,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.bodyMedium!.color,
                                  ),
                                ),
                                SizedBox(height: kPaddingSmall),
                                SingleChildScrollView(
                                  child: Wrap(
                                    spacing: kSizedBoxHeightSmall,
                                    runSpacing: kSizedBoxHeightSmall,
                                    children: [
                                      _buildDraggableBlock('Avancer', Theme.of(context).colorScheme.primary),
                                      _buildDraggableBlock('Tourner droite', kSuccessColor),
                                      _buildDraggableBlock('Tourner gauche', Theme.of(context).colorScheme.secondary),
                                      _buildDraggableBlock('Dire bonjour', kErrorColor),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Code sequence area
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(kPaddingSmall),
                              padding: EdgeInsets.all(kPaddingSmall),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(kTinyBorderRadius),
                                border: Border.all(color: kBorderColor),
                              ),
                              child: DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Séquence de code:',
                                        style: TextStyle(
                                          fontSize: kFontSizeExtraSmall,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).textTheme.bodyMedium!.color,
                                        ),
                                      ),
                                      SizedBox(height: kPaddingSmall),
                                      Expanded(
                                        child: _codeBlocks.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'Glissez les blocs ici',
                                                  style: TextStyle(
                                                    color: kTextColorSecondary,
                                                    fontSize: kFontSizeSmall,
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: _codeBlocks.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(bottom: kSizedBoxHeightSmall),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: _buildCodeBlock(_codeBlocks[index]),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons.close, size: kIconSize - 8),
                                                          onPressed: () {
                                                            setState(() {
                                                              _codeBlocks.removeAt(index);
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                    ],
                                  );
                                },
                                onAcceptWithDetails: (details) {
                                  setState(() {
                                    _codeBlocks.add(CodeBlock(details.data, _getBlockColor(details.data)));
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(width: kPaddingLarge),
                  
                  // Right side - Result area
                  Expanded(
                    flex: 1,
                    child: Container(
                      key: _gameAreaKey,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(kSmallBorderRadius),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kSmallBorderRadius),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Theme.of(context).cardColor,
                            ),
                            // Character
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 500),
                              left: _characterX,
                              top: _characterY,
                              child: Transform.rotate(
                                angle: _characterRotation,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: kShadowColor,
                                        blurRadius: kBlurRadiusSmall,
                                        offset: Offset(kOffsetX, kOffsetY),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.pets,
                                    color: Colors.white,
                                    size: kIconSizeLarge - 18,
                                  ),
                                ),
                              ),
                            ),
                            // Speech bubble (if saying hello)
                            if (_isRunning)
                              Positioned(
                                left: _characterX + 70,
                                top: _characterY - 20,
                                child: Container(
                                  padding: EdgeInsets.all(kPaddingSmall),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                    border: Border.all(color: kBorderColor),
                                  ),
                                  child: Text(
                                    'Bonjour!',
                                    style: TextStyle(fontSize: kFontSizeExtraSmall, color: Theme.of(context).textTheme.bodyMedium!.color),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Control buttons
          Container(
            padding: EdgeInsets.all(kPaddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reset button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _codeBlocks.clear();
                      _characterX = 50;
                      _characterY = 50;
                      _characterRotation = 0;
                      _isRunning = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor,
                          blurRadius: kBlurRadiusSmall,
                          offset: Offset(kOffsetX, kOffsetY),
                        ),
                      ],
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: kFontSizeSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                
                // Start button
                GestureDetector(
                  onTap: _executeCode,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor,
                          blurRadius: kBlurRadiusSmall,
                          offset: Offset(kOffsetX, kOffsetY),
                        ),
                      ],
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: kFontSizeSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableBlock(String text, Color color) {
    return Draggable<String>(
      data: text,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kPaddingSmall, vertical: kSizedBoxHeightSmall),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(kTinyBorderRadius),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: kFontSizeExtraSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kPaddingSmall, vertical: kSizedBoxHeightSmall),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(kTinyBorderRadius),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: kFontSizeExtraSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBlock(CodeBlock block) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kPaddingSmall, vertical: kSizedBoxHeightSmall),
      decoration: BoxDecoration(
        color: block.color,
        borderRadius: BorderRadius.circular(kTinyBorderRadius),
      ),
      child: Text(
        block.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: kFontSizeExtraSmall,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getBlockColor(String text) {
    switch (text) {
      case 'Avancer':
        return Theme.of(context).colorScheme.primary;
      case 'Tourner droite':
        return kSuccessColor;
      case 'Tourner gauche':
        return Theme.of(context).colorScheme.secondary;
      case 'Dire bonjour':
        return kErrorColor;
      default:
        return kTextColorSecondary;
    }
  }

  void _executeCode() async {
    if (_codeBlocks.isEmpty) return;
    
    setState(() {
      _isRunning = true;
    });

    // Get the size of the game area
    final RenderBox renderBox = _gameAreaKey.currentContext!.findRenderObject() as RenderBox;
    final Size gameAreaSize = renderBox.size;

    for (int i = 0; i < _codeBlocks.length; i++) {
      await Future.delayed(Duration(milliseconds: 600));
      
      if (!mounted) return;
      setState(() {
        switch (_codeBlocks[i].text) {
          case 'Avancer':
            // Move forward based on current rotation
            _characterX += 30 * cos(_characterRotation);
            _characterY += 30 * sin(_characterRotation);

            // Ensure character stays within bounds
            _characterX = _characterX.clamp(0, gameAreaSize.width - 60); // 60 is character width
            _characterY = _characterY.clamp(0, gameAreaSize.height - 60); // 60 is character height
            _score++;
            break;
          case 'Tourner droite':
            _characterRotation += 1.57; // 90 degrees
            _score++;
            break;
          case 'Tourner gauche':
            _characterRotation -= 1.57; // 90 degrees
            _score++;
            break;
          case 'Dire bonjour':
            // Speech bubble is shown when _isRunning is true
            _score++;
            break;
        }
      });
    }

    await Future.delayed(Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _isRunning = false;
    });

    await ScoreManager.saveScore(
      gameName: 'Scratch',
      score: _score,
      message: 'Code exécuté !',
    );

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ArianeResultScreen(
            score: _score,
            message: 'Code exécuté !',
            gameName: 'Scratch',
          ),
        ),
      );
    }
  }
}

class CodeBlock {
  final String text;
  final Color color;

  CodeBlock(this.text, this.color);
}
