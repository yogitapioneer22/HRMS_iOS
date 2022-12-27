//
//  SettingVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit

class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var backButtonAction: UIButton!
    var menuList = ["My Profile","Change Password","Change Pascode","FAQs","About Us"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell)!
        cell.lblMenu.text = menuList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 1{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 2{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GeneratePasscodeVC") as! GeneratePasscodeVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 3{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 4{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
    }

}
