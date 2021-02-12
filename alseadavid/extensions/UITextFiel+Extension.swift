//
//  UITextFiel+Extension.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import Foundation
import UIKit

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        guard let cadena = t?.prefix(maxLength) else {
            return
        }
        textField.text = "\(cadena)"
    }
}
