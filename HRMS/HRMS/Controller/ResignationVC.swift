//
//  ResignationVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 19/12/22.
//

import UIKit

class ResignationVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    var views = Array<UIView>()

    override func viewDidLoad() {
        super.viewDidLoad()

        views.append(ResignationRequest().view!)
            views.append(ResignationStatus().view!)
        for veiw in views{
            containerView.addSubview(veiw)
        }
        
    }
    @IBAction func segmentAction(_ sender: Any) {
        containerView.bringSubviewToFront(views[(sender as AnyObject).selectedSegmentIndex])

    }
    @IBAction func backButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    

}
