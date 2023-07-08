//
//  ExpenseViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit
import Firebase

class ExpenseViewController: UIViewController {

    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var remarkText: UITextField!
    @IBOutlet weak var selectionSC: UISegmentedControl!
    
    private var viewModel: ExpenseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ExpenseViewModel()
    
    }
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let amountString = amountText.text, !amountString.isEmpty,
                      let amount = Double(amountString) else {
                    print("Invalid amount")
                    return
                }
                
                let remark = remarkText.text ?? ""
                
                if selectionSC.selectedSegmentIndex == 0 {
                    // Gelir
                    viewModel.addIncome(amount: amount)
                } else {
                    // Gider
                    viewModel.addExpense(amount: amount)
                }
                
                // Değişiklikleri kaydetmek için Firebase Realtime Database'e gönderin
                viewModel.saveChanges { [weak self] success in
                    if success {
                        // Değişiklikler kaydedildi, güncel verileri al ve görüntüle
                        self?.viewModel.fetchTotalBudget { totalBudget in
                            // Güncellenmiş totalBudget'i görüntüle
                            print("Total Budget: \(totalBudget)")
                        }
                        
                        // Gerekli temizlik işlemleri
                        self?.amountText.text = ""
                        self?.remarkText.text = ""
                    } else {
                        print("Failed to save changes")
                    }
                }
            }
}
    

