//
//  Calculator.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 02/12/17.
//

import UIKit
import Foundation

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
    // MARK: Requests
    func simulate(completion: (() -> Void)?) {
        var url = URLComponents(string: "https://api-simulator-calc.easynvest.com.br/calculator/simulate")!
        url.queryItems = [
            URLQueryItem(name: "investedAmount", value: String(investedAmount)),
            URLQueryItem(name: "index", value: "CDI"),
            URLQueryItem(name: "rate", value: String(rate)),
            URLQueryItem(name: "isTaxFree", value: "false"),
            URLQueryItem(name: "maturityDate", value: self.formatDate(maturityDate))
        ]
//        url.queryItems = [
//            URLQueryItem(name: "investedAmount", value: "32323.0"),
//            URLQueryItem(name: "index", value: "CDI"),
//            URLQueryItem(name: "rate", value: "123"),
//            URLQueryItem(name: "isTaxFree", value: "false"),
//            URLQueryItem(name: "maturityDate", value: "2023-03-03")
//        ]
        let request = URLRequest(url: url.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    // MARK: Additional Helpers
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
