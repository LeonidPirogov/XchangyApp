//
//  ExchangeViewModel.swift
//  XchangyApp
//
//  Created by Leonid on 22.02.2026.
//

import Foundation

final class ExchangeViewModel {
    private(set) var state: ExchangeViewState {
        didSet { onChange?(state) }
    }
    
    var onChange: ((ExchangeViewState) -> Void)?
    
    init(state: ExchangeViewState) {
        self.state = state
    }
    
    func setRate(_ rate: ExchangeRate) {
        state.rate = rate
        recalculateTo()
    }
    
    func userChangedFromAmount(_ value: Decimal) {
        state.fromAmount = value
        recalculateTo()
    }
    
    func userSelectedToCurrency(_ currency: Currency) {
        var newState = state
        newState.toCurrency = currency
        newState.rate = nil
        state = newState
    }
    
    func swapCurrencies() {
        var newState = state
        Swift.swap(&newState.fromCurrency, &newState.toCurrency)
        Swift.swap(&newState.fromAmount, &newState.toAmount)
        state = newState
        recalculateTo()
    }
    
    private func recalculateTo() {
        guard let rate = state.rate?.rate else { return }
        var newState = state
        newState.toAmount = newState.fromAmount * rate
        state = newState
    }
}

private extension Decimal {
    static func * (multiplier: Decimal, multiplicand: Decimal) -> Decimal {
        var leftValue = multiplier
        var rightValue = multiplicand
        var result = Decimal()
        
        NSDecimalMultiply(&result, &leftValue, &rightValue, .bankers)
        
        return result
    }
}
