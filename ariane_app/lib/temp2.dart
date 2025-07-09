PS C:\Users\theke\Downloads\Ariane\Ariane2025\ariane_app> flutter run -d R5CT308RAFF
Launching lib\main.dart on SM S908B in debug mode...
lib/screens/calcul_game_page.dart:305:5: Error: Variables must be declared using the keywords 'const', 'final', 'var' or a type name.
Try adding the name of the type of the variable or the keyword 'var'.
return Scaffold(
^^^^^^
lib/screens/calcul_game_page.dart:305:5: Error: 'return' can't be used as an identifier because it's a keyword.
Try renaming this to be an identifier that isn't a keyword.
return Scaffold(
^^^^^^
lib/screens/calcul_game_page.dart:305:5: Error: Expected ';' after this.
return Scaffold(
^^^^^^
lib/screens/calcul_game_page.dart:306:22: Error: Non-optional parameters can't have a default value.
Try removing the default value or making the parameter optional.
backgroundColor: kBackgroundColor,
 ^
lib/screens/calcul_game_page.dart:307:13: Error: Non-optional parameters can't have a default value.
Try removing the default value or making the parameter optional.
appBar: AppBar(
^
lib/screens/calcul_game_page.dart:324:11: Error: Non-optional parameters can't have a default value.
Try removing the default value or making the parameter optional.
body: Padding(
^
lib/screens/calcul_game_page.dart:506:6: Error: Expected a function body or '=>'.
Try adding {}.
);
 ^
lib/screens/calcul_game_page.dart:507:3: Error: Expected a declaration, but got '}'.
}
^
lib/screens/calcul_game_page.dart:534:1: Error: Expected a declaration, but got '}'.
}
^
lib/screens/calcul_game_page.dart:536:7: Error: 'DrawingPainter' is already declared in this scope.
class DrawingPainter extends CustomPainter {
^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:283:7: Context: Previous declaration of 'DrawingPainter'.
class DrawingPainter extends CustomPainter {
^^^^^^^^^^^^^^
lib/screens/ariane_menu_screen.dart:11:12: Error: 'Scaffold' is imported from both 'package:ariane_app/screens/calcul_game_page.dart' and 'package:flutter/src/material/scaffold.dart'.
return Scaffold(
 ^^^^^^^^
lib/screens/calcul_game_page.dart:148:32: Error: Can't use 'DrawingPainter' because it is declared more than once.
painter: DrawingPainter(_points),
 ^
lib/screens/calcul_game_page.dart:53:20: Error: Too few positional arguments: 3 required, 0 given.
return Scaffold(
 ^
lib/screens/calcul_game_page.dart:305:12: Context: Found this candidate, but the arguments don't match.
return Scaffold(
 ^^^^^^^^
lib/screens/calcul_game_page.dart:311:17: Error: Constant expression expected.
Try inserting 'const'.
icon: Icon(Icons.arrow_back, color: Colors.black, size: kIconSize),
^^^^
lib/screens/calcul_game_page.dart:312:41: Error: Undefined name 'context'.
onPressed: () => Navigator.of(context).pop(),
^^^^^^^
lib/screens/calcul_game_page.dart:312:38: Error: Method invocation is not a constant expression.
onPressed: () => Navigator.of(context).pop(),
 ^^
lib/screens/calcul_game_page.dart:312:50: Error: Method invocation is not a constant expression.
onPressed: () => Navigator.of(context).pop(),
 ^^^
lib/screens/calcul_game_page.dart:312:22: Error: Not a constant expression.
onPressed: () => Navigator.of(context).pop(),
 ^^
lib/screens/calcul_game_page.dart:310:18: Error: Constant expression expected.
Try inserting 'const'.
leading: IconButton(
 ^^^^^^^^^^
lib/screens/calcul_game_page.dart:317:18: Error: Constant expression expected.
Try inserting 'const'.
style: TextStyle(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:315:16: Error: Constant expression expected.
Try inserting 'const'.
title: Text(
 ^^^^
lib/screens/calcul_game_page.dart:307:15: Error: Constant expression expected.
Try inserting 'const'.
appBar: AppBar(
^^^^^^
lib/screens/calcul_game_page.dart:307:15: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
appBar: AppBar(
^^^^^^
lib/screens/calcul_game_page.dart:325:29: Error: Constant expression expected.
Try inserting 'const'.
padding: EdgeInsets.all(kPaddingLarge),
^^^
lib/screens/calcul_game_page.dart:331:22: Error: Constant expression expected.
Try inserting 'const'.
style: TextStyle(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:329:13: Error: Constant expression expected.
Try inserting 'const'.
Text(
^^^^
lib/screens/calcul_game_page.dart:339:13: Error: Constant expression expected.
Try inserting 'const'.
SizedBox(height: kSizedBoxHeightMedium),
^^^^^^^^
lib/screens/calcul_game_page.dart:343:35: Error: Constant expression expected.
Try inserting 'const'.
padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
^^^^^^^^^
lib/screens/calcul_game_page.dart:346:44: Error: Constant expression expected.
Try inserting 'const'.
borderRadius: BorderRadius.circular(kBorderRadiusLarge),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:346:44: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
borderRadius: BorderRadius.circular(kBorderRadiusLarge),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:347:32: Error: Constant expression expected.
Try inserting 'const'.
border: Border.all(color: kPrimaryColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:347:32: Error: Cannot invoke a non-'const' factory where a const expression is expected.
Try using a constructor or factory that is 'const'.
border: Border.all(color: kPrimaryColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:350:41: Error: Method invocation is not a constant expression.
color: Colors.black.withOpacity(0.05),
^^^^^^^^^^^
lib/screens/calcul_game_page.dart:353:29: Error: Constant expression expected.
Try inserting 'const'.
offset: Offset(kOffsetX, kOffsetY),
^^^^^^
lib/screens/calcul_game_page.dart:349:19: Error: Constant expression expected.
Try inserting 'const'.
BoxShadow(
^^^^^^^^^
lib/screens/calcul_game_page.dart:348:28: Error: Constant expression expected.
Try inserting 'const'.
boxShadow: [
 ^
lib/screens/calcul_game_page.dart:344:27: Error: Constant expression expected.
Try inserting 'const'.
decoration: BoxDecoration(
^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:359:24: Error: Constant expression expected.
Try inserting 'const'.
style: TextStyle(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:358:17: Error: Undefined name '_currentQuestion'.
_currentQuestion,
^^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:357:22: Error: Constant expression expected.
Try inserting 'const'.
child: Text(
 ^^^^
lib/screens/calcul_game_page.dart:342:13: Error: Constant expression expected.
Try inserting 'const'.
Container(
^^^^^^^^^
lib/screens/calcul_game_page.dart:342:13: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
Container(
^^^^^^^^^
lib/screens/calcul_game_page.dart:367:13: Error: Constant expression expected.
Try inserting 'const'.
SizedBox(height: kSizedBoxHeightLarge),
^^^^^^^^
lib/screens/calcul_game_page.dart:373:36: Error: Constant expression expected.
Try inserting 'const'.
margin: EdgeInsets.only(bottom: kPaddingMedium),
 ^^^^
lib/screens/calcul_game_page.dart:376:46: Error: Constant expression expected.
Try inserting 'const'.
borderRadius: BorderRadius.circular(kBorderRadius),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:376:46: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
borderRadius: BorderRadius.circular(kBorderRadius),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:377:34: Error: Constant expression expected.
Try inserting 'const'.
border: Border.all(color: kBorderColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:377:34: Error: Cannot invoke a non-'const' factory where a const expression is expected.
Try using a constructor or factory that is 'const'.
border: Border.all(color: kBorderColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:380:43: Error: Method invocation is not a constant expression.
color: Colors.black.withOpacity(0.08),
^^^^^^^^^^^
lib/screens/calcul_game_page.dart:383:31: Error: Constant expression expected.
Try inserting 'const'.
offset: Offset(kOffsetX, kOffsetY),
^^^^^^
lib/screens/calcul_game_page.dart:379:21: Error: Constant expression expected.
Try inserting 'const'.
BoxShadow(
^^^^^^^^^
lib/screens/calcul_game_page.dart:378:30: Error: Constant expression expected.
Try inserting 'const'.
boxShadow: [
 ^
lib/screens/calcul_game_page.dart:374:29: Error: Constant expression expected.
Try inserting 'const'.
decoration: BoxDecoration(
^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:388:46: Error: Constant expression expected.
Try inserting 'const'.
borderRadius: BorderRadius.circular(kBorderRadius),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:388:46: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
borderRadius: BorderRadius.circular(kBorderRadius),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:392:47: Error: Undefined name 'context'.
RenderBox renderBox = context.findRenderObject() as RenderBox;
^^^^^^^
lib/screens/calcul_game_page.dart:393:37: Error: Not a constant expression.
_points.add(details.localPosition);
^^^^^^^
lib/screens/calcul_game_page.dart:393:25: Error: Undefined name '_points'.
_points.add(details.localPosition);
^^^^^^^
lib/screens/calcul_game_page.dart:393:33: Error: Method invocation is not a constant expression.
_points.add(details.localPosition);
^^^
lib/screens/calcul_game_page.dart:391:32: Error: Not a constant expression.
setState(() {
 ^^
lib/screens/calcul_game_page.dart:391:23: Error: Method not found: 'setState'.
setState(() {
^^^^^^^^
lib/screens/calcul_game_page.dart:390:34: Error: Not a constant expression.
onPanUpdate: (details) {
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:397:23: Error: Undefined name '_points'.
_points.add(null);
^^^^^^^
lib/screens/calcul_game_page.dart:397:31: Error: Method invocation is not a constant expression.
_points.add(null);
^^^
lib/screens/calcul_game_page.dart:396:31: Error: Not a constant expression.
onPanEnd: (details) {
^^^^^^^^^
lib/screens/calcul_game_page.dart:400:47: Error: Undefined name '_points'.
painter: DrawingPainter(_points),
^^^^^^^
lib/screens/calcul_game_page.dart:400:32: Error: Can't use 'DrawingPainter' because it is declared more than once.
painter: DrawingPainter(_points),
 ^
lib/screens/calcul_game_page.dart:406:34: Error: Undefined name '_points'.
child: _points.isEmpty
 ^^^^^^^
lib/screens/calcul_game_page.dart:410:35: Error: Constant expression expected.
Try inserting 'const'.
Icon(
^^^^
lib/screens/calcul_game_page.dart:415:35: Error: Constant expression expected.
Try inserting 'const'.
SizedBox(height: kSizedBoxHeightMedium),
^^^^^^^^
lib/screens/calcul_game_page.dart:418:44: Error: Constant expression expected.
Try inserting 'const'.
style: TextStyle(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:416:35: Error: Constant expression expected.
Try inserting 'const'.
Text(
^^^^
lib/screens/calcul_game_page.dart:409:43: Error: Constant expression expected.
Try inserting 'const'.
children: [
^
lib/screens/calcul_game_page.dart:407:31: Error: Constant expression expected.
Try inserting 'const'.
? Column(
^^^^^^
lib/screens/calcul_game_page.dart:405:32: Error: Constant expression expected.
Try inserting 'const'.
child: Center(
 ^^^^^^
lib/screens/calcul_game_page.dart:402:30: Error: Constant expression expected.
Try inserting 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:402:30: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:399:28: Error: Constant expression expected.
Try inserting 'const'.
child: CustomPaint(
 ^^^^^^^^^^^
lib/screens/calcul_game_page.dart:389:26: Error: Constant expression expected.
Try inserting 'const'.
child: GestureDetector(
 ^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:389:26: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
child: GestureDetector(
 ^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:387:24: Error: Constant expression expected.
Try inserting 'const'.
child: ClipRRect(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:371:22: Error: Constant expression expected.
Try inserting 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:371:22: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:370:13: Error: Constant expression expected.
Try inserting 'const'.
Expanded(
^^^^^^^^
lib/screens/calcul_game_page.dart:442:21: Error: Method not found: '_generateQuestion'.
_generateQuestion();
^^^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:441:26: Error: Not a constant expression.
onTap: () {
 ^^
lib/screens/calcul_game_page.dart:445:41: Error: Constant expression expected.
Try inserting 'const'.
padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
^^^^^^^^^
lib/screens/calcul_game_page.dart:448:50: Error: Constant expression expected.
Try inserting 'const'.
borderRadius: BorderRadius.circular(kBorderRadiusLarge),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:448:50: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
borderRadius: BorderRadius.circular(kBorderRadiusLarge),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:449:38: Error: Constant expression expected.
Try inserting 'const'.
border: Border.all(color: kPrimaryColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:449:38: Error: Cannot invoke a non-'const' factory where a const expression is expected.
Try using a constructor or factory that is 'const'.
border: Border.all(color: kPrimaryColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:452:47: Error: Method invocation is not a constant expression.
color: Colors.black.withOpacity(0.08),
^^^^^^^^^^^
lib/screens/calcul_game_page.dart:455:35: Error: Constant expression expected.
Try inserting 'const'.
offset: Offset(kOffsetX, kOffsetY),
^^^^^^
lib/screens/calcul_game_page.dart:451:25: Error: Constant expression expected.
Try inserting 'const'.
BoxShadow(
^^^^^^^^^
lib/screens/calcul_game_page.dart:450:34: Error: Constant expression expected.
Try inserting 'const'.
boxShadow: [
 ^
lib/screens/calcul_game_page.dart:446:33: Error: Constant expression expected.
Try inserting 'const'.
decoration: BoxDecoration(
^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:461:30: Error: Constant expression expected.
Try inserting 'const'.
style: TextStyle(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:459:28: Error: Constant expression expected.
Try inserting 'const'.
child: Text(
 ^^^^
lib/screens/calcul_game_page.dart:444:26: Error: Constant expression expected.
Try inserting 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:444:26: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:440:17: Error: Constant expression expected.
Try inserting 'const'.
GestureDetector(
^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:440:17: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
GestureDetector(
^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:474:21: Error: Method invocation is not a constant expression.
_showValidationDialog();
^^^^^^^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:472:26: Error: Not a constant expression.
onTap: () {
 ^^
lib/screens/calcul_game_page.dart:477:41: Error: Constant expression expected.
Try inserting 'const'.
padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
^^^^^^^^^
lib/screens/calcul_game_page.dart:480:50: Error: Constant expression expected.
Try inserting 'const'.
borderRadius: BorderRadius.circular(kBorderRadiusLarge),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:480:50: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
borderRadius: BorderRadius.circular(kBorderRadiusLarge),
 ^^^^^^^^
lib/screens/calcul_game_page.dart:481:38: Error: Constant expression expected.
Try inserting 'const'.
border: Border.all(color: kPrimaryColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:481:38: Error: Cannot invoke a non-'const' factory where a const expression is expected.
Try using a constructor or factory that is 'const'.
border: Border.all(color: kPrimaryColor, width: 2),
 ^^^
lib/screens/calcul_game_page.dart:484:47: Error: Method invocation is not a constant expression.
color: Colors.black.withOpacity(0.08),
^^^^^^^^^^^
lib/screens/calcul_game_page.dart:487:35: Error: Constant expression expected.
Try inserting 'const'.
offset: Offset(kOffsetX, kOffsetY),
^^^^^^
lib/screens/calcul_game_page.dart:483:25: Error: Constant expression expected.
Try inserting 'const'.
BoxShadow(
^^^^^^^^^
lib/screens/calcul_game_page.dart:482:34: Error: Constant expression expected.
Try inserting 'const'.
boxShadow: [
 ^
lib/screens/calcul_game_page.dart:478:33: Error: Constant expression expected.
Try inserting 'const'.
decoration: BoxDecoration(
^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:493:30: Error: Constant expression expected.
Try inserting 'const'.
style: TextStyle(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:491:28: Error: Constant expression expected.
Try inserting 'const'.
child: Text(
 ^^^^
lib/screens/calcul_game_page.dart:476:26: Error: Constant expression expected.
Try inserting 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:476:26: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
child: Container(
 ^^^^^^^^^
lib/screens/calcul_game_page.dart:471:17: Error: Constant expression expected.
Try inserting 'const'.
GestureDetector(
^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:471:17: Error: Cannot invoke a non-'const' constructor where a const expression is expected.
Try using a constructor or factory that is 'const'.
GestureDetector(
^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:438:25: Error: Constant expression expected.
Try inserting 'const'.
children: [
^
lib/screens/calcul_game_page.dart:436:13: Error: Constant expression expected.
Try inserting 'const'.
Row(
^^^
lib/screens/calcul_game_page.dart:327:21: Error: Constant expression expected.
Try inserting 'const'.
children: [
^
lib/screens/calcul_game_page.dart:326:16: Error: Constant expression expected.
Try inserting 'const'.
child: Column(
 ^^^^^^
lib/screens/calcul_game_page.dart:324:13: Error: Constant expression expected.
Try inserting 'const'.
body: Padding(
^^^^^^^
lib/screens/calcul_game_page.dart:513:50: Error: Undefined name '_correctAnswer'.
String content = 'Le résultat correct est : $_correctAnswer.\n\nVous devez implémenter la reconnaissance de votre dessin ici pour vérifier votre réponse.';
 ^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:516:16: Error: Undefined name 'context'.
context: context,
 ^^^^^^^
lib/screens/calcul_game_page.dart:525:17: Error: Method not found: '_generateQuestion'.
_generateQuestion(); // Generate new question after validation
^^^^^^^^^^^^^^^^^
lib/screens/calcul_game_page.dart:327:21: Error: Non-constant list literal is not a constant expression.
children: [
^
Target kernel_snapshot_program failed: Exception


FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:compileFlutterBuildDebug'.
> Process 'command 'C:\Users\theke\Downloads\flutter\bin\flutter.bat'' finished with non-zero exit value 1

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
> Get more help at https://help.gradle.org.

BUILD FAILED in 4s
Running Gradle task 'assembleDebug'...5,0s
Error: Gradle task assembleDebug failed with exit code 1