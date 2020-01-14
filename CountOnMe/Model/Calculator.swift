//
//  Button.swift
//  CountOnMe
//
//  Created by Adam Mokhtar on 01/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

  func compute(elements: [String]) -> String?{

    var elements = elements

    while elements.count > 1 {
      guard let left = Int(elements[0]),let right = Int(elements[2]) else {
        return nil

      }
      let operand = elements[1]


      let result: Int
      switch operand {
      case "+": result = left + right
      case "-": result = left - right
      default: fatalError("Unknown operator !")
      }

      elements = Array(elements.dropFirst(3))
      elements.insert("\(result)", at: 0)

    }
    return elements.first
  }
}
