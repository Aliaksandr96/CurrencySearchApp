//
//  DetailViewController.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 08/10/2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - UI Element's
    private let nameCurrencyLabel = UILabel()
    private let priceCurrencyLabel = UILabel()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        setupNameCurrencyLabel()
        setupPriceCurrencyLabel()
        setModelCurrency()
    }
    
    // MARK: - Set Model Currency From View Controller
    private func setModelCurrency() {
        if let data = UserDefaults.standard.object(forKey: "saveModel") as? Data,
           let getModel = try? JSONDecoder().decode(CurrencyModel.self, from: data) {
            
            nameCurrencyLabel.text = "\(getModel.name) (\(getModel.id))"
            priceCurrencyLabel.text = "$ \(String(format: "%.3f", getModel.price ?? 0))"
        }
    }
    
    // MARK: - Setup Name Currency Label
    private  func setupNameCurrencyLabel() {
        view.addSubview(nameCurrencyLabel)
        
        nameCurrencyLabel.frame = CGRect(x: view.frame.minX + 30, y: view.frame.minY + 100, width: view.frame.width, height: 50)
        nameCurrencyLabel.font = UIFont.systemFont(ofSize: 32)
        nameCurrencyLabel.textColor = .white
    }
    
    // MARK: - Setup Price Currency Label
    private func setupPriceCurrencyLabel() {
        view.addSubview(priceCurrencyLabel)
        
        priceCurrencyLabel.frame = CGRect(x: view.frame.minX + 30, y: view.frame.minY + 160, width: view.frame.width, height: 50)
        priceCurrencyLabel.font = UIFont.systemFont(ofSize: 44)
        priceCurrencyLabel.textColor = .white
    }
}
