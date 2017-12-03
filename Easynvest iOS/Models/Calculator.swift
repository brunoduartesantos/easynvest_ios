//
//  Calculator.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 02/12/17.
//

import UIKit
import Foundation

class Calculator: NSObject {
    var investedAmount: String
    var rate: String
    var maturityDate: String

    // MARK: Lifecycle

    init(investedAmount: String, rate: String, maturityDate: String) {
        self.investedAmount = investedAmount.formatToNumberString()
        self.rate = rate
        self.maturityDate = maturityDate.formatToDateString()
    }

    // MARK: Requests

    func simulate(completion: (() -> Void)?) {
        var url = URLComponents(string: "https://api-simulator-calc.easynvest.com.br/calculator/simulate")!

        url.queryItems = [
            URLQueryItem(name: "investedAmount", value: investedAmount),
            URLQueryItem(name: "index", value: "CDI"),
            URLQueryItem(name: "rate", value: rate),
            URLQueryItem(name: "isTaxFree", value: "false"),
            URLQueryItem(name: "maturityDate", value: maturityDate)
        ]

        let request = URLRequest(url: url.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
