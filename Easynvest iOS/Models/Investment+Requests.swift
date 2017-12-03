//
//  Investiment+Requests.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 03/12/17.
//

import Foundation

extension Investment {
    mutating func simulate(completion: (() -> Void)?) {
        var url = URLComponents(string: "https://api-simulator-calc.easynvest.com.br/calculator/simulate")!

        url.queryItems = [
            URLQueryItem(name: "investedAmount", value: String(investedAmount)),
            URLQueryItem(name: "index", value: "CDI"),
            URLQueryItem(name: "rate", value: String(rate)),
            URLQueryItem(name: "isTaxFree", value: "false"),
            URLQueryItem(name: "maturityDate", value: String(maturityDate))
        ]

        let request = URLRequest(url: url.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let calculator = try JSONDecoder().decode(Calculator.self, from: data)
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
