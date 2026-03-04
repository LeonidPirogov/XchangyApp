//
//  MoneyFormatter.swift
//  XchangyApp
//
//  Created by Leonid on 22.02.2026.
//

import Foundation

final class MoneyFormatter {
    
    private let formatter: NumberFormatter
    
    init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.decimalSeparator = "."
    }
    
    func string(from amount: Decimal) -> String {
        let number = amount as NSDecimalNumber
        return formatter.string(from: number) ?? "0"
    }
    
    func decimal(from string: String) -> Decimal? {
        let normalized = string.replacingOccurrences(of: ",", with: ".")
        return Decimal(string: normalized)
    }
}
