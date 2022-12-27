//
//  DispatchVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 26/12/22.
//

import UIKit

class DispatchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func diaryAcceptance(_ sender: Any) {
    }
    
    @IBAction func dispatchCourier(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DispatchCourierVC") as! DispatchCourierVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
