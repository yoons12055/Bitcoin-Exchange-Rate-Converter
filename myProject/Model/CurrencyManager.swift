//
//  CurrencyManager.swift
//  myProject
//
//  Created by Roy on 2022/07/15.
//

import Foundation
import UIKit

protocol CurrencyManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CurrencyManager {
    var delegate : CurrencyManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "3D715AB5-9B78-4A26-9EE0-64C651FBB0B8"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCurrency(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
                if let safeData = data {
                    let currencyRate = self.parseJSON(safeData)
                    let priceString = String(format: "%.1f", currencyRate!)
                    self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                }
            }
            task.resume()
            }
        }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeRates.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
