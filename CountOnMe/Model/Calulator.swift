//
//  Calulator.swift
//  CountOnMe
//
//  Created by Adam Mokhtar on 24/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

  var delegate : CalculatorDelegate?

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


  //----------------------------------------------------------------------------
  // MARK: - Calculator
  //----------------------------------------------------------------------------

  var elements: [String] {
    return textModel.split(separator: " ").map {String($0)}
  }

  var textModel = ""

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



  func addition () {
    if expressionHaveResult(textModel: textModel) {
      textModel = ""
    }
    if expressionIsCorrect(elements: elements) {
      textModel.append(" + ")
      delegate?.mergeCompute(textModel: textModel)
    } else {
      delegate?.additionErrorDisplay()
    }
  }

  func substraction () {
    if expressionHaveResult(textModel: textModel) {
      textModel = ""
    }
    if expressionIsCorrect(elements: elements) {
      textModel.append(" - ")
      delegate?.mergeCompute(textModel: textModel)
    } else {
      delegate?.substractionErrorDisplay()
    }
  }

  func multiplication () {

    if !dontAddSign(textModel: textModel) &&
      expressionIsCorrect(elements: elements) {
      textModel.append(" * ")
      delegate?.mergeCompute(textModel: textModel)
    } else {
      delegate?.multiplicationErrorDisplay()
    }
  }

  func divide () {

    if !dontAddSign(textModel: textModel) &&
      expressionIsCorrect(elements: elements) {
      textModel.append(" / ")
      delegate?.mergeCompute(textModel: textModel)
    } else {
      delegate?.divideErrorDisplay()
    }
  }

}
