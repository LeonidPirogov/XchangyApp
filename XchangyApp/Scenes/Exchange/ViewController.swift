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
    
    // MARK: - Presentation
    
    private lazy var viewModel = ExchangeViewModel(
        state: ExchangeViewState(
            fromCurrency: Currency(code: "USDc"),
            toCurrency: Currency(code: "MXN"),
            fromAmount: Decimal(9999),
            toAmount: Decimal(0),
            rate: ExchangeRate(
                from: Currency(code: "USDc"),
                to: Currency(code: "MXN"),
                rate: Decimal(string: "18.4097") ?? 0,
                updateAt: Date()
            )
        )
    )
    
    private let moneyFormatter = MoneyFormatter()
    
    // MARK: - UI Config (flags etc.)
    
    private let currencyUIByCode: [String: CurrencyUIConfig] = [
        "ARS":  CurrencyUIConfig(flagImageName: Assets.arFlag, contentRect: nil),
        "EURc": CurrencyUIConfig(flagImageName: Assets.euFlag, contentRect: nil),
        "COP":  CurrencyUIConfig(flagImageName: Assets.coFlag, contentRect: nil),
        "MXN":  CurrencyUIConfig(flagImageName: Assets.mxFlag, contentRect: nil),
        "BRL":  CurrencyUIConfig(flagImageName: Assets.brFlag, contentRect: nil),
        "USDc": CurrencyUIConfig(flagImageName: Assets.usFlag, contentRect: CGRect(x: 0, y: 0, width: 0.85, height: 0.85))
    ]
    
    private var availableCurrencies: [Currency] {
        ["ARS", "EURc", "COP", "MXN", "BRL"].map { Currency(code: $0) }
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = exchangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        setupActions()
        setupKeyboardDismiss()
        
        render(viewModel.state)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        exchangeView.fromView.isCurrencySelectable = false
        exchangeView.toView.isCurrencySelectable = true
        
        exchangeView.fromView.setAmountDelegate(validator)
        exchangeView.toView.setAmountDelegate(validator)
        
        exchangeView.fromView.addAmountEditingChangedTarget(self, action: #selector(fromAmountChanged))
    }
    
    private func setupBindings() {
        viewModel.onChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    private func setupActions() {
        exchangeView.toView.onCurrencyTap = { [weak self] in
            self?.presentCurrencyPicker()
        }
        
        exchangeView.onSwapTap = { [weak self] in
            self?.viewModel.swapCurrencies()
        }
    }
    
    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Render
    
    private func render(_ state: ExchangeViewState) {
        applyCurrencyUI(code: state.fromCurrency.code, to: exchangeView.fromView)
        applyCurrencyUI(code: state.toCurrency.code, to: exchangeView.toView)
        
        exchangeView.fromView.setAmountText(moneyFormatter.string(from: state.fromAmount))
        exchangeView.toView.setAmountText(moneyFormatter.string(from: state.toAmount))
        
        if let rate = state.rate {
            exchangeView.setRateText("1 \(rate.from.code) = \(moneyFormatter.string(from: rate.rate)) \(rate.to.code)")
        } else {
            exchangeView.setRateText("—")
        }
    }
    
    private func applyCurrencyUI(code: String, to view: CurrencyInputView) {
        let config = currencyUIByCode[code]
        let flag = config.flatMap { UIImage(named: $0.flagImageName) }
        view.updateCurrency(flag: flag, code: code, flagContentsRect: config?.contentRect)
    }
    
    // MARK: - Actions / Events
    
    private func presentCurrencyPicker() {
        dismissKeyboard()
        
        let picker = CurrencyPickerViewController(
            currencies: availableCurrencies,
            selected: viewModel.state.toCurrency,
            currencyUIByCode: currencyUIByCode
        )
        
        picker.onSelect = { [weak self] currency in
            self?.viewModel.userSelectedToCurrency(currency)
        }
        
        configureSheetPresentation(for: picker)
        present(picker, animated: true)
    }
    
    @objc private func fromAmountChanged() {
        let text = exchangeView.fromView.amountText ?? ""
        if let decimal = moneyFormatter.decimal(from: text) {
            viewModel.userChangedFromAmount(decimal)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureSheetPresentation(for controller: UIViewController) {
        controller.modalPresentationStyle = .pageSheet
        guard let sheet = controller.sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        sheet.preferredCornerRadius = 32
    }
}

// MARK: - Assets

private enum Assets {
    static let arFlag = "ar_flag"
    static let euFlag = "eu_flag"
    static let coFlag = "co_flag"
    static let mxFlag = "mx_flag"
    static let brFlag = "br_flag"
    static let usFlag = "us_flag"
}
