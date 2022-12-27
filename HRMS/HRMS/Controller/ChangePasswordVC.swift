//
//  ChangePasswordVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 17/12/22.
//

import UIKit

class ChangePasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.present(nextViewController, animated:true, completion:nil)
    }


}
