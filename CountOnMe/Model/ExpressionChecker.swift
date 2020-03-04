//
//  Button.swift
//  CountOnMe
//
//  Created by Adam Mokhtar on 01/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class ExpressionChecker {

  /// Check if the last elements of the array is a signs.
  /// - Parameter elements: element to test.
   static func expressionIsCorrect(elements: [String]) -> Bool {
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
  static func expressionHaveEnoughElement(elements: [String]) -> Bool {
    return elements.count >= 3
  }

  /// Check if the expression contains "=".
  /// - Parameter textView: element to test
  static func expressionHaveResult(textView: String) -> Bool {
    return textView.firstIndex(of: "=") != nil
  }

  /// Check if the expression is empty
  /// - Parameter textView: element to test
  static func dontAddSign (textView: String) -> Bool {
    return textView == ""
  }

}
