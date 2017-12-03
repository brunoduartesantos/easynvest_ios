//
//  Investiment.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 03/12/17.
//

import Foundation

struct Investment: Codable {
    /// O valor a ser investido
    let investedAmount: Float
    /// Rentabilidade anual
    let yearlyInterestRate: Float
    /// Dias corridos
    let maturityTotalDays: Int
    /// Dias úteis
    let maturityBusinessDays: Int
    /// Data de vencimento
    let maturityDate: String
    /// Percentual do papel
    let rate: Float
    /// Isento de IR
    let isTaxFree: Bool
}
