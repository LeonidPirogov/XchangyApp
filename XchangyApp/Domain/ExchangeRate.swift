//
//  ExchangeRate.swift
//  XchangyApp
//
//  Created by Leonid on 17.02.2026.
//

import Foundation

struct ExchangeRate: Equatable {
    let from: Currency
    let to: Currency
    let rate: Decimal
    let updateAt: Date
}
