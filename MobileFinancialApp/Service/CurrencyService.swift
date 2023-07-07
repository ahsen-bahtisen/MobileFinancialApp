//
//  CurrencyService.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation
import Alamofire

class CurrencyService {
    
    func apiRequest(url: String, completion: @escaping (CurrencyModel) -> Void) {
        AF.request(url).responseDecodable(of: CurrencyModel.self) { response in
            switch response.result {
            case .success(let currencies):
                completion(currencies)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

