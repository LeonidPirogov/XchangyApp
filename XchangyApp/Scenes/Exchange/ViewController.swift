//
//  ViewController.swift
//  XchangyApp
//
//  Created by Leonid on 08.02.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let exchangeView = ExchangeView()
    private let validator = DecimalInputValidator()
    
    private var selectedToCurrency = Currency(
        code: "MXN",
        flagImageName: Assets.mxFlag,
        flagContentRect: nil
    )
    
    private let currencies: [Currency] = [
        Currency(code: "ARS",  flagImageName: Assets.arFlag, flagContentRect: nil),
        Currency(code: "EURc", flagImageName: Assets.euFlag, flagContentRect: nil),
        Currency(code: "COP",  flagImageName: Assets.coFlag, flagContentRect: nil),
        Currency(code: "MXN",  flagImageName: Assets.mxFlag, flagContentRect: nil),
        Currency(code: "BRL",  flagImageName: Assets.brFlag, flagContentRect: nil)
    ]
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = exchangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        setupKeyboardDismiss()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        exchangeView.configureInitialState()
    }
    
    private func setupActions() {
        exchangeView.toView.onCurrencyTap = { [weak self] in
            self?.presentCurrencyPicker()
        }
    }
    
    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func presentCurrencyPicker() {
        dismissKeyboard()
        
        let picker = CurrencyPickerViewController(currencies: currencies, selected: selectedToCurrency)
        picker.onSelect = { [weak self] currency in
            guard let self else { return }
            self.applySelectedCurrency(currency)
        }
        
        configureSheetPresentation(for: picker)
        present(picker, animated: true)
    }
    
    private func applySelectedCurrency(_ currency: Currency) {
        selectedToCurrency = currency
        exchangeView.toView.updateCurrency(
            flag: currency.flag,
            code: currency.code,
            flagContentsRect: currency.flagContentRect
        )
    }
    
    private func configureSheetPresentation(for controller: UIViewController) {
        
        controller.modalPresentationStyle = .pageSheet
        guard let sheet = controller.sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        sheet.preferredCornerRadius = 32
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Assets

private enum Assets {
    static let arFlag = "ar_flag"
    static let euFlag = "eu_flag"
    static let coFlag = "co_flag"
    static let mxFlag = "mx_flag"
    static let brFlag = "br_flag"
}
