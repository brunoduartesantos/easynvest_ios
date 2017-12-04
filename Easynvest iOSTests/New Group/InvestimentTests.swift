//
//  InvestimentTests.swift
//  Easynvest iOSTests
//
//  Created by Bruno Pereira dos Santos on 04/12/17.
//

import XCTest

class InvestimentTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSimulationWhenInvestmentIsCorrect() {
        var investment = Investment(
            investedAmount: 10000,
            yearlyInterestRate: 0,
            maturityTotalDays: 0,
            maturityBusinessDays: 0,
            maturityDate: "2010-12-04",
            rate: 123,
            isTaxFree: false)

        investment.simulate { (calculator) in
            XCTAssertNotNil(calculator)
        }
    }

    func testSimulationWhenInvestmentHasIncorrectParams() {
        var investment = Investment(
            investedAmount: 10000,
            yearlyInterestRate: 0,
            maturityTotalDays: 0,
            maturityBusinessDays: 0,
            maturityDate: "2010-12-04",
            rate: 123,
            isTaxFree: true)

        investment.simulate { (calculator) in
            XCTAssertNil(calculator)
        }
    }
}
