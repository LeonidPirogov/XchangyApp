//
//  DecimalInputValidator.swift
//  XchangyApp
//
//  Created by Leonid on 11.02.2026.
//

import UIKit

final class DecimalInputValidator: NSObject, UITextFieldDelegate {
    
    private static let allowedCharacters: CharacterSet = {
        var set = CharacterSet.decimalDigits
        set.insert(charactersIn: ".,")
        return set
    }()
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }

        for scalar in string.unicodeScalars {
            if !Self.allowedCharacters.contains(scalar) { return false }
        }
        
        let current = textField.text ?? ""
        guard let range = Range(range, in: current) else { return false }
        
        let normalized = string.replacingOccurrences(of: ",", with: ".")
        
        let updated = current.replacingCharacters(in: range, with: normalized)
        
        if updated.firstIndex(of: ".") != updated.lastIndex(of: ".") {
            return false
        }
        
        if string.contains(",") {
            textField.text = updated
            return false
        }
        
        return true
    }
}
