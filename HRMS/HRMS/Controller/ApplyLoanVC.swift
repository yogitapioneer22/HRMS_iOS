//
//  ApplyLoanVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 19/12/22.
//

import UIKit

class ApplyLoanVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var views = Array<UIView>()

    override func viewDidLoad() {
        super.viewDidLoad()

        views.append(AplyLoanView().view!)
            views.append(AplyLoanStatusView().view!)
            for veiw in views{
                containerView.addSubview(veiw)
            }
        containerView.bringSubviewToFront(views[0])    }
    
    @IBAction func segmentAction(_ sender: Any) {
        containerView.bringSubviewToFront(views[(sender as AnyObject).selectedSegmentIndex])

    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
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
