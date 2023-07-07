//
//  CurrencyViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var viewModel: CurrencyViewModel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel = CurrencyViewModel()
            fetchDataAndUpdateUI()
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        @IBAction func convertButtonTapped(_ sender: UIButton) {
            fetchDataAndUpdateUI()
        }
        
        private func fetchDataAndUpdateUI() {
            viewModel.baseCurrency = baseTextField.text ?? "USD"
            viewModel.amount = amountTextField.text ?? "1"
            
            viewModel.fetchData { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    
    @IBAction func convertButton(_ sender: Any) {
        fetchDataAndUpdateUI()
        
    }
}


    extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.currencies?.rates.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
            
            if let currencies = viewModel.currencies {
                let currencyKeys = Array(currencies.rates.keys)
                let currency = currencyKeys[indexPath.row]
                if let rate = currencies.rates[currency] {
                    cell.currencyLabel.text = "\(currency): \(rate)"
                    self.dateLabel.text = "\(currencies.date)"
                }
            }
            
            return cell
        }
    }



