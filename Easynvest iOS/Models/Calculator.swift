//
//  Calculator.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 02/12/17.
//

import UIKit

class Calculator: NSObject {
    var investedAmount: Float
    var rate: Float
    var maturityDate: Date
    // MARK: Lifecycle
    init(investedAmount: Float, rate: Float, maturityDate: Date) {
        self.investedAmount = investedAmount
        self.rate = rate
        self.maturityDate = maturityDate
    }
}
