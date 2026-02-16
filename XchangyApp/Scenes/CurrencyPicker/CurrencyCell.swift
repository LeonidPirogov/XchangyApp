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
    
    private let iconContainer = UIView()
    private let flagImageView = UIImageView()
    private let codeLabel = UILabel()
    
    private let indicatorView = UIView()
    private let checkmarkImageView = UIImageView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
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
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white
        
        iconContainer.backgroundColor = .secondarySystemBackground
        iconContainer.layer.cornerRadius = Constants.iconContainerCornerRadius
        
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = Constants.flagCornerRadius
        
        codeLabel.font = .systemFont(ofSize: Constants.codeFontSize, weight: .semibold)
        codeLabel.textColor = .label
        
        indicatorView.layer.cornerRadius = Constants.indicatorCornerRadius
        indicatorView.layer.borderWidth = Constants.indicatorBorderWidth
        indicatorView.layer.borderColor = UIColor.systemGray4.cgColor
        indicatorView.backgroundColor = .clear
        
        let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: Constants.checkmarkPointSize, weight: .bold)
        checkmarkImageView.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
        checkmarkImageView.tintColor = .white
        checkmarkImageView.isHidden = true
    }
    
    private func setupHierarchy() {
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(flagImageView)
        
        contentView.addSubview(codeLabel)
        
        contentView.addSubview(indicatorView)
        indicatorView.addSubview(checkmarkImageView)
        
        [iconContainer, flagImageView, codeLabel, indicatorView, checkmarkImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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
