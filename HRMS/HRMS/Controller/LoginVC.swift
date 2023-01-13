//
//  LoginVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 15/12/22.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var btnPasscode: UIButton!
    @IBOutlet weak var btnEmpId: UIButton!
    @IBOutlet weak var employeeContainer: UIView!
    @IBOutlet weak var passcodeContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.employeeContainer.isHidden = true
        self.passcodeContainer.isHidden = false
        self.buttonBackgroundView.layer.cornerRadius = 8
        self.btnEmpId.layer.cornerRadius = 15
        self.btnPasscode.layer.cornerRadius = 15
        
    }
    
    @IBAction func btnEplyeeAction(_ sender: Any) {
        self.btnPasscode.backgroundColor = .clear
        self.btnEmpId.backgroundColor = #colorLiteral(red: 0.5355603099, green: 0.7724923491, blue: 0.2494862974, alpha: 1)
        self.btnPasscode.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.btnEmpId.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnPasscode.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.employeeContainer.isHidden = true
        self.passcodeContainer.isHidden = false
       
       
    }
    //    required init?(coder : NSCoder) {
    @IBAction func btnPasscodeAction(_ sender: Any) {
        self.btnEmpId.backgroundColor = .clear
        self.btnPasscode.backgroundColor = #colorLiteral(red: 0.5355603099, green: 0.7724923491, blue: 0.2494862974, alpha: 1)
        self.btnEmpId.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.btnPasscode.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.employeeContainer.isHidden = false
        self.passcodeContainer.isHidden = true
    }
    //        super.init(coder: coder)
//    }
    
}
