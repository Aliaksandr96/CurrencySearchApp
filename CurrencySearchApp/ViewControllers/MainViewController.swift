//
//  ViewController.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 07/10/2022.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var currencyTableView: UITableView!
    
    // MARK: - UI Elements
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Constants
    private let detailViewController = DetailViewController()
    
    // MARK: - Varibles
   private var currencyArray = [CurrencyModel]()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCurrencyTable()
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrencyFromApi()
        setupActivityIndicator()
    }
    
    // MARK: - Setup Activity Indicator
    private func setupActivityIndicator() {
        activityIndicator.color = .blue
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    //MARK: - Get Currency From Api
    private func getCurrencyFromApi() {
        NetworkManager.shared.getCurrencyFromApi { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currencyData):
                    self?.currencyArray = currencyData
                    
                    self?.currencyTableView.reloadData()
                    self?.activityIndicator.removeFromSuperview()
                    
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Setup Currency Table
    private func setupCurrencyTable() {
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        
        currencyTableView.rowHeight = 90
        
        currencyTableView.backgroundColor = UIColor(named: "backgroundColor")
        currencyTableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell()}
        
        cell.settingLayerCell(cell: cell)
        
        let priceCurrency =  String(format: "%.3f", currencyArray[indexPath.row].price ?? 0)
        let nameCurrency = currencyArray[indexPath.row].name
        
        cell.setLabels(nameLabel: nameCurrency, priceLabel: "$ \(priceCurrency)")
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveSelectRow = currencyArray[indexPath.row].id
        
        detailViewController.setIdCurrency(currencyID: saveSelectRow)
        
            navigationController?.pushViewController(detailViewController, animated: true)
    }
}