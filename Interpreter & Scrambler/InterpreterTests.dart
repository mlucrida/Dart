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

/// Class containing tests for the Interpreter
class InterpreterTests extends Interpreter{

  // function that automatically runs all the tests
  void RunAll(){
    InterpTests();
    GetOperationTests();
    GetIndexTests();
    GetArgumentsTests();
  }
  
  void InterpTests(){
    print("INTERP TESTS ==========================================");
    print("Test 0 Passed? : ${Interp("true") == true}");
    print("Test 1 Passed? : ${Interp("false") == false}");
    print("Test 2 Passed? : ${Interp("(not true)") == false}");
    print("Test 3 Passed? : ${Interp("(not false)") == true}");
    print("Test 4 Passed? : ${Interp("(and true true)") == true}");
    print("Test 5 Passed? : ${Interp("(and true false)") == false}");
    print("Test 6 Passed? : ${Interp("(or true false") == true}");
    print("Test 7 Passed? : ${Interp("(or false false)") == false}");
    print("Test 8 Passed? : ${Interp("(not (and true false))") == true}");
    print("Test 9 Passed? : ${Interp("(not (not (not true)))") == false}");
    print("Test 10 Passed? : ${Interp("(not (and (or true false) (not true)))") == true}");
  }

  void GetOperationTests(){
    print("OPERATION TESTS ==========================================");
    print("Test 0 Passed? : ${GetOperation("true") == "true"}");
    print("Test 1 Passed? : ${GetOperation("(not false)") == "not"}");
    print("Test 2 Passed? : ${GetOperation("(and true false)") == "and"}");
    print("Test 3 Passed? : ${GetOperation("(or (or true false) (not false))") == "or"}");
    print("Test 4 Passed? : ${GetOperation("(and (or true false) (not false))") == "and"}");
  }


  void GetIndexTests(){
    print("INDEX TESTS ==========================================");
    print("Test 0 Passed? : ${GetIndex("true") == 1}");
    print("Test 1 Passed? : ${GetIndex("(not false)") == 11}");
    print("Test 2 Passed? : ${GetIndex("(and true false)") == 16}");
    print("Test 3 Passed? : ${GetIndex("(or (or true false) (not false))") == 32}");
    print("Test 4 Passed? : ${GetIndex("(and (or true false) (not false))") == 33}");
  }


  void GetArgumentsTests(){
    print("ARGUMENTS TESTS ==========================================");
    print("Test 0 Passed? : ${GetArguments("true")[0] == "true"}");
    print("Test 1 Passed? : ${GetArguments("(not false)")[0] == "false"}");
    print("Test 2 Passed? : ${GetArguments("(and true false)")[0] == "true"}");
    print("Test 3 Passed? : ${GetArguments("(and true false)")[1] == "false"}");
    print("Test 4 Passed? : ${GetArguments("(and (or true false) (not false))")[0] == "(or true false)"}");
    print("Test 5 Passed? : ${GetArguments("(and (or true false) (not false))")[1] == "(not false)"}");
  }
}