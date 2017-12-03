//
//  Button.swift
//  Easynvest iOS
//
//  Created by Bruno Pereira dos Santos on 02/12/17.
//

import UIKit

class Button: UIButton {
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height / 2
    }
    func setEnabled(enabled: Bool) {
        isEnabled = enabled
        if enabled {
            backgroundColor = #colorLiteral(red: 0.08714094013, green: 0.8120337129, blue: 0.7545427084, alpha: 1)
        } else {
            backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
    }
}
