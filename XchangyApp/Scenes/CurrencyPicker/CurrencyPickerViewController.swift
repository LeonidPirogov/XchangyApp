//
//  CurrencyPickerViewController.swift
//  XchangyApp
//
//  Created by Leonid on 11.02.2026.
//

import UIKit

final class CurrencyPickerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var onSelect: ((Currency) -> Void)?
    
    // MARK: - Private Properties
    
    private let currencies: [Currency]
    private var selected: Currency
    
    private var cardHeight: CGFloat {
        min(CGFloat(currencies.count) * Constants.rowHeight + Constants.cardHeightExtra, Constants.maxCardHeight)
    }
    
    // MARK: - Private UI
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let cardView = UIView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Init
    
    init(currencies: [Currency], selected: Currency) {
        self.currencies = currencies
        self.selected = selected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupConstraints()
        setupActions()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Choose currency"
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = .label
        
        let closeConfig = UIImage.SymbolConfiguration(pointSize: Constants.closeIconPointSize, weight: .medium)
        closeButton.setImage(UIImage(systemName: "xmark", withConfiguration: closeConfig), for: .normal)
        closeButton.tintColor = .label
        
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = Constants.cardCornerRadius
        cardView.clipsToBounds = true
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = Constants.rowHeight
    }
    
    private func setupHierarchy() {
        [titleLabel, closeButton, cardView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.headerTop),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: closeButton.leadingAnchor, constant: -Constants.headerTitleToCloseMinSpacing),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonSize),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.headerBottom),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.cardSideInset),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.cardSideInset),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.cardBottomInset),
            
            tableView.topAnchor.constraint(equalTo: cardView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])

    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseId)
    }
    
    private func applySelection(_ currency: Currency) {
        selected = currency
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.selectionDelay) { [weak self] in
            guard let self else { return }
            self.onSelect?(currency)
            self.dismiss(animated: true)
        }
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension CurrencyPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseId, for: indexPath) as! CurrencyCell
        cell.configure(currency: currency, isSelected: currency == selected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        applySelection(currencies[indexPath.row])
    }
}

// MARK: - Constants

private enum Constants {
    static let horizontalPadding: CGFloat = 16
    
    static let headerTop: CGFloat = 24
    static let headerBottom: CGFloat = 12
    static let headerTitleToCloseMinSpacing: CGFloat = 8
    
    static let titleFontSize: CGFloat = 26
    
    static let closeButtonSize: CGFloat = 40
    static let closeIconPointSize: CGFloat = 14
    
    static let cardCornerRadius: CGFloat = 18
    static let cardSideInset: CGFloat = 16
    static let cardBottomInset: CGFloat = 5
    
    static let rowHeight: CGFloat = 74
    
    static let selectionDelay: TimeInterval = 0.18
    
    static let cardHeightExtra: CGFloat = 16
    static let maxCardHeight: CGFloat = 420
}
