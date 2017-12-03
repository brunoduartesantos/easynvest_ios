//
//  Investiment+Requests.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 03/12/17.
//

import Foundation

extension Investment {
    /// Makes a server request to simulate the investment
    ///
    /// - Parameter completion: Returns a "Calculator" object with all results,
    ///                         but if request fails, the object will be nil.
    mutating func simulate(completion: ((_ calculator: Calculator?) -> Void)?) {
        var url = URLComponents(string: "https://api-simulator-calc.easynvest.com.br/calculator/simulate")!

        url.queryItems = [
            URLQueryItem(name: "investedAmount", value: String(investedAmount)),
            URLQueryItem(name: "index", value: "CDI"),
            URLQueryItem(name: "rate", value: String(rate)),
            URLQueryItem(name: "isTaxFree", value: "false"),
            URLQueryItem(name: "maturityDate", value: String(maturityDate))
        ]

        let request = URLRequest(url: url.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data {
                do {
                    let calculator = try JSONDecoder().decode(Calculator.self, from: data)
                    completion?(calculator)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion?(nil)
                }
            } else if let error = error {
                print(error.localizedDescription)
                completion?(nil)
            }
        }
        task.resume()
    }
}
