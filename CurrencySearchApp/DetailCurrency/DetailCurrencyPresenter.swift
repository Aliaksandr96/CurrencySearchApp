//
//  DetailCurrencyPresenter.swift
//
//  Created by Aliaksandr Hunko on 30/10/2022
//

import Foundation

protocol DetailCurrencyPresenterProtocol {
    func getCurrentCurrencyModel()
}

final class DetailCurrencyPresenter: DetailCurrencyPresenterProtocol {
    // MARK: Public
    unowned var view: DetailCurrencyViewProtocol
    
    // MARK: Private
    private let router: DetailCurrencyRouterProtocol
    private let model: CurrencyModel
    
    // MARK: - Lifecycle
    init(view:DetailCurrencyViewProtocol, router: DetailCurrencyRouterProtocol, model: CurrencyModel){
        self.view = view
        self.router = router
        self.model = model
        getCurrentCurrencyModel()
    }
    
    // MARK: - API
    func getCurrentCurrencyModel() {
        view.updateLabel(model: model)
    }
}
