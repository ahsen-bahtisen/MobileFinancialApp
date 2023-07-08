//
//  HomeViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 12
        ref = Database.database().reference()
        
        fetchUserData()
    }
    
    private func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(userId)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let userData = snapshot.value as? [String: Any] {
                let totalBudget = userData["totalBudget"] as? Double
                let income = userData["income"] as? Double
                let expenses = userData["expenses"] as? Double
                
                // Verileri kullanarak işlemler yapabilirsiniz. Örneğin, label'ları güncelleyebilirsiniz.
                self.totalLabel.text = "\(totalBudget ?? 0)"
                // Diğer label'ları da güncelleyin...
            }
        }
    }


    @IBAction func addExpense(_ sender: Any) {
        
        
    }
    
}
