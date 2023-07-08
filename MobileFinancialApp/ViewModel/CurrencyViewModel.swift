//
//  CurrencyViewModel.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation

class CurrencyViewModel {
    var currencyService: CurrencyService
    var baseCurrency: String
    var amount: String
    
    var currencies: CurrencyModel?
    var isMock = true
    
    init() {
        self.currencyService = CurrencyService()
        self.baseCurrency = "USD"
        self.amount = "1"
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let urlString = "https://api.exchangerate.host/latest?base=\(baseCurrency)&amount=\(amount)"
        currencyService.apiRequest(url: urlString) { [weak self] currencies in
            self?.currencies = currencies
            completion()
        }
    }
    
    
    func fetchDataMock(completion: @escaping () -> Void) {
        let urlString = "https://api.exchangerate.host/latest?base=\(baseCurrency)&amount=\(amount)"
        currencyService.apiRequest(url: urlString) { [weak self] currencies in
            self?.currencies = currencies
            completion()
        }
        

    }}
