//
//  ExchangeViewState.swift
//  XchangyApp
//
//  Created by Leonid on 22.02.2026.
//

import Foundation

struct ExchangeViewState: Equatable {
    var fromCurrency: Currency
    var toCurrency: Currency
    
    var fromAmount: Decimal
    var toAmount: Decimal
    
    var rate: ExchangeRate?
}
