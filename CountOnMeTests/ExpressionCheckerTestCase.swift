//
//  ExpressionCheckerTestCase.swift
//  CountOnMeTest
//
//  Created by Adam Mokhtar on 03/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class ExpressionCheckerTestCase: XCTestCase {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var arrayOfSigns = ["+","-"]

  let arrayOfElements = ["+", "1"]

  let arrayOfThreeElements = ["","",""]

  let arrayWithEqual = ["","="]

  //----------------------------------------------------------------------------
  // MARK: - Test
  //----------------------------------------------------------------------------

  func testGivenArray_WhenTheLastElementsIsSigns_ThenTestReturnFalse() {

    XCTAssert(ExpressionChecker.expressionIsCorrect(elements: arrayOfSigns)
      == false)
  }

  func testGivenArray_WhenTheLastElementsIsnotSigns_ThenTestReturnTrue() {

    XCTAssert(ExpressionChecker.expressionIsCorrect(elements: arrayOfElements)
      == true)
  }

  func testGivenArray_WhenTwoElements_ThenTestReturnFalse() {

    XCTAssert(ExpressionChecker.expressionHaveEnoughElement(elements: arrayOfElements)
        == false)
  }

  func testGivenArray_WhenThreeElements_ThenTestReturnTrue() {

    XCTAssert(ExpressionChecker.expressionHaveEnoughElement(elements: arrayOfThreeElements) == true)
  }

  func testGivenString_WhenContainsEqual_ThenTestReturnTrue() {

    XCTAssert(ExpressionChecker.expressionHaveResult(textView: "1 + 1 = 2"))
  }

  func testGivenString_WhenContainsEqual_ThenTestReturnFalse() {

    XCTAssert(ExpressionChecker.expressionHaveResult(textView: "1 + 1 ")
      == false)
  }
  

}

// enlevé array...
