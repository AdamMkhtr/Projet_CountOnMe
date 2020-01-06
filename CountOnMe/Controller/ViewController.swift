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

  var calculator = Calculator()

  var elements: [String] {
    return textView.text.split(separator: " ").map {String($0)}
  }

  // Error check computed variables
  var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  // au moins 3 éléments dans le tableau pour faire un calcul
  var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
  }
  // si le dernier element est un symbole on calcul pas
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-"
  }

  var expressionHaveResult: Bool {
    return textView.text.firstIndex(of: "=") != nil
  }


  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /******************** View Did Load ********************/

  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  /******************** Alert ********************/

  func alert(message: String) {
    let alertVC = UIAlertController(title: "Zéro!",
                                    message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }

  //----------------------------------------------------------------------------
  // MARK: - Number
  //----------------------------------------------------------------------------

  // View actions
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    if expressionHaveResult {
      textView.text = ""
    }
    textView.text.append(numberText)
  }

  //----------------------------------------------------------------------------
  // MARK: - Operator
  //----------------------------------------------------------------------------

  // si on appuis sur un autre opérateur envoie un message
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
    if canAddOperator {
      textView.text.append(" + ")
    } else {
      alert(message: "Un operateur est déja mis!")
    }
  }

  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    if canAddOperator {
      textView.text.append(" - ")
    } else {
      alert(message: "Un operateur est déja mis!")
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Equal
  //----------------------------------------------------------------------------

  // 1 = error    1 + = error
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    guard expressionIsCorrect else {
      return alert(message: "Entrez une expression correcte !")
    }

    guard expressionHaveEnoughElement else {
      return alert(message: "Démarrez un nouveau calcul !")
    }

    calculator.compute(elements: elements)

    textView.text.append(" = \(elements.first!)")
  }

}

