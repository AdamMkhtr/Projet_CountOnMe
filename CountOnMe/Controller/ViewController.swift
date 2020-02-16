//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Outlet
  //----------------------------------------------------------------------------

  @IBOutlet weak var textView: UITextView!

  @IBOutlet var numberButtons: [UIButton]!

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var expressionCalculator = ExpressionCalculator()

  var elements: [String] {
    return textView.text.split(separator: " ").map {String($0)}
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /******************** View Did Load ********************/

  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    textView.isEditable = false
    textView.text = ""
  }

  /******************** Alert ********************/

  /// Present alerte.
  /// - Parameter message: Choose message.
  func displayAlert(message: String) {
    let alertVC = UIAlertController(title: "Erreur!",
                                    message: message,
                                    preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }

  //----------------------------------------------------------------------------
  // MARK: - Number
  //----------------------------------------------------------------------------

  /// Add number for compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    if ExpressionChecker.expressionHaveResult(textView: textView.text) {
      textView.text = ""
    }
    textView.text.append(numberText)
  }

  //----------------------------------------------------------------------------
  // MARK: - Operator
  //----------------------------------------------------------------------------

  /// Add plus in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
    if ExpressionChecker.expressionHaveResult(textView: textView.text) {
      textView.text = ""
    }
    if ExpressionChecker.expressionIsCorrect(elements: elements) {
      textView.text.append(" + ")
    } else {
      displayAlert(message: "Un operateur est déja mis!")
    }
  }

  /// Add minus in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    if ExpressionChecker.expressionHaveResult(textView: textView.text) {
      textView.text = ""
    }
    if ExpressionChecker.expressionIsCorrect(elements: elements) {
      textView.text.append(" - ")
    } else {
      displayAlert(message: "Un operateur est déja mis!")
    }
  }

  /// Add multiply sign in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedMutiplicationButton(_ sender: UIButton) {
    if ExpressionChecker.expressionIsCorrect(elements: elements) {
      textView.text.append(" * ")
    } else {
      displayAlert(message: "Un operateur est déja mis!")
    }
  }

  /// Add divided sign in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedDivideButton(_ sender: UIButton) {
    if ExpressionChecker.expressionIsCorrect(elements: elements) {
      textView.text.append(" / ")
    } else {
      displayAlert(message: "Un operateur est déja mis!")
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Clear
  //----------------------------------------------------------------------------

  /// Remove the elements of the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedClearExpression(_ sender: UIButton) {
    textView.text = ""
  }

  //----------------------------------------------------------------------------
  // MARK: - Equal
  //----------------------------------------------------------------------------

  /// Check if the last elements of the compute is sign and that there is three elements minus in the compute.
  private func isAbleToComputeResult() -> Bool {
    guard ExpressionChecker.expressionIsCorrect(elements: elements) else
    {
      displayAlert(message: "Entrez une expression correcte !")
      return false
    }
    guard ExpressionChecker.expressionHaveEnoughElement(elements: elements) else
    {
      displayAlert(message: "Démarrez un nouveau calcul !")
      return false
    }
    return true
  }

  /// Compute elements.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    guard !ExpressionChecker.expressionHaveResult(textView: textView.text) else {
      return displayAlert(message: "Il n'y à pas de calcul")

    }

    guard isAbleToComputeResult(), let counting = textView.text  else {
      return
    }

    let result = expressionCalculator.compute(elements:counting) ?? "Error"

    textView.text.append(" = \(result) ")

  }
}
