//
//  HomeViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit
import Firebase


final class HomeViewController: UIViewController, ExpenseViewControllerDelegate {
 
    //MARK: Outlets
    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    //MARK: Properties
    var ref: DatabaseReference?
    private var viewModel: HomeViewModel!
    
    var expenses: [String] = []
    var amounts: [String] = []
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesTableView.dataSource = self
        
        cardView.layer.cornerRadius = 12
        ref = Database.database().reference()
        viewModel = HomeViewModel()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTotalBudget()
        
        
        if let amountText = UserDefaults.standard.string(forKey: "amountText") {
            
            amounts.append(amountText)
        }
        
        if let remarkText = UserDefaults.standard.string(forKey: "remarkText") {
            
            expenses.append(remarkText)
        }
        
        
        expensesTableView.reloadData()
    }
    
    
    //MARK: Methods
    func expenseViewControllerDidSaveChanges() {
        fetchTotalBudget()
    }
    
    func fetchTotalBudget() {
        viewModel.fetchTotalBudget { [weak self] totalBudget in
            
            self?.updateTotalBudget(totalBudget)
            //print(totalBudget)
            
        }
    }
    
    func updateTotalBudget(_ totalBudget: Double) {
        DispatchQueue.main.async {
            self.totalLabel.text = "\(totalBudget)"
            //print(totalBudget)
        }
    }
}


    //MARK: Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! HomeTableViewCell
        
        cell.expenseLabel?.text = expenses[indexPath.row]
        cell.amountLabel?.text = amounts[indexPath.row]
        
        return cell
    }
    
    
}
