//
//  CurrencyService.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation
import Alamofire

class CurrencyService {
    
    //private var items = Bundle.main.decode(type: [MockModel].self, from: "FakeJSON.json")
    
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

extension Bundle {
    func decode<T: Codable>(type: T.Type, from file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No file named: \(file) in Bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load")
        }
        
        let decoder = JSONDecoder()
        
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundel, missing file '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Type mismatch context \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(type) - context: \(context.debugDescription)")
        }  catch DecodingError.dataCorrupted(_) {
            fatalError("Wrong JSON")
        } catch {
            fatalError("Filed to decode \(file) from bundle")
        }
    }
}
