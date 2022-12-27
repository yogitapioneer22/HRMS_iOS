//
//  TaskReminderVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 18/12/22.
//

import UIKit

class TaskReminderVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var views = Array<UIView>()

    override func viewDidLoad() {
        super.viewDidLoad()

        views.append(SetReminderView().view!)
            views.append(RemiderStatusView().view!)
        for veiw in views{
            containerView.addSubview(veiw)
        }
            }
    
    @IBAction func menu(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func ActionSegment(_ sender: Any) {
        containerView.bringSubviewToFront(views[(sender as AnyObject).selectedSegmentIndex])

    }

}
