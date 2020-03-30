//
//  Calulator.swift
//  CountOnMe
//
//  Created by Adam Mokhtar on 24/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var delegate : CalculatorDelegate?
  
  var elements: [String] {
    return textModel.split(separator: " ").map {String($0)}
  }
  
  var textModel = ""
  
  //----------------------------------------------------------------------------
  // MARK: - ExpressionChecker
  //----------------------------------------------------------------------------
  
  /// Check if the last elements of the array is a signs.
  /// - Parameter elements: element to test.
  func expressionIsCorrect(elements: [String]) -> Bool {
    let signs = ["+","-","*","/"]
    for sign in signs {
      if elements.last == sign {
        return false
      }
    }
    return true
  }
  
  /// Check if the array of String contains minimum three elements.
  /// - Parameter elements: element to test
  func expressionHaveEnoughElement(elements: [String]) -> Bool {
    return elements.count >= 3
  }
  
  /// Check if the expression contains "=".
  /// - Parameter textModel: element to test
  func expressionHaveResult(textModel: String) -> Bool {
    return textModel.firstIndex(of: "=") != nil
  }
  
  /// Check if the expression is empty
  /// - Parameter textModel: element to test
  func dontAddSign (textModel: String) -> Bool {
    return textModel == ""
  }
  
  /******************** Signs Checker ********************/
  
  /// Use all checker func and add the sign
  /// - Parameter sign: sign to add
  func checkerSigns (sign: String) {
    if expressionHaveResult(textModel: textModel) {
      textModel = ""
    }
    if expressionIsCorrect(elements: elements) {
      textModel.append(sign)
      delegate?.didCompute(textModel: textModel)
    } else {
      delegate?.didAddOperatorFail()
    }
  }
  
  /******************** Equal Checker ********************/
  
  /// Check if the last elements of the compute is sign and that there is three elements minus in the compute.
  private func isAbleToComputeResult() -> Bool {
    guard expressionIsCorrect(elements: elements) else
    {
      delegate?.didExpressionErrorDisplay()
      return false
    }
    guard expressionHaveEnoughElement(elements: elements) else
    {
      delegate?.didEqualErrorDisplay()
      return false
    }
    return true
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Calculator
  //----------------------------------------------------------------------------
  
  /// Add comma zero to all number.
  /// - Parameter item: added the action at the element.
  func addCommaZero(item: String) -> String? {
    var numbers: [String] = []
    for value in 0..<10 {
      let digit = String(value) + " "
      numbers.append(digit)
    }
    var formattedText = item + " "
    for number in numbers {
      guard let firstCharacter = number.first else {
        return nil
      }
      let newNumber = String(firstCharacter) + ".0"
      formattedText = formattedText.replacingOccurrences(of: number,
                                                         with: newNumber)
    }
    return formattedText
  }
  
  /// Compute elements and know compute decimale point.
  /// - Parameter elements: elements to calculate.
  func compute(elements: String) -> String?{
    guard let formatedText = addCommaZero(item: elements) else {return nil}
    let compute = NSExpression(format: formatedText)
    guard let mathValue =
      compute.expressionValue(with: nil, context: nil) as? Double else {
        return nil
    }
    return String(mathValue)
  }
  
  /******************** Clear ********************/
  
  /// Clear the expression
  func clear() {
    textModel = ""
    delegate?.didCompute(textModel: textModel)
  }
  
  /******************** Number Taped ********************/
  
  /// Add number at expression
  /// - Parameter number: number to add
  func addNumber(number: String) {
    if expressionHaveResult(textModel: textModel) {
      textModel = ""
    }
    textModel += number
    delegate?.didCompute(textModel: textModel)
  }
  
  /******************** Addition ********************/
  
  /// add addition sign at the expression
  func adder() {
    checkerSigns(sign: " + ")
  }
  
  /******************** Substraction ********************/
  
  /// add substraction sign at the expression
  func subtract() {
    checkerSigns(sign: " - ")
  }
  
  /******************** Multiplication ********************/
  
  /// add multiply sign at the expression but if the expression is empty return error display
  func multiply() {
    if !dontAddSign(textModel: textModel) {
      checkerSigns(sign: " * ")
    }
  }
  
  /******************** Divide ********************/
  
  /// add divide sign at the expression if the expression is empty return error display
  func divide() {
    if !dontAddSign(textModel: textModel) {
      checkerSigns(sign: " / ")
    }
  }
  
  /******************** Calculate ********************/
  
  /// Check and calculate.
  func calculate() {
    guard !expressionHaveResult(textModel: textModel) else {
      delegate?.didEqualErrorDisplay()
      return
    }
    let counting = ""
    guard isAbleToComputeResult(), counting != textModel  else {
      return
    }
    let result = compute(elements: textModel) ?? "Error"
    textModel.append(" = \(result) ")
    delegate?.didCompute(textModel: textModel)
  }
}

protocol CalculatorDelegate: class {
  func didEqualErrorDisplay()
  func didExpressionErrorDisplay()
  func didAddOperatorFail()
  func didCompute(textModel: String)
  
}
