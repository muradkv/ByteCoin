//
//  CoinManager.swift
//  ByteCoin
//
//  Created by murad on 03.12.2024.
//

import Foundation

protocol CoinManagerDelegate: AnyObject {
    func didUpdateRate(_ coinManager: CoinManager, coinData: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "9E2B8E09-37EF-4B8B-AC42-3727734635EA#"
    //    let apiKey = "729A4687-6281-47EA-9CB9-203F88E574BD"
    //    let apiKey = "CBB743E8-3FE8-4FD2-A79B-EF92CA9DEE7E"
    
    weak var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchRate(for fiatCurrency: String) {
        let urlString = baseURL + "/\(fiatCurrency)" + "?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Bad URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            
            guard let data else {
                return
            }
            
            if let coinModel = self.parseJSON(data) {
                delegate?.didUpdateRate(self, coinData: coinModel)
            }
        }
        
        task.resume()
    }
    
    private func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)
            let cryptoCurrency = decodedData.cryptoCurrency
            let fiatCurrency = decodedData.fiatCurrency
            let rate = decodedData.rate
            
            let coin = CoinModel(cryptoCurrency: cryptoCurrency, fiatCurrency: fiatCurrency, rate: rate)
            return coin
        } catch {
            self.delegate?.didFailWithError(error: error)
            let coin = CoinModel(cryptoCurrency: "BTC", fiatCurrency: "Unknown", rate: 0)
            return coin
        }
    }
}
