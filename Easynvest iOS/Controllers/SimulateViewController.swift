//
//  SimulateViewController.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 01/12/17.
//

import UIKit

class SimulateViewController: UIViewController {
    @IBOutlet weak var valueTextField: TextField!
    @IBOutlet weak var expirationTextField: TextField!
    @IBOutlet weak var percentageTextField: TextField!
    @IBOutlet weak var simulateButton: Button!
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    // MARK: User Interaction
    @IBAction func simulate(_ sender: Any) {
        let calculator = Calculator(investedAmount: 0.0, rate: 0.0, maturityDate: Date())
        calculator.simulate(completion: nil)
    }
    // MARK: Additional Helpers
    /// General changes for this controller
    func setup() {
        self.title = "Simulador"
        simulateButton.setEnabled(enabled: true)
        valueTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}
