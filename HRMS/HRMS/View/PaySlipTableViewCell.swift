//
//  PaySlipTableViewCell.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 27/12/22.
//

import UIKit

class PaySlipTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMonth: UILabel!
    
    @IBOutlet weak var lblDiduction: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
