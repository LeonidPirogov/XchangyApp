//
//  CurrencyCell.swift
//  XchangyApp
//
//  Created by Leonid on 11.02.2026.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = "CurrencyCell"
    
    // MARK: - Private UI
    
    private lazy var iconContainer: UIView = {
        let iconContainer = UIView()
        iconContainer.backgroundColor = .secondarySystemBackground
        iconContainer.layer.cornerRadius = Constants.iconContainerCornerRadius
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        return iconContainer
    }()
    
    private lazy var flagImageView: UIImageView = {
        let flagImageView = UIImageView()
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = Constants.flagCornerRadius
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        return flagImageView
    }()
    
    private lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.font = .systemFont(ofSize: Constants.codeFontSize, weight: .semibold)
        codeLabel.textColor = .label
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        return codeLabel
    }()
    
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.layer.cornerRadius = Constants.indicatorCornerRadius
        indicatorView.layer.borderWidth = Constants.indicatorBorderWidth
        indicatorView.layer.borderColor = UIColor.systemGray4.cgColor
        indicatorView.backgroundColor = .clear
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    private lazy var checkmarkImageView: UIImageView = {
        let checkmarkImageView = UIImageView()
        let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: Constants.checkmarkPointSize, weight: .bold)
        checkmarkImageView.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
        checkmarkImageView.tintColor = .white
        checkmarkImageView.isHidden = true
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        return checkmarkImageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(currency: Currency, isSelected: Bool) {
        codeLabel.text = currency.code
        flagImageView.image = currency.flag
        applySelection(isSelected)
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(iconContainer, codeLabel, indicatorView)
        iconContainer.addSubview(flagImageView)
        indicatorView.addSubview(checkmarkImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: Constants.iconContainerSize),
            iconContainer.heightAnchor.constraint(equalToConstant: Constants.iconContainerSize),
            
            flagImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            flagImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: Constants.flagSize),
            flagImageView.heightAnchor.constraint(equalToConstant: Constants.flagSize),
            
            codeLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: Constants.codeLeftSpacing),
            codeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            indicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: Constants.indicatorSize),
            indicatorView.heightAnchor.constraint(equalToConstant: Constants.indicatorSize),
            
            checkmarkImageView.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor)
        ])
    }
    
    private func applySelection(_ isSelected: Bool) {
        indicatorView.layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.systemGray4.cgColor
        indicatorView.backgroundColor = isSelected ? .accentGreen : .clear
        checkmarkImageView.isHidden = !isSelected
    }
}

// MARK: - Constants

private enum Constants {
    static let horizontalPadding: CGFloat = 16
    
    static let iconContainerSize: CGFloat = 44
    static let iconContainerCornerRadius: CGFloat = 14
    
    static let flagSize: CGFloat = 28
    static let flagCornerRadius: CGFloat = flagSize / 2
    
    static let codeLeftSpacing: CGFloat = 14
    static let codeFontSize: CGFloat = 18
    
    static let indicatorSize: CGFloat = 28
    static let indicatorCornerRadius: CGFloat = indicatorSize / 2
    static let indicatorBorderWidth: CGFloat = 2
    
    static let checkmarkPointSize: CGFloat = 14
}


