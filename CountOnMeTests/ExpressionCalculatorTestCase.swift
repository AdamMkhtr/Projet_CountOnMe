//
//  ButtonTestCase.swift
//  CountOnMeTests
//
//  Created by Adam Mokhtar on 01/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class ExpressionCalculatorTestCase: XCTestCase {
  
  //----------------------------------------------------------------------------
  // MARK: - Variable
  //----------------------------------------------------------------------------
  
  var expressionCalulator = ExpressionCalculator()
  
  //----------------------------------------------------------------------------
  // MARK: - Test
  //----------------------------------------------------------------------------
  
  func testGivenNumber_WhenUseFuncAddCommaZero_ThenNumberWithZero() {
    
    XCTAssert(expressionCalulator.addCommaZero(item: "5") == "5.0")
  }
  
  func testGivenSum_WhenCompute_ThenResultIsTwo() {
    
    let expression = "1 + 1"
    
    XCTAssert(expressionCalulator.compute(elements: expression) == "2.0")
  }
  
  func testGivenSubstraction_WhenCompute_ThenResultIsZero() {
    
    let expression = "1 - 1"
    
    XCTAssert(expressionCalulator.compute(elements: expression) == "0.0")
  }
  
  func testGivenMultiplication_WhenCompute_ThenResultIsTen() {
    
    let expression = "2 * 2"
    
    XCTAssert(expressionCalulator.compute(elements: expression) == "4.0")
  }
  
  func testGivenDivision_WhenCompute_ThenResultIsTen() {
    
    let expression = "5 / 2"
    
    XCTAssert(expressionCalulator.compute(elements: expression) == "2.5")
  }
  
  func testGivenExpressionNegative_WhenCompute_ThenResultIsMinusTen() {
    
    let expression = "- 5 - 5"
    
    XCTAssert(expressionCalulator.compute(elements: expression) == "-10.0")
  }
  
  func testGivenExpression_WhenCompute_ThenResultIsTen() {
    
    let expression = "5 + 5 * 2 - 10 / 2"
    
    XCTAssert(expressionCalulator.compute(elements: expression) == "10.0")
  }
}
