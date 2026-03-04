//
//  CurrencyPickerViewModel.swift
//  XchangyApp
//
//  Created by Leonid on 04.03.2026.
//

import UIKit

struct CurrencyPickerViewModel {
    let title: String
    let currencies: [Currency]
    let currencyUIByCode: [String: CurrencyUIConfig]
    var selected: Currency

    func makeCellModel(at index: Int) -> CurrencyCellModel {
        let currency = currencies[index]
        let config = currencyUIByCode[currency.code]

        return CurrencyCellModel(
            code: currency.code,
            flag: config.flatMap { UIImage(named: $0.flagImageName) },
            flagContentsRect: config?.contentRect,
            isSelected: currency == selected
        )
    }
}
