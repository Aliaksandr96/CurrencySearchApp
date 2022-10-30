//
//  DetailCurrencyViewController.swift
//
//  Created by Aliaksandr Hunko on 30/10/2022
//

import UIKit

protocol DetailCurrencyViewProtocol: AnyObject {
    func updateLabel(model: CurrencyModel)
}

final class DetailCurrencyViewController: UIViewController {
    // MARK: Public
    var presenter: DetailCurrencyPresenterProtocol!
    
    // MARK: Private
    private let currentCurrencyNameLabel = UILabel()
    private let currentPriceNameLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        [currentCurrencyNameLabel, currentPriceNameLabel].forEach { view.addSubview($0) }
    }
    private func setupConstraints() {
        [currentCurrencyNameLabel, currentPriceNameLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            currentCurrencyNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentCurrencyNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentCurrencyNameLabel.widthAnchor.constraint(equalToConstant: 200),
            currentCurrencyNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            currentPriceNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            currentPriceNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentPriceNameLabel.widthAnchor.constraint(equalToConstant: 200),
            currentPriceNameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    private func configureUI() {
        title = "Detail Currency"
        view.backgroundColor = UIColor(named: "backgroundColor")
        [currentCurrencyNameLabel, currentPriceNameLabel].forEach { $0.textAlignment = .center }
        [currentCurrencyNameLabel, currentPriceNameLabel].forEach { $0.textColor = .white }
        [currentCurrencyNameLabel, currentPriceNameLabel].forEach { $0.font = UIFont.systemFont(ofSize: 22) }
    }
}

// MARK: - Extensions
extension DetailCurrencyViewController: DetailCurrencyViewProtocol {
    func updateLabel(model: CurrencyModel) {
        currentCurrencyNameLabel.text = model.name
        currentPriceNameLabel.text = "\(String(format: "%.3f", model.price ?? 0))"
    }
}
