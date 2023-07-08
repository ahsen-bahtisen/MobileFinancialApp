//
//  ExpenseViewModel.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation
import Firebase

class ExpenseViewModel {
    
    private var totalBudget: Double = 0
    
    init() {
        loadTotalBudget()
    }
    
    private func loadTotalBudget() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(userId)
        ref.observe(.value) { [weak self] (snapshot) in
            guard let userData = snapshot.value as? [String: Any],
                  let totalBudget = userData["totalBudget"] as? Double else {
                return
            }
            
            self?.totalBudget = totalBudget
        }
    }
    
    func addIncome(amount: Double) {
        totalBudget += amount
    }
    
    func addExpense(amount: Double) {
        totalBudget -= amount
    }
    
    func saveChanges(completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let ref = Database.database().reference().child("users").child(userId)
        ref.updateChildValues(["totalBudget": totalBudget]) { (error, _) in
            if let error = error {
                print("Failed to save changes: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

