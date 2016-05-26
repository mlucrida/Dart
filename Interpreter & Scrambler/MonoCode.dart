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

/* 
 * class containing all the necessary
 * functionality to interpret boolean
 * expressions
 */
class Interpreter{  
  
  /// Shows the result on the webpage
  void ShowResult(Event e){
    // get the expression
    String expr = (querySelector('#inputText') as InputElement).value;
    // get the result
    bool result = Interp(expr);
    // display the result
    (querySelector('#outputText') as InputElement).value = result.toString().toUpperCase();  
  }
  
  /// Main interpret function
  bool Interp(String expr){
    // get the first operation of the expression
    String operation = GetOperation(expr);  
    // get the arguments of the expression
    List<String> args = GetArguments(expr); 
    
    // recursively calls interpret based on the operation
    switch(operation){ 
      case "true":
        return true;
      case "false":
        return false;
      case "not":
        return !Interp(args.join(' '));
      case "and":
        return (Interp(args[0]) && Interp(args[1]));
      case "or":
        return (Interp(args[0]) || Interp(args[1]));
      default:
        print("Error, Invalid Input : $expr");
        return null;
    }
	}
  
  /// Function that gets the immediate operation of an expression
  String GetOperation(String expr){
    // converts string to list, gets the first element, sets it back to a string
    // and removes the front parentheses
    return expr.split(' ').first.toString().replaceFirst(r'(', '');
  }
  
    /// Identifies the arguements to an expression
  List<String> GetArguments(String expr){
    // convert to string to list for analysis
    var args = expr.split(' '); 
    
    // return if single argument expressions
    if(args.first == "true" || args.first == "false"){
      return args;
    }
    // get the operator of the expression    
    String op = args.first;
    
    // remove the operator and last parentheses
    args.remove(args.first);
    args[args.length-1] = args.last.toString().replaceFirst(r')', '');

    // checks for nested and/or expresssions as arguments
    if(op != "(not" && args.length > 1 && args.join(' ').contains('(', 0)){
      // convert to string
      args = args.join(' ');
      // find parameter index
      int index = GetIndex(args);
      // create list to contain parameters
      List<String> arguments = new List<String>();
      // input the first parameter
      arguments.add(args.substring(0, index));
      // input the second parameter
      arguments.add(args.substring(index+1, args.length)); 
      
      // return nested arguments
      return arguments; 
    }
    // return negation (not) arguments
    return args; 
  }
  
  /// Function that returns the index needed to identify two parameters
  int GetIndex(String expr){
    int open = 0;
    int closed = 0;
    int index = 0;
    // counts parentheses to identify parameters
    // similar to Leap0 java implementation
    do{
      if(expr.substring(index, index+1) == '(')
        open++;
      if(expr.substring(index, index+1) == ')')
        closed++;
      index++;
    }while(open != closed);
    return index;
  } 
}

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

/*
 * Leap1 Shine
 * Scrambler class scrambles operators and arguments
 * of truing expresssions, and then interprets them
 */ 
class Scrambler extends Interpreter{
  
  /// Main scramble function
  void Scramble(Event e){
    // get the expression from the text box
    String expr = (querySelector('#inputText') as InputElement).value;
    // references all display boxes and puts them into a list
    List<Element> Displays = querySelectorAll('input[type=display]'); 
    // references all results boxes and puts them into a list
    List<Element> Results = querySelectorAll('input[type=results]'); 
    
    // sets each display box with a scrambled version of the initial expression
    for(var text in Displays){
      (text as InputElement).value = ScrambleExpression(expr);
    }
    
    // interpret the results of each scrambled expresssion and shows thier results
    int count = 0;
    for(var text in Results){
      // formats boolean result into a all caps string
      (text as InputElement).value = Interp((Displays[count] as InputElement).value)
        																	 .toString().toUpperCase(); 
      // next iteration
      count++;
    }
  }
  
  /// helper function that scrambles either arguments or operators of the expression
  String ScrambleExpression(String expr){
    List<String> arguments = ["true", "false"];
    List<String> operators = ["and", "or"]; 
    // (no point in scrambling not since it only takes a single argument)
    
    expr = ScrambleInput(expr, arguments); // scrambles arguments first
    expr = ScrambleInput(expr, operators); // scrambles operaters second
    
    return expr;
  }
  
  /// function that contains the scrambling algorithm
  String ScrambleInput(String expr, List<String> elements){
    // set the expression to a dynamic type
    var arg = expr; 
    // extract the parentheses from the expression into a list
    List<String> parens = ExtractParens(arg);
    
    // remove parentheses and convert expression into a list
    arg = arg.replaceAll(r'(', '')
             .replaceAll(r')', '')
             .split(' ');
    
    // initialize a new list that will contain the new expression
    List<String> newExpr = new List<String>(); 
    newExpr.addAll(arg);
    
    // keep either operators or arguments the expresssion (depending on call)
    arg.retainWhere((item) => item == elements[0] || item == elements[1]);
    
    // shuffle the remaining elements of the expression 
    arg.shuffle();
    
    // replace the arguments or operators with the random list
    for(int i = 0; i < newExpr.length; i++){
      if(newExpr[i] == elements[0] || newExpr[i] == elements[1]){
        newExpr[i] = arg.first;
        arg.remove(arg.first);
      }
    }
    
    // put the parentheses back into the expression
    newExpr = InsertParens(newExpr,parens);
    
    // return the new expression
    return newExpr.join(' ');
  }
  
  /// function that extracts parentheses from expression
  List<String> ExtractParens(String expr){
    // set expression to list
    var parens = expr.split(' ');
    
    // iterate through elements of the expression
    for(int i = 0; i < parens.length; i++){
      // extract parentheses with the substring method
      if(parens[i].contains('(')){
        parens[i] = parens[i].substring(parens[i].indexOf('('), parens[i].lastIndexOf('(')+1);
      }
      else{if(parens[i].contains(')')){
        parens[i] = parens[i].substring(parens[i].indexOf(')'), parens[i].lastIndexOf(')')+1);
      }
      else{
        // place holder when no parentheses are pressent 
        parens[i] = '_'; 
      }}
    }
    
    // return the list
    return parens;
  }

  
  /// function the puts the parentheses back into expression
  List<String> InsertParens(List<String> expr, List<String> parens){
    // iterate through parentheses list (previously extracted from expression)
    for(int i = 0; i < parens.length; i++){
      // insert open parentheses to the front of the string
      if(parens[i].contains('(')){
        expr[i] = (parens[i] + expr[i]);
      }
      // append closed parentheses to the end of the string
      if(parens[i].contains(')')){
        expr[i] = (expr[i] + parens[i]);
      }
    }
    
    // return new expression
    return expr;
  }
}

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