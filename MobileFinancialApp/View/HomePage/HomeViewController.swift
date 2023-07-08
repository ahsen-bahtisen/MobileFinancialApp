//
//  HomeViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, ExpenseViewControllerDelegate {


    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    var ref: DatabaseReference?
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
           super.viewDidLoad()

           cardView.layer.cornerRadius = 12
           ref = Database.database().reference()
           viewModel = HomeViewModel()
           
       }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTotalBudget()
    }
    
    func expenseViewControllerDidSaveChanges() {
            fetchTotalBudget()
        }
        
         func fetchTotalBudget() {
            viewModel.fetchTotalBudget { [weak self] totalBudget in
                DispatchQueue.main.async {
                    self?.updateTotalBudget(totalBudget)
                    //print(totalBudget)
                }
            }
        }
        
        func updateTotalBudget(_ totalBudget: Double) {
            DispatchQueue.main.async {
                self.totalLabel.text = "\(totalBudget)"
                //print(totalBudget)
            }
        }
}
