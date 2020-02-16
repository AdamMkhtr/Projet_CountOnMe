//
//  ExpressionCalculator.swift
//  CountOnMe
//
//  Created by Adam Mokhtar on 07/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class ExpressionCalculator {

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
}
