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
