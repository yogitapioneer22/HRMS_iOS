//
//  OnboardingDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 30/12/22.
//

import UIKit

class OnboardingDetailsVC: UIViewController,UITableViewDelegate ,UITableViewDataSource {
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnboardingTableViewCell", for: indexPath) as? OnboardingTableViewCell
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


}
