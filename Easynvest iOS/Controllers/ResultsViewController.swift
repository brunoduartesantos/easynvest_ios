//
//  ResultsViewController.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 03/12/17.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet fileprivate weak var grossAmountTitle: UILabel!
    @IBOutlet fileprivate weak var grossAmountProfitTitle: UILabel!

    @IBOutlet fileprivate weak var investedAmount: UILabel!
    @IBOutlet fileprivate weak var grossAmount: UILabel!
    @IBOutlet fileprivate weak var grossAmountProfit: UILabel!
    @IBOutlet fileprivate weak var taxesAmount: UILabel!
    @IBOutlet fileprivate weak var netAmount: UILabel!

    @IBOutlet fileprivate weak var maturityDate: UILabel!
    @IBOutlet fileprivate weak var maturityTotalDays: UILabel!
    @IBOutlet fileprivate weak var monthlyGrossRateProfit: UILabel!
    @IBOutlet fileprivate weak var rate: UILabel!
    @IBOutlet fileprivate weak var rateProfit: UILabel!
    @IBOutlet fileprivate weak var annualGrossRateProfit: UILabel!

    fileprivate var calculator: Calculator?

    // MARK: Lifecycle

    init(calculator: Calculator) {
        self.calculator = calculator
        super.init(nibName: String(describing: ResultsViewController.self), bundle: nil)
    }

    init() {
        super.init(nibName: String(describing: ResultsViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: User Interaction

    @IBAction func simulateAgain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: Additional Helpers

    /// General changes for this controller
    func setup() {
        self.title = "Resultado"
        fillAllLabels()
    }

    func fillAllLabels() {
        guard let calculator = calculator else { return }

        grossAmountTitle.text = String.floatToCurrecyString(calculator.grossAmount)
        grossAmountProfitTitle.text = "Rendimento total de " +
                                      String.floatToCurrecyString(calculator.grossAmountProfit)

        investedAmount.text = String.floatToCurrecyString(calculator.investmentParameter.investedAmount)
        grossAmount.text = String.floatToCurrecyString(calculator.grossAmount)
        grossAmountProfit.text = String.floatToCurrecyString(calculator.grossAmountProfit)
        taxesAmount.text = String.floatToCurrecyString(calculator.taxesAmount) +
                           "(\(String.floatToPercentageString(calculator.taxesRate)))"
        netAmount.text = String.floatToCurrecyString(calculator.netAmount)

        maturityDate.text = calculator.investmentParameter.maturityDate.formatToDisplayDateString()
        maturityTotalDays.text = String(describing: calculator.investmentParameter.maturityTotalDays)
        monthlyGrossRateProfit.text = String.floatToPercentageString(calculator.monthlyGrossRateProfit)
        rate.text = String.floatToPercentageString(calculator.investmentParameter.rate)
        rateProfit.text = String.doubleToPercentageString(calculator.rateProfit)
        annualGrossRateProfit.text = String.floatToPercentageString(calculator.annualGrossRateProfit)
    }
}
