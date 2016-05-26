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