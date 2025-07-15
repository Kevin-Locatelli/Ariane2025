import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';
import 'dart:math';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:ariane_app/screens/ariane_result_screen.dart';
import 'package:ariane_app/utils/score_manager.dart';

class CalculPage extends StatefulWidget {
  const CalculPage({super.key});

  @override
  CalculPageState createState() => CalculPageState();
}

class CalculPageState extends State<CalculPage> {
  final List<Offset?> _points = <Offset?>[];
  String _currentQuestion = "";
  int _correctAnswer = 0;
  int _currentScore = 0; // New: Score for the current game session

  Interpreter? _interpreter;

  @override
  void initState() {
    super.initState();
    _currentScore = 0; // Initialize score for the session
    _generateQuestion();
    _loadModel();
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/mnist.tflite');
    } catch (e) {
      // Handle error: Failed to load model
    }
  }

  void _generateQuestion() {
    final Random random = Random();
    _correctAnswer = random.nextInt(10); // Result between 0 and 9
    int num1 = random.nextInt(_correctAnswer + 1); // num1 between 0 and _correctAnswer
    int num2 = _correctAnswer - num1;
    _currentQuestion = '$num1 + $num2 = ?';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary, size: kIconSize),
          onPressed: () async {
            // Save current score before leaving
            await ScoreManager.saveScore(
              gameName: 'Calcul',
              score: _currentScore,
              message: 'Partie terminée. Votre score final est $_currentScore.',
            );
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ArianeResultScreen(
                    score: _currentScore,
                    message: 'Partie terminée. Votre score final est $_currentScore.',
                    gameName: 'Calcul',
                  ),
                ),
              );
            }
          },
        ),
        centerTitle: true,
        title: Text(
          'Calcul',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: kFontSizeMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kPaddingLarge),
        child: Column(
          children: [
            // Instructions
            Text(
              'Saisi dans la zone de texte le résultat du calcul :',
              style: TextStyle(
                fontSize: kFontSizeSmall,
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kSizedBoxHeightMedium),

            // Question bubble
            Container(
              padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor.withAlpha((255 * 0.5).round()), // Adjusted opacity
                    spreadRadius: kSpreadRadiusSmall,
                    blurRadius: kBlurRadiusSmall,
                    offset: Offset(kOffsetX, kOffsetY),
                  ),
                ],
              ),
              child: Text(
                _currentQuestion,
                style: TextStyle(
                  fontSize: kFontSizeMedium,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            SizedBox(height: kSizedBoxHeightLarge),
            
            // Drawing area
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: kPaddingMedium),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  border: Border.all(color: kBorderColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: kShadowColor, // Using kShadowColor directly
                      spreadRadius: kSpreadRadius,
                      blurRadius: kBlurRadius,
                      offset: Offset(kOffsetX, kOffsetY),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      _points.add(null);
                    },
                    child: CustomPaint(
                      painter: DrawingPainter(_points, Theme.of(context).textTheme.bodyMedium!.color!),
                      size: Size.infinite,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: _points.isEmpty 
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: kIconSizeLarge,
                                    color: kTextColorSecondary,
                                  ),
                                  SizedBox(height: kSizedBoxHeightMedium),
                                  Text(
                                    'Dessinez votre réponse ici',
                                    style: TextStyle(
                                      fontSize: kFontSizeSmall,
                                      color: kTextColorSecondary,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reset button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _points.clear();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor, // Using kShadowColor directly
                          spreadRadius: kSpreadRadiusSmall,
                          blurRadius: kBlurRadiusSmall,
                          offset: Offset(kOffsetX, kOffsetY),
                        ),
                      ],
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: kFontSizeSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                
                // Valider button
                GestureDetector(
                  onTap: () {
                    _showValidationDialog();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor, // Using kShadowColor directly
                          spreadRadius: kSpreadRadiusSmall,
                          blurRadius: kBlurRadiusSmall,
                          offset: Offset(kOffsetX, kOffsetY),
                        ),
                      ],
                    ),
                    child: Text(
                      'Valider',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: kFontSizeSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showValidationDialog() async {
    if (_interpreter == null) {
      // Show a message to the user if model not loaded
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Modèle de reconnaissance non chargé.')),
      );
      return;
    }

    if (_points.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez dessiner un chiffre.')),
      );
      return;
    }

    // Convert drawing to image
    final recognizedDigit = await _recognizeDigit();

    bool isCorrect = recognizedDigit == _correctAnswer;
    if (isCorrect) {
      setState(() {
        _currentScore++;
        _points.clear(); // Clear drawing area for new question
      });
      _generateQuestion(); // Generate new question immediately
    } else {
      // Incorrect answer: save score and navigate to result screen
      String message = 'Dommage ! Vous avez dessiné $recognizedDigit. Le résultat était $_correctAnswer. Votre score final est $_currentScore.';
      await ScoreManager.saveScore(
        gameName: 'Calcul',
        score: _currentScore,
        message: message,
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ArianeResultScreen(
              score: _currentScore,
              message: message,
              gameName: 'Calcul',
            ),
          ),
        );
      }
    }
  }

  Future<int> _recognizeDigit() async {
    // Create a 28x28 grayscale image buffer, initialized to black (0.0)
    final List<List<double>> imageBuffer = List.generate(
      28,
      (_) => List.generate(28, (_) => 0.0),
    );

    // Find bounding box of the drawing
    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;

    for (final point in _points) {
      if (point != null) {
        minX = min(minX, point.dx);
        minY = min(minY, point.dy);
        maxX = max(maxX, point.dx);
        maxY = max(maxY, point.dy);
      }
    }

    // If no points, return -1 (or handle as an error)
    if (minX == double.infinity) {
      return -1;
    }

    final double drawingWidth = maxX - minX;
    final double drawingHeight = maxY - minY;

    // Calculate scaling factor to fit into 20x20 area (with 4-pixel border)
    final double scale = 20.0 / max(drawingWidth, drawingHeight);

    // Calculate translation to center the scaled digit on a 28x28 canvas
    final double offsetX = (28.0 - drawingWidth * scale) / 2.0;
    final double offsetY = (28.0 - drawingHeight * scale) / 2.0;

    // "Draw" the points onto the image buffer
    for (int i = 0; i < _points.length - 1; i++) {
      if (_points[i] != null && _points[i + 1] != null) {
        final Offset p1 = _points[i]!;
        final Offset p2 = _points[i + 1]!;

        // Bresenham's line algorithm to draw thick lines
        int x0 = ((p1.dx - minX) * scale + offsetX).round();
        int y0 = ((p1.dy - minY) * scale + offsetY).round();
        int x1 = ((p2.dx - minX) * scale + offsetX).round();
        int y1 = ((p2.dy - minY) * scale + offsetY).round();

        int dx = (x1 - x0).abs();
        int dy = (y1 - y0).abs();
        int sx = (x0 < x1) ? 1 : -1;
        int sy = (y0 < y1) ? 1 : -1;
        int err = dx - dy;

        while (true) {
          // Draw a circle around the current point to simulate stroke width
          for (int r = -kStrokeWidth.round(); r <= kStrokeWidth.round(); r++) {
            for (int c = -kStrokeWidth.round(); c <= kStrokeWidth.round(); c++) {
              int drawX = x0 + c;
              int drawY = y0 + r;
              if (drawX >= 0 && drawX < 28 && drawY >= 0 && drawY < 28) {
                imageBuffer[drawY][drawX] = 1.0; // White digit
              }
            }
          }

          if (x0 == x1 && y0 == y1) break;
          int e2 = 2 * err;
          if (e2 > -dy) {
            err -= dy;
            x0 += sx;
          }
          if (e2 < dx) {
            err += dx;
            y0 += sy;
          }
        }
      }
    }

    // Prepare input for the model
    final input = List.filled(1 * 28 * 28 * 1, 0.0).reshape([1, 28, 28, 1]);
    for (int y = 0; y < 28; y++) {
      for (int x = 0; x < 28; x++) {
        input[0][y][x][0] = imageBuffer[y][x];
      }
    }

    // Run inference
    final output = List.filled(1 * 10, 0.0).reshape([1, 10]);
    _interpreter!.run(input, output);

    // Get the predicted digit
    double maxConfidence = 0.0;
    int predictedDigit = -1;
    for (int i = 0; i < output[0].length; i++) {
      if (output[0][i] > maxConfidence) {
        maxConfidence = output[0][i];
        predictedDigit = i;
      }
    }
    return predictedDigit;
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  
  DrawingPainter(this.points, this.color);
  
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = kStrokeWidth;
    
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
