import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';
import 'dart:math';

class CalculPage extends StatefulWidget {
  @override
  _CalculPageState createState() => _CalculPageState();
}

class _CalculPageState extends State<CalculPage> {
  List<Offset?> _points = <Offset?>[];
  String _currentQuestion = "";
  int _correctAnswer = 0;
  String _userAnswer = "";
  bool _isAnswerCorrect = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final Random random = Random();
    int num1, num2, result;
    String operator;

    do {
      num1 = random.nextInt(10); // 0-9
      num2 = random.nextInt(10); // 0-9
      final int opType = random.nextInt(2); // 0 for +, 1 for -

      if (opType == 0) {
        operator = '+';
        result = num1 + num2;
      } else {
        operator = '-';
        result = num1 - num2;
      }
    } while (result < 0 || result > 9); // Ensure result is between 0 and 9

    setState(() {
      _currentQuestion = "Combien font $num1 $operator $num2 ?";
      _correctAnswer = result;
      _points.clear(); // Clear drawing area for new question
      _userAnswer = "";
      _isAnswerCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Calcul',
          style: TextStyle(
            color: Colors.black,
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
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: kSizedBoxHeightMedium),
            
            // Question bubble
            Container(
              padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                border: Border.all(color: kPrimaryColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                  color: Colors.black87,
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
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  border: Border.all(color: kBorderColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
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
                        RenderBox renderBox = context.findRenderObject() as RenderBox;
                        _points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      _points.add(null);
                    },
                    child: CustomPaint(
                      painter: DrawingPainter(_points),
                      size: Size.infinite,
                      child: Container(
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
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: kSizedBoxHeightMedium),
                                  Text(
                                    'Dessinez votre réponse ici',
                                    style: TextStyle(
                                      fontSize: kFontSizeSmall,
                                      color: Colors.grey[500],
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
                      _userAnswer = "";
                      _isAnswerCorrect = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                    decoration: BoxDecoration(
                      color: kCardColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                      border: Border.all(color: kPrimaryColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: kSpreadRadiusSmall,
                          blurRadius: kBlurRadiusSmall,
                          offset: Offset(kOffsetX, kOffsetY),
                        ),
                      ],
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: kPrimaryColor,
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
                      color: kCardColor,
                      borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                      border: Border.all(color: kPrimaryColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: kSpreadRadiusSmall,
                          blurRadius: kBlurRadiusSmall,
                          offset: Offset(kOffsetX, kOffsetY),
                        ),
                      ],
                    ),
                    child: Text(
                      'Valider',
                      style: TextStyle(
                        color: kPrimaryColor,
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
  
  void _showValidationDialog() {
    // This is a simulated digit recognition.
    // In a real application, you would send the _points data to a digit recognition model.
    // For demonstration, we'll assume the user always draws the correct answer.
    bool isCorrect = true; // Simulate correct recognition for now

    String title = isCorrect ? 'Correct !' : 'Incorrect';
    String content = isCorrect
        ? 'Bravo ! Le résultat était bien $_correctAnswer.'
        : 'Dommage ! Le résultat était $_correctAnswer. Réessaie !';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generateQuestion(); // Generate new question after validation
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  
  DrawingPainter(this.points);
  
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black87
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