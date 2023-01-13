//
//  SideMenuVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 16/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class SideMenuVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    var menuList = ["Dashboard","Company Info","Aply Loan","Diary Dispatch","Investment Declaration","Non CTC","Registration","Visiting Cards","Update Bank Details","Extention No. List","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func backAction(_ sender: Any) {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.present(nextViewController, animated:true, completion:nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (sideMenuTableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell)!
        cell.lblMenu.text = menuList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 1{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyInfoVC") as! CompanyInfoVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 2{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ApplyLoanVC") as! ApplyLoanVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 3{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DispatchVC") as! DispatchVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 4{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DispatchVC") as! DispatchVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        if indexPath.row == 5{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 6{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResignationVC") as! ResignationVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 7{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DispatchVC") as! DispatchVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 8{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateBankDetailsVC") as! UpdateBankDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == 9{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateBankDetailsVC") as! UpdateBankDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        else if indexPath.row == menuList.count - 1{
            
            let refreshAlert = UIAlertController(title: "", message: "Are you sure want to Logout?", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                if Reachability.isConnectedToNetwork() {
                    print("Internet connection OK")
                    DispatchQueue.main.async {
                        self.logoutApi()
                        
                    }
                } else {
                    print("Internet connection FAILED")
                    let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                //self.present(refreshAlert, animated: true, completion: nil)

                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
                                                   }))
            self.present(refreshAlert, animated: true, completion: nil)
           
        }
    }
    
    func logoutApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/Joineelogout"
        
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
         let appToken =  UserDefaults.standard.string(forKey: "token")
        let parameters = [
            "token": appToken
                ] as? [String:AnyObject]
     print(parameters)
        AF.request(loginUrl, method: .post, parameters: parameters! as Parameters, encoding: URLEncoding.default, headers: headers).responseJSON {
                    response in
            LoadingOverlay.shared.hideOverlayView()

                    switch (response.result) {

                    case .success(let value):
                        print(response)
                        
                       let statusCode = response.response?.statusCode
                      print(statusCode)
                        
                let json = JSON(value)
                        print(json)
                        
                        let message = json["msg"].string
                        let status = json["status"]
                        let data = json["data"].arrayValue
  
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        //self.present(refreshAlert, animated: true, completion: nil)
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                                self.present(nextViewController, animated:true, completion:nil)
                                
                            }))
                            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                            refreshAlert .dismiss(animated: true, completion: nil)
                                                                   }))
                            self.present(refreshAlert, animated: true, completion: nil)
                      
                   
                      print(status)
                    if status == "200"{
    
                            }
                    
                        
                        break
                    case .failure:
                        print(Error.self)
                        let refreshAlert = UIAlertController(title: "", message: "Something went wrong!", preferredStyle: UIAlertController.Style.alert)

                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            self.present(refreshAlert, animated: true, completion: nil)

                            
                        }))
                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                        refreshAlert .dismiss(animated: true, completion: nil)
                                                               }))
                        self.present(refreshAlert, animated: true, completion: nil)
                       
                    }
                }
}
}
