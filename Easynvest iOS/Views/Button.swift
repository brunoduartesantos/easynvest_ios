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
}
