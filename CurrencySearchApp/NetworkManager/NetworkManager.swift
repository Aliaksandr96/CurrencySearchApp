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
    
    func getCurrencyFromApi(completion: @escaping(Result<[CurrencyModel],Error>)-> Void) {
        guard let url = URL(string: Constants.urlString + ApiKey.key) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode([CurrencyModel].self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(error))
            }
        }
        }.resume()
    }
}