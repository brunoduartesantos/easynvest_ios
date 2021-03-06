//
//  SimulateViewController.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 01/12/17.
//

import UIKit

class SimulateViewController: UIViewController {
    @IBOutlet fileprivate weak var valueTextField: TextField!
    @IBOutlet fileprivate weak var expirationTextField: TextField!
    @IBOutlet fileprivate weak var percentageTextField: TextField!
    @IBOutlet fileprivate weak var simulateButton: Button!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var loadingView: UIView!

    fileprivate var currentTextField: TextField?

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: User Interaction

    @IBAction func simulate(_ sender: Any) {
        guard let valueText = valueTextField.text, !valueText.isEmpty else { return }
        guard let expirationText = expirationTextField.text, !expirationText.isEmpty else { return }
        guard let percentageText = percentageTextField.text, !percentageText.isEmpty else { return }

        guard let investedAmount = Float(valueText.formatToNumberString()) else { return }
        let maturityDate = expirationText.formatToDateString()
        guard let rate = Float(percentageText) else { return }

        var investment = Investment(
            investedAmount: investedAmount,
            yearlyInterestRate: 0,
            maturityTotalDays: 0,
            maturityBusinessDays: 0,
            maturityDate: maturityDate,
            rate: rate,
            isTaxFree: false)

        startLoading()

        investment.simulate { (calculator) in
            DispatchQueue.main.async(execute: {
                self.stopLoading()
                guard let calculator = calculator else { return }

                let resultController = ResultsViewController(calculator: calculator)
                self.navigationController?.pushViewController(resultController, animated: true)
            })
        }
    }

    @IBAction func textFieldEditingDidBegin(_ sender: TextField) {
        currentTextField = sender
    }

    // MARK: Additional Helpers

    /// General changes for this controller
    func setup() {
        self.title = "Simulador"

        simulateButton.setEnabled(enabled: true)
        setupDatePickerKeyboard()
        valueTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyBoardDidChangeFrame(notification:)),
            name: .UIKeyboardDidChangeFrame,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyBoardDidHide(notification:)),
            name: .UIKeyboardDidHide,
            object: nil)
    }

    func startLoading() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()

        UIView.animate(withDuration: 0.2) {
            self.view.bringSubview(toFront: self.loadingView)
            self.loadingView.alpha = 1
        }
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        view.sendSubview(toBack: self.loadingView)
        loadingView.alpha = 0
    }

    @objc
    /// Creates a currency mask
    func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }

    @objc
    /// Creates a date mask
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        expirationTextField.text = dateFormatter.string(from: sender.date)
    }

    /// Creates a "UIDatePicker" and set it as the "expirationTextField" input view
    func setupDatePickerKeyboard() {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.timeZone = TimeZone.current
        datePicker.locale = Locale(identifier: "pt-BR")
        datePicker.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        expirationTextField.inputView = datePicker
    }

    @objc
    /// Makes the current textfield visible if keyboard is hiding it
    func keyBoardDidChangeFrame(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            if let currentTextField = currentTextField {
                let textFieldHeight = currentTextField.frame.origin.y +
                                      currentTextField.frame.size.height +
                                      scrollView.frame.origin.y + 10
                if keyboardRectangle.origin.y < textFieldHeight {
                    let difference = textFieldHeight - keyboardRectangle.origin.y
                    scrollView.setContentOffset(CGPoint(x: 0, y: difference), animated: true)
                }
            }
        }
    }

    @objc
    /// Scroll back to the original point on keyboard hide
    func keyBoardDidHide(notification: NSNotification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
