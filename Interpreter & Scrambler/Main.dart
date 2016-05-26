/*
 * Author: Matt Lucrida
 * OPL Leap 1
 * 
 * References: 
 * https://www.dartlang.org/docs/dart-up-and-running/ch03.html#dartcore---numbers-collections-strings-and-more
 * https://api.dartlang.org/1.14.2/dart-core/String-class.html
 * https://api.dartlang.org/1.14.2/dart-core/List-class.html
 * http://www.w3schools.com/html/default.asp
 *
 */
import 'dart:html';
import 'Interpreter.dart';
import 'InterpreterTests.dart';
import 'Scrambler.dart';
import 'ScramblerTests.dart';


void main() {
  // initialize the Interpreter class
  Interpreter I = new Interpreter(); 
  // reference the Interpret button
  ButtonElement Interpret = querySelector('#Interpret'); 
  // Interpret text by clicking the button
  Interpret.onClick.listen(I.ShowResult); 
  
  // initialize the Scrambler class
  Scrambler S = new Scrambler(); 
  // reference the Scamble button
  ButtonElement Scramble = querySelector('#Scramble'); 
  // scamble and interpret the input
  Scramble.onClick.listen(S.Scramble); 
  
  /*
   * Uncomment for to see tests in
   * Console. Dart does support assertions,
   * however they are only enabled in 
   * check mode.  Unfortunately Dart Pad
   * does not support check mode.
   */
  
  //InterpreterTests IT = new InterpreterTests();
  //IT.RunAll();
  //IT.InterpTests();
  //IT.GetOperationTests();
  //IT.GetArgumentsTests();
  //IT.GetIndexTests();
  
  //ScramblerTests ST = new ScramblerTests();
  //ST.RunAll();
  //ST.ScrambleExpressionsTests();
  //ST.ExtractParensTests();
}
