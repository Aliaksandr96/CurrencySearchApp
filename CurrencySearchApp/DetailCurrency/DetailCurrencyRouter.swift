//
//  DetailCurrencyRouter.swift
//
//  Created by Aliaksandr Hunko on 30/10/2022
//

import UIKit

protocol DetailCurrencyRouterProtocol {
    
}

final class DetailCurrencyRouter {
    // MARK: Private
    private let navigationController: UINavigationController
    private let currentCurrencyModel: CurrencyModel
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController, model: CurrencyModel) {
        self.navigationController = navigationController
        self.currentCurrencyModel = model
        let view = DetailCurrencyViewController()
        let presenter = DetailCurrencyPresenter(view: view, router: self, model: model)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
}

// MARK: - Extensions
extension DetailCurrencyRouter: DetailCurrencyRouterProtocol {
    
}
