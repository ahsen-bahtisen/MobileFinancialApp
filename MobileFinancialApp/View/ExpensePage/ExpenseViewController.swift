//
//  ExpenseViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit
import Firebase


protocol ExpenseViewControllerDelegate: AnyObject {
    func expenseViewControllerDidSaveChanges()
    func updateTotalBudget(_ totalBudget: Double)
}



class ExpenseViewController: UIViewController {
    
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var remarkText: UITextField!
    @IBOutlet weak var selectionSC: UISegmentedControl!
    
    weak var delegate: ExpenseViewControllerDelegate?
    private var viewModel: ExpenseViewModel!
    private var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ExpenseViewModel()
        homeViewModel = HomeViewModel()
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
        
        UserDefaults.standard.set(amountText.text, forKey: "amountText")
        UserDefaults.standard.set(remarkText.text, forKey: "remarkText")
        
        // Değişiklikleri kaydetmek için Firebase Realtime Database'e gönderin
        viewModel.saveChanges { [weak self] success in
            if success {
                // Değişiklikler kaydedildi
                self?.delegate?.expenseViewControllerDidSaveChanges()
                
                // Gerekli temizlik işlemleri
                self?.amountText.text = ""
                self?.remarkText.text = ""
                
                // Kullanıcı HomeViewController'a dönsün
                self?.navigationController?.popViewController(animated: true)
                
                // Total bütçeyi güncellemek için HomeViewModel'dan fetchTotalBudget() fonksiyonunu çağırın
                self?.homeViewModel.fetchTotalBudget { totalBudget in
                    DispatchQueue.main.async {
                        self?.delegate?.updateTotalBudget(totalBudget)
                        print(totalBudget)
                    }
                }
            } else {
                print("Failed to save changes")
            }
        }
    }
}
    

