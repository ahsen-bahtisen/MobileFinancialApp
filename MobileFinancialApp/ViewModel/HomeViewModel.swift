//
//  HomeViewModel.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation
import Firebase

class HomeViewModel {
    
    func fetchTotalBudget(completion: @escaping (Double) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(0)
            return
        }
        
        let ref = Database.database().reference().child("users").child(userId)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let userData = snapshot.value as? [String: Any],
               let totalBudget = userData["totalBudget"] as? Double {
                completion(totalBudget)
            } else {
                completion(0)
            }
        }
    }
}


