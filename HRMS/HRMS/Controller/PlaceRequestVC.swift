//
//  PlaceRequestVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 17/12/22.
//

import UIKit

class PlaceRequestVC: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    var views = Array<UIView>()
    override func viewDidLoad() {
        super.viewDidLoad()

        views.append(RaiseRequest().view!)
            views.append(RequestStatus().view!)
            for veiw in views{
                containerView.addSubview(veiw)
            }
        containerView.bringSubviewToFront(views[0])    }
    
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func segmentAction(_ sender: Any) {
        containerView.bringSubviewToFront(views[(sender as AnyObject).selectedSegmentIndex])

    }
    

}
