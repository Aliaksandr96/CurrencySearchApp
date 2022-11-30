//
//  CurrencyIconModel.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 19/10/2022.
//

import Foundation

struct CurrencyIconModel: Codable {
    let id: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "asset_id"
    case url
    }
}
