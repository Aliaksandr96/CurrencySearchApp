//
//  CurrencyListRouter.swift
//
//  Created by Aliaksandr Hunko on 30/10/2022
//

import UIKit

protocol CurrencyListRouterProtocol {
    func moveToDetailCurrencyScreen(with model: CurrencyModel)
}

final class CurrencyListRouter {
    // MARK: Private
    private let navigationController: UINavigationController
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let view = CurrencyListViewController()
        let presenter = CurrencyListPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
}

// MARK: - Extensions
extension CurrencyListRouter: CurrencyListRouterProtocol {
    func moveToDetailCurrencyScreen(with model: CurrencyModel) {
        let _ = DetailCurrencyRouter(navigationController: navigationController, model: model)
    }
}
