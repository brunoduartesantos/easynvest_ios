//
//  StringHelper.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 02/12/17.
//

import Foundation

extension String {
    /// Formatting text for currency textField
    func currencyInputFormatting() -> String {
        do {
            var number: NSNumber!
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "pt-BR")
            formatter.currencySymbol = "R$"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            var amountWithPrefix = self
            // remove from String: "$", ".", ","
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amountWithPrefix = regex.stringByReplacingMatches(
                in: amountWithPrefix,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: NSRange(location: 0, length: self.count),
                withTemplate: "")
            let double = (amountWithPrefix as NSString).doubleValue
            number = NSNumber(value: (double / 100))
            // if first number is 0 or all numbers were deleted
            guard number != 0 as NSNumber else {
                return ""
            }
            return formatter.string(from: number)!
        } catch {
            return ""
        }
    }

    /// Format a string from this format "dd/MM/yyyy" to this "yyyy-MM-dd" format
    func formatToDateString() -> String {
        if self.isEmpty {
            return ""
        }

        let stringArray = self.components(separatedBy: "/")

        if stringArray.count < 3 {
            return ""
        }

        let formattedString = "\(stringArray[2])-\(stringArray[1])-\(stringArray[0])"
        return formattedString
    }

    /// Format a string from money to number format (0000.00)
    func formatToNumberString() -> String {
        if self.isEmpty {
            return ""
        }

        var newString = self.replacingOccurrences(of: ".", with: "")
        newString = newString.replacingOccurrences(of: ",", with: ".")
        newString = newString.replacingOccurrences(of: "R$", with: "")

        return newString
    }

    static func floatToCurrecyString(_ value: Float) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency

        if let formattedValue = formatter.string(from: value as NSNumber) {
            return formattedValue
        } else {
            return ""
        }
    }

    /// Format a string from this format "yyyy-MM-dd'T'hh:mm:ss" to this "dd/MM/yyyy" format
    func formatToDisplayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt-BR")

        guard let dateObj = dateFormatter.date(from: self) else { return "" }

        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateObj)
    }

    /// Format a float value to this format (00,0%)
    static func floatToPercentageString(_ value: Float) -> String {
        return (String(format: "%.2f", value) + "%").replacingOccurrences(of: ".", with: ",")
    }

    /// Format a double value to this format (00,0%)
    static func doubleToPercentageString(_ value: Double) -> String {
        return (String(format: "%.2f", value) + "%").replacingOccurrences(of: ".", with: ",")
    }
}
