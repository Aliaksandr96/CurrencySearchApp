//
//  CurrencyListPresenter.swift
//
//  Created by Aliaksandr Hunko on 30/10/2022
//

import Foundation

protocol CurrencyListPresenterProtocol {
    func getCurrency()
    func moveToDetailView(with model: CurrencyModel)
    var currency: [CurrencyModel] { get }
}

final class CurrencyListPresenter: CurrencyListPresenterProtocol {
    
    // MARK: Public
    unowned var view: CurrencyListViewProtocol
    var currency: [CurrencyModel] = []
    
    // MARK: Private
    private let router: CurrencyListRouterProtocol
    
    // MARK: - Lifecycle
    init(view:CurrencyListViewProtocol, router: CurrencyListRouterProtocol){
        self.view = view
        self.router = router
        getCurrency()
    }
    
    // MARK: - API
    func getCurrency() {
        let urlString = "https://rest.coinapi.io/v1/assets?apikey=60C0590F-E58A-4B64-9F94-FB080379A228"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode([CurrencyModel].self, from: data)
                DispatchQueue.main.async {
                    self?.currency = jsonData
                    self?.view.updateTable()
                }
            } catch {
                print("We have error in block catch : \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func moveToDetailView(with model: CurrencyModel) {
        router.moveToDetailCurrencyScreen(with: model)
    }
}

