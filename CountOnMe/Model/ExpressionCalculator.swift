//
//  ExpressionCalculator.swift
//  CountOnMe
//
//  Created by Adam Mokhtar on 07/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class ExpressionCalculator {


  func compute(elements: [String]) -> String?{

    let compute = NSExpression(format: elements[0])
    let mathValue = compute.expressionValue(with: nil, context: nil) as? String
    return mathValue
  }

}
