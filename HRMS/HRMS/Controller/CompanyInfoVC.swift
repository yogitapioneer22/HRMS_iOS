//
//  CompanyInfoVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit
import PDFKit

class CompanyInfoVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var menuList = ["Company Profile","Internet Policy","Reimbursementy Policy","POSHA Act Policy","Loan Policy","Leave Policy", "General Administrative Policy_2023"]
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.string(forKey: "company_profile")    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell", for: indexPath) as? CompanyInfoTableViewCell)!
        cell.lblMenu.text = menuList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let companyURL = "https://pioneerhrms.com/hrms_app/uploads/company_profile/MzQx.pdf"
        if indexPath.row == 0{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if indexPath.row == 1{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if indexPath.row == 2{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if indexPath.row == 3{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if indexPath.row == 4{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if indexPath.row == 5{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if indexPath.row == 6{
            guard let url = URL(string:companyURL) else {
              return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}
