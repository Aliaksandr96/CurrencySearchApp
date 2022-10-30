//
//  CurrencyListViewController.swift
//
//  Created by Aliaksandr Hunko on 30/10/2022
//

import UIKit

protocol CurrencyListViewProtocol: AnyObject {
    func updateTable(with model: [CurrencyModel])
    func setupActivityIndicator()
}

final class CurrencyListViewController: UIViewController {
    // MARK: Public
    var currencyArray = [CurrencyModel]()
    var presenter: CurrencyListPresenterProtocol!
    
    // MARK: Private
    private let currencyListTable = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        configureUI()
        setupBehavior()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    // MARK: - Setups
    private func setupSubviews() {
        view.addSubview(currencyListTable)
    }
    private func setupConstraints() {
        currencyListTable.translatesAutoresizingMaskIntoConstraints = false
        currencyListTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        currencyListTable.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    private func configureUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        title = "Exchange Rate"

        currencyListTable.backgroundColor = UIColor(named: "backgroundColor")
        currencyListTable.rowHeight = 90
    }
    private func setupBehavior() {
        currencyListTable.dataSource = self
        currencyListTable.delegate = self
        
        currencyListTable.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: "CurrencyListTableViewCell")
    }
}

// MARK: - Extensions
extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyListTableViewCell", for: indexPath) as? CurrencyListTableViewCell else { return UITableViewCell() }
        let priceCurrency =  String(format: "%.3f", currencyArray[indexPath.row].price ?? 0)
        
        cell.nameCurrencyLabel.text = currencyArray[indexPath.row].name
        cell.priceCurrencyLabel.text = priceCurrency
    
        return cell
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = currencyArray[indexPath.row]
        presenter.moveToDetailView(with: selectRow)
    }
}

extension CurrencyListViewController: CurrencyListViewProtocol {
    func updateTable(with model: [CurrencyModel]) {
        self.currencyArray = model
        DispatchQueue.main.async {
            self.currencyListTable.reloadData()
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.color = .blue
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
}
