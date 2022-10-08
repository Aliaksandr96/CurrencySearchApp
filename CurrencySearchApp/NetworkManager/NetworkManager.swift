//
//  NetworkManager.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 07/10/2022.
//

import Foundation

final class NetworkManager {
    
    enum Constants {
        static let urlString = "https://rest.coinapi.io/v1/assets?apikey="
    }
    enum ApiKey {
        static let key = "60C0590F-E58A-4B64-9F94-FB080379A228"
    }
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getCurrencyFromApi() {
        
    }
}
