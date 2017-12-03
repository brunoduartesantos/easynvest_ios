//
//  Calculator.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 02/12/17.
//

import UIKit
import Foundation

struct Calculator: Codable {
    let investmentParameter: Investment

    /// Valor bruto do investimento
    let grossAmount: Float?
    /// Valor do IR
    let taxesAmount: Float?
    /// Valor líquido
    let netAmount: Float?
    /// Rentabilidade bruta
    let grossAmountProfit: Float?
    /// Rentabilidade líquida
    let netAmountProfit: Float?
    /// Rentabilidade bruta anual
    let annualGrossRateProfit: Float?
    /// Rentabilidade bruta mensal
    let monthlyGrossRateProfit: Float?
    /// Rentabilidade bruta diária
    let dailyGrossRateProfit: Double?
    /// Faixa do IR (%)
    let taxesRate: Float?
    /// Rentabilidade no período
    let rateProfit: Double?
    /// Rentabilidade líquida anual
    let annualNetRateProfit: Float?
}
