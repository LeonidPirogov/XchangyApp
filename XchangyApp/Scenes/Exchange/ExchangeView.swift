//
//  ExchangeView.swift
//  XchangyApp
//
//  Created by Leonid on 10.02.2026.
//

import UIKit

final class ExchangeView: UIView {
    
    // MARK: - Private UI
    
    private(set) lazy var fromView: CurrencyInputView = {
        let fromView = CurrencyInputView()
        fromView.translatesAutoresizingMaskIntoConstraints = false
        return fromView
    }()
    
    private(set) lazy var toView: CurrencyInputView = {
        let toView = CurrencyInputView()
        toView.translatesAutoresizingMaskIntoConstraints = false
        return toView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Exchange calculator"
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var exchangeRateLabel: UILabel = {
        let exchangeRateLabel = UILabel()
        exchangeRateLabel.text = "1 USDc = 18.4097 MXN"
        exchangeRateLabel.font = .systemFont(ofSize: Constants.rateFontSize)
        exchangeRateLabel.textColor = .accentGreen
        exchangeRateLabel.translatesAutoresizingMaskIntoConstraints = false
        return exchangeRateLabel
    }()
    
    private lazy var swapButtonBackground: UIView = {
        let swapButtonBackground = UIView()
        swapButtonBackground.backgroundColor = .secondarySystemBackground
        swapButtonBackground.layer.cornerRadius = Constants.swapBackgroundCornerRadius
        swapButtonBackground.translatesAutoresizingMaskIntoConstraints = false
        return swapButtonBackground
    }()
    
    private lazy var swapButton: UIButton = {
        let swapButton = UIButton(type: .system)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .accentGreen
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "arrow.down")
        config.preferredSymbolConfigurationForImage = Constants.swapButtonSymbolConfig
        
        swapButton.configuration = config
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        return swapButton
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureInitialState() {
        fromView.isCurrencySelectable = false
        toView.isCurrencySelectable = true
        
        fromView.configure(
            flag: UIImage(named: Assets.usFlag),
            code: "USDc",
            amount: "$9,999",
            flagContentsRect: CGRect(x: 0, y: 0, width: 0.85, height: 0.85)
        )
        
        toView.configure(
            flag: UIImage(named: Assets.mxFlag),
            code: "MXN",
            amount: "$184,065.59"
        )
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
    }
    
    private func setupHierarchy() {
        addSubviews(titleLabel, exchangeRateLabel, fromView, toView, swapButtonBackground)
        swapButtonBackground.addSubview(swapButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
            
            exchangeRateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.titleToRateSpacing),
            exchangeRateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            exchangeRateLabel.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor),
            
            fromView.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor, constant: Constants.rateToViewSpacing),
            fromView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            fromView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            fromView.heightAnchor.constraint(equalToConstant: Constants.inputViewHeight),
            
            toView.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: Constants.inputViewsSpacing),
            toView.leadingAnchor.constraint(equalTo: fromView.leadingAnchor),
            toView.trailingAnchor.constraint(equalTo: fromView.trailingAnchor),
            toView.heightAnchor.constraint(equalTo: fromView.heightAnchor),
            toView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.bottomPadding),
            
            swapButtonBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            swapButtonBackground.centerYAnchor.constraint(equalTo: fromView.bottomAnchor, constant: Constants.swapButtonOffset),
            swapButtonBackground.widthAnchor.constraint(equalToConstant: Constants.swapBackgroundWidth),
            swapButtonBackground.heightAnchor.constraint(equalToConstant: Constants.swapBackgroundHeight),

            swapButton.centerXAnchor.constraint(equalTo: swapButtonBackground.centerXAnchor),
            swapButton.centerYAnchor.constraint(equalTo: swapButtonBackground.centerYAnchor),
            swapButton.widthAnchor.constraint(equalToConstant: Constants.swapButtonSize),
            swapButton.heightAnchor.constraint(equalTo: swapButton.widthAnchor)
        ])
    }
}

// MARK: - Assets

private enum Assets {
    static let usFlag = "us_flag"
    static let mxFlag = "mx_flag"
}

// MARK: - Constants

private enum Constants {
    static let horizontalPadding: CGFloat = 16
    
    static let titleTopOffset: CGFloat = 60
    static let titleToRateSpacing: CGFloat = 10
    static let rateToViewSpacing: CGFloat = 24
    static let inputViewsSpacing: CGFloat = 16
    
    static let inputViewHeight: CGFloat = 66
    
    static let titleFontSize: CGFloat = 30
    static let rateFontSize: CGFloat = 16
    
    static let swapButtonOffset: CGFloat = 8
    static let swapButtonSize: CGFloat = 24
    static let swapButtonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 9.5, weight: .bold)
    
    static let swapBackgroundWidth: CGFloat = 40
    static let swapBackgroundHeight: CGFloat = 38
    static let swapBackgroundCornerRadius: CGFloat = 26
    
    static let bottomPadding: CGFloat = 16
}
