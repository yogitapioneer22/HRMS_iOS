//
//  OnboardingTableViewCell.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 30/12/22.
//

import UIKit

class OnboardingTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var imgViewList: UIImageView!
    @IBOutlet weak var imgStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}