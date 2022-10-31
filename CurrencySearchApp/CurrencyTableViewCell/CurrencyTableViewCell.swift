//
//  CurrencyTableViewCell.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 08/10/2022.
//

import UIKit

final class CurrencyListTableViewCell: UITableViewCell {
    // MARK: - Properties
   let nameCurrencyLabel = UILabel()
   let priceCurrencyLabel = UILabel()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "CurrencyListTableViewCell")
        setupSubviews()
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    private func setupSubviews() {
        [nameCurrencyLabel, priceCurrencyLabel].forEach { contentView.addSubview($0) }
    }
    private func setupConstraints() {
        [nameCurrencyLabel, priceCurrencyLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            nameCurrencyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameCurrencyLabel.widthAnchor.constraint(equalToConstant: 200),
            nameCurrencyLabel.heightAnchor.constraint(equalToConstant: 40),
            nameCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  20),

            priceCurrencyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceCurrencyLabel.widthAnchor.constraint(equalToConstant: 120),
            priceCurrencyLabel.heightAnchor.constraint(equalToConstant: 40),
            priceCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    private func configureUI() {
        contentView.backgroundColor = UIColor(named: "cellColor")
        contentView.layer.borderWidth = 5
        
        nameCurrencyLabel.font = UIFont.systemFont(ofSize: 22)
        nameCurrencyLabel.textColor = .white
        
        priceCurrencyLabel.font = UIFont.systemFont(ofSize: 22)
        priceCurrencyLabel.textAlignment = .right
        priceCurrencyLabel.textColor = .white
    }
}
