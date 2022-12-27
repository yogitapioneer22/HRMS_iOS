//
//  NewJointRegister.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit

class NewJointRegister: UIViewController {

    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var Emailview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Emailview.layer.borderWidth = 1
        Emailview.layer.cornerRadius = 10
        Emailview.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.borderWidth = 1
        passwordView.layer.cornerRadius = 10

        passwordView.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func loginAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    

}
