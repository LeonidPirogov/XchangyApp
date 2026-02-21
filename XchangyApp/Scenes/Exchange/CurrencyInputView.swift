//
//  CurrencyInputView.swift
//  XchangyApp
//
//  Created by Leonid on 10.02.2026.
//

import UIKit

final class CurrencyInputView: UIView {
    
    // MARK: - Public Properties
    
    var onCurrencyTap: (() -> Void)?
    
    var isCurrencySelectable: Bool = true {
        didSet { updateSelectableUI() }
    }
    
    var amountText: String? { amountTextField.text }
    
    // MARK: - Private UI
    
    private lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = Constants.cardCornerRadius
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    private lazy var flagImageView: UIImageView = {
        let flagImageView = UIImageView()
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = Constants.flagCornerRadius
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        return flagImageView
    }()
    
    private lazy var currencyLabel: UILabel = {
        let currencyLabel = UILabel()
        currencyLabel.font = .systemFont(ofSize: Constants.currencyFontSize, weight: .semibold)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        return currencyLabel
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let chevronImageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: Constants.chevronPointSize, weight: .bold)
        chevronImageView.image = UIImage(systemName: "chevron.down", withConfiguration: config)
        chevronImageView.tintColor = .label
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        return chevronImageView
    }()
    
    private lazy var amountTextField: UITextField = {
        let amountTextField = UITextField()
        amountTextField.font = .systemFont(ofSize: Constants.amountFontSize, weight: .semibold)
        amountTextField.textAlignment = .right
        amountTextField.keyboardType = .decimalPad
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        return amountTextField
    }()
    
    private lazy var currencyTapButton: UIButton = {
        let currencyTapButton = UIButton(type: .system)
        currencyTapButton.translatesAutoresizingMaskIntoConstraints = false
        return currencyTapButton
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        setupActions()
        updateSelectableUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(flag: UIImage?, code: String, amount: String, flagContentsRect: CGRect? = nil) {
        applyCurrency(flag: flag, code: code, flagContentsRect: flagContentsRect)
        amountTextField.text = amount
    }
    
    func updateCurrency(flag: UIImage?, code: String, flagContentsRect: CGRect? = nil) {
        applyCurrency(flag: flag, code: code, flagContentsRect: flagContentsRect)
    }
    
    func setAmountDelegate(_ delegate: UITextFieldDelegate) {
        amountTextField.delegate = delegate
    }
    
    // MARK: - Private Methods
    
    private func setupHierarchy() {
        addSubview(cardView)
        cardView.addSubviews(flagImageView, currencyLabel, amountTextField, chevronImageView, currencyTapButton)
    }
    
    private func setupActions() {
        currencyTapButton.addTarget(self, action: #selector(currencyTapped), for: .touchUpInside)
    }
    
    private func updateSelectableUI() {
        chevronImageView.isHidden = !isCurrencySelectable
        currencyTapButton.isHidden = !isCurrencySelectable
        currencyTapButton.isUserInteractionEnabled = isCurrencySelectable
    }
    
    private func applyCurrency(flag: UIImage?, code: String, flagContentsRect: CGRect?) {
        flagImageView.image = flag
        currencyLabel.text = code
        flagImageView.layer.contentsRect = flagContentsRect ?? Constants.defaultFlagContentsRect
    }
    
    @objc private func currencyTapped() {
        onCurrencyTap?()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            flagImageView.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: Constants.horizontalPadding
            ),
            flagImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagSize),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.flagSize),
                
            currencyLabel.leadingAnchor.constraint(
                equalTo: flagImageView.trailingAnchor,
                constant: Constants.flagToCodeSpacing
            ),
            currencyLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                
            chevronImageView.leadingAnchor.constraint(
                equalTo: currencyLabel.trailingAnchor,
                constant: Constants.codeToChevronSpacing
            ),
            chevronImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: Constants.chevronSize),
            chevronImageView.heightAnchor.constraint(equalToConstant: Constants.chevronSize),
                
            currencyTapButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            currencyTapButton.topAnchor.constraint(equalTo: cardView.topAnchor),
            currencyTapButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            currencyTapButton.trailingAnchor.constraint(
                equalTo: chevronImageView.trailingAnchor,
                constant: Constants.horizontalPadding
            ),
                
            amountTextField.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -Constants.horizontalPadding
            ),
            amountTextField.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            amountTextField.leadingAnchor.constraint(
                greaterThanOrEqualTo: chevronImageView.trailingAnchor,
                constant: Constants.chevronToAmountMinSpacing
            )
        ])
    }
}

// MARK: - Constants

private enum Constants {
    static let horizontalPadding: CGFloat = 16

    static let cardCornerRadius: CGFloat = 18

    static let flagSize: CGFloat = 20
    static let flagCornerRadius: CGFloat = 12

    static let flagToCodeSpacing: CGFloat = 9
    static let codeToChevronSpacing: CGFloat = 8
    static let chevronToAmountMinSpacing: CGFloat = 12

    static let chevronSize: CGFloat = 16
    static let chevronPointSize: CGFloat = 18

    static let currencyFontSize: CGFloat = 18
    static let amountFontSize: CGFloat = 20

    static let defaultFlagContentsRect = CGRect(x: 0, y: 0, width: 1, height: 1)
}
