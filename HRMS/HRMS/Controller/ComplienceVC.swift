//
//  ComplienceVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit

class ComplienceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    

    @IBAction func form11(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Form11VC") as! Form11VC
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
     @IBAction func esic(_ sender: Any) {
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Form11VC") as! Form11VC
         self.present(nextViewController, animated:true, completion:nil)
     }
     @IBAction func form2(_ sender: Any) {
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Form2VC") as! Form2VC
         self.present(nextViewController, animated:true, completion:nil)
     }
     @IBAction func graduaty(_ sender: Any) {
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Form2VC") as! Form2VC
         self.present(nextViewController, animated:true, completion:nil)
     }
     @IBAction func paymentWages(_ sender: Any) {
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentWagesVC") as! PaymentWagesVC
         self.present(nextViewController, animated:true, completion:nil)
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


}
