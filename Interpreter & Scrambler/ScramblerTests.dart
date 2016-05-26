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
import 'Scrambler.dart';

/// Tests For Scrambler
class ScramblerTests extends Scrambler{
  
  void RunAll(){
    ScrambleExpressionsTests();
    ExtractParensTests();
  }
  
  // Scrambled Expressions should be the same length as their originals
  void ScrambleExpressionsTests(){
    print("SCRAMBLE EXPRESSIONS TESTS ==========================================");    			print("Test 0 Passed? : ${ScrambleExpression("true").length == "true".length}");
    print("Test 1 Passed? : ${ScrambleExpression("false").length == "false".length}");
    print("Test 2 Passed? : ${ScrambleExpression("(not true)").length 
          == "(not true)".length}");
    print("Test 3 Passed? : ${ScrambleExpression("(not false)").length 
          == "(not false)".length}");
    print("Test 4 Passed? : ${ScrambleExpression("(and true true)").length 
          == "(and true true)".length}");
    print("Test 5 Passed? : ${ScrambleExpression("(and true false)").length 
          == "(and true false)".length}");
    print("Test 6 Passed? : ${ScrambleExpression("(or true false").length 
          == "(or true false".length}");
    print("Test 7 Passed? : ${ScrambleExpression("(or false false)").length 
          == "(or false false)".length}");
    print("Test 8 Passed? : ${ScrambleExpression("(not (and true false))").length 
          == "(not (and true false))".length}");
    print("Test 9 Passed? : ${ScrambleExpression("(not (not (not true)))").length 
          == "(not (not (not true)))".length}");
    print("Test 10 Passed? : ${
          ScrambleExpression("(not (and (or true false) (not true)))").length 
          == "(not (and (or true false) (not true)))".length}");
  }
  
  // Extracted Parens should stay in the correct index
  void ExtractParensTests(){
    print("EXTRACT PARENS TESTS ==========================================");
    print("Test 0 Passed? : ${ExtractParens("true").toString() == "[_]"}");
    print("Test 1 Passed? : ${ExtractParens("(not false)").toString() == "[(, )]"}");
    print("Test 2 Passed? : ${ExtractParens("(and true false)").toString() 
          == "[(, _, )]"}");
    print("Test 3 Passed? : ${ExtractParens("(and (not true) false)").toString() 
          == "[(, (, ), )]"}");
    print("Test 4 Passed? : ${
          ExtractParens("(and (or true false) (not false))").toString() 
          == "[(, (, _, ), (, ))]"}");
  }
  
  // Note: Testing randomized functions can be difficult :P
}