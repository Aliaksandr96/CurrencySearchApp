//
//  DetailViewController.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 08/10/2022.
//

import UIKit

// MARK: - Filtration by ID
enum FiltrationID {
    case filterInfoByID(model: [CurrencyModel], ID: String)
    func filterInfo() -> [CurrencyModel] {
        switch self {
        case .filterInfoByID(let model, let ID):
            return model.filter { $0.id == ID }
        }
    }
}

// MARK: - Filtration by ID and get icon
enum FiltrationIcon {
    case  filterIconByID(model: [CurrencyIconModel], ID: String)
    func filterIcon() -> [CurrencyIconModel] {
        switch self {
        case .filterIconByID(let model, let ID):
            return model.filter { $0.id == ID }
        }
    }
}

final class DetailViewController: UIViewController {
    
    // MARK: - UI Element's
    private let nameCurrencyLabel = UILabel()
    private let priceCurrencyLabel = UILabel()
    private let imageCurrencyImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageCurrencyImageView()
        setupNameCurrencyLabel()
        setupPriceCurrencyLabel()
        setupViewActivityIndicator()
    }
    
    // MARK: - Setup Image Currency Image View
    private func setupImageCurrencyImageView() {
        view.addSubview(imageCurrencyImageView)
        imageCurrencyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageCurrencyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageCurrencyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageCurrencyImageView.widthAnchor.constraint(equalToConstant: 150),
            imageCurrencyImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    // MARK: - Setup Name Currency Label
    private func setupNameCurrencyLabel() {
        view.addSubview(nameCurrencyLabel)
        nameCurrencyLabel.textColor = .white
        nameCurrencyLabel.textAlignment = .center
        nameCurrencyLabel.font = UIFont.systemFont(ofSize: 26)
        nameCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameCurrencyLabel.topAnchor.constraint(equalTo: imageCurrencyImageView.bottomAnchor, constant: 20),
            nameCurrencyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameCurrencyLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            nameCurrencyLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Setup Price Currency Label
    private func setupPriceCurrencyLabel() {
        view.addSubview(priceCurrencyLabel)
        priceCurrencyLabel.textColor = .white
        priceCurrencyLabel.textAlignment = .center
        priceCurrencyLabel.font = UIFont.systemFont(ofSize: 42)
        priceCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceCurrencyLabel.topAnchor.constraint(equalTo: nameCurrencyLabel.bottomAnchor, constant: 20),
            priceCurrencyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceCurrencyLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            priceCurrencyLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
        // MARK: - Setup Activity Indicator
     private func setupViewActivityIndicator() {
            activityIndicator.color = .blue
            activityIndicator.center = self.view.center
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
        }
    
    // MARK: - Networking
    func setIdCurrency(currencyID: String) {
        NetworkManager.shared.getCurrencyFromApi { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currency):
                        let filtred = FiltrationID.filterInfoByID(model: currency, ID: currencyID).filterInfo()
                        self?.nameCurrencyLabel.text = filtred.first?.name
                        self?.priceCurrencyLabel.text = "\(String(format: "%.3f", filtred.first?.price ?? 0))"
                        self?.activityIndicator.removeFromSuperview()
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
        NetworkManager.shared.getIconCurrencyFromApi { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currencyIcon):
                    let filtred = FiltrationIcon.filterIconByID(model: currencyIcon, ID: currencyID).filterIcon()
                    self?.imageCurrencyImageView.downloaded(from: filtred.first?.url ?? "", contentMode: .scaleToFill)
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}

