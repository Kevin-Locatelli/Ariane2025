import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ariane_app/screens/ariane_result_screen.dart';
import 'package:ariane_app/utils/score_manager.dart';

class ScratchPage extends StatefulWidget {
  @override
  _ScratchPageState createState() => _ScratchPageState();
}

class _ScratchPageState extends State<ScratchPage> with TickerProviderStateMixin {
  List<CodeBlock> _codeBlocks = [];
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
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Scratch',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Main game area
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Left side - Code blocks area
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Available blocks palette
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Blocs disponibles:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SingleChildScrollView(
                                  child: Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: [
                                      _buildDraggableBlock('Avancer', Colors.blue[400]!),
                                      _buildDraggableBlock('Tourner droite', Colors.green[400]!),
                                      _buildDraggableBlock('Tourner gauche', Colors.orange[400]!),
                                      _buildDraggableBlock('Dire bonjour', Colors.purple[400]!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Code sequence area
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Séquence de code:',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Expanded(
                                        child: _codeBlocks.isEmpty
                                            ? Center(
                                                child: Text(
                                                  'Glissez les blocs ici',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: _codeBlocks.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(bottom: 4),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: _buildCodeBlock(_codeBlocks[index]),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons.close, size: 16),
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
                                onAccept: (data) {
                                  setState(() {
                                    _codeBlocks.add(CodeBlock(data, _getBlockColor(data)));
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 16),
                  
                  // Right side - Result area
                  Expanded(
                    flex: 1,
                    child: Container(
                      key: _gameAreaKey,
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.white,
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
                                    color: Colors.red[400],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.pets,
                                    color: Colors.white,
                                    size: 30,
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
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Text(
                                    'Bonjour!',
                                    style: TextStyle(fontSize: 12),
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
            padding: EdgeInsets.all(16),
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
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                
                // Start button
                GestureDetector(
                  onTap: _executeCode,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
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
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBlock(CodeBlock block) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: block.color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        block.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getBlockColor(String text) {
    switch (text) {
      case 'Avancer':
        return Colors.blue[400]!;
      case 'Tourner droite':
        return Colors.green[400]!;
      case 'Tourner gauche':
        return Colors.orange[400]!;
      case 'Dire bonjour':
        return Colors.purple[400]!;
      default:
        return Colors.grey[400]!;
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

class CodeBlock {
  final String text;
  final Color color;

  CodeBlock(this.text, this.color);
}