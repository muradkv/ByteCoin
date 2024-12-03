//
//  CoinData.swift
//  ByteCoin
//
//  Created by murad on 03.12.2024.
//

import Foundation

struct CoinModel: Decodable {
    let cryptoCurrency: String
    let fiatCurrency: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
    
    enum CodingKeys: String, CodingKey {
        case cryptoCurrency = "asset_id_base"
        case fiatCurrency = "asset_id_quote"
        case rate
    }
}
