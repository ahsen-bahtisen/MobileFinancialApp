//
//  CurrencyModel.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation

struct CurrencyModel: Codable {
    let success: Bool
    let date: String
    let rates: [String: Double]
}
