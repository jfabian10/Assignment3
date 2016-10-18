//
//  CompaniesTableViewCell.swift
//  Companies
//
//  Created by CS3714 on 10/16/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class CompaniesTableViewCell: UITableViewCell {
    
    
    
 
    @IBOutlet var companyCodeLabel: UILabel!
    
    
    @IBOutlet var companyImageView: UIImageView!
    
    
    @IBOutlet var companyNameLabel: UILabel!
    
    @IBOutlet var companyCityLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
