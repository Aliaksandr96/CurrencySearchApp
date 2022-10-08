//
//  CurrencyTableViewCell.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 08/10/2022.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currencyNameLabel.font = UIFont.systemFont(ofSize: 20)
        currencyPriceLabel.font = UIFont.systemFont(ofSize: 20)
    }
    func setLabels(nameLabel: String, priceLabel: String) {
        currencyNameLabel.text = nameLabel
        currencyPriceLabel.text = priceLabel
    }
    
    func settingLayerCell(cell: UITableViewCell) {
          cell.layer.cornerRadius = 15
          cell.layer.borderWidth = 10
    }
}
