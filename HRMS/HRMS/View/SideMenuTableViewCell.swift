//
//  SideMenuTableViewCell.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 16/12/22.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
