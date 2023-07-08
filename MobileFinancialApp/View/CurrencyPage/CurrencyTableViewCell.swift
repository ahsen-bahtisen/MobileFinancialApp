//
//  CurrencyTableViewCell.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var currencyLabel: UILabel!
    
    //MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
