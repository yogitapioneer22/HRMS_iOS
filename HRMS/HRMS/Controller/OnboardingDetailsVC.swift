//
//  OnboardingDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 30/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class OnboardingDetailsVC: UIViewController,UITableViewDelegate ,UITableViewDataSource {
 var menuList = ["Basic Details","Family Details","Professional Details","Educatioal Details","Address Information","Emergency Information","Bank Details","Complience Details","References","Documents Upload","Upload Pic, Sign & CV","Upload Other Docs"]
    var ImagesList = ["ic_personal", "ic_family", "ic_work", "ic_educational","ic_address", "ic_reference","ic_online_payment", "ic_form", "ic_reference", "ic_upload","ic_photo_sign", "ic_viewdocs"]

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      //  txtBloodGroup.setLeftPaddingPoints(10)
        btnSignOut.layer.cornerRadius = 5.0
        btnSignOut.layer.masksToBounds = true
        btnSignOut.layer.borderWidth = 1.0
        btnSignOut.layer.borderColor = UIColor.white.cgColor
        btnSubmit.layer.cornerRadius = 5.0
        btnSubmit.layer.masksToBounds = true
        
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.logoutApi()
            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnboardingTableViewCell", for: indexPath) as? OnboardingTableViewCell
        cell!.lblMenu.text = menuList[indexPath.row]
        cell?.imgViewList?.image = UIImage(named: ImagesList[indexPath.row])
        cell!.layer.borderColor = #colorLiteral(red: 0.8760159016, green: 0.8892851472, blue: 0.889052093, alpha: 0.5437140432)
        cell!.layer.borderWidth = 5

        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BasicDetailsVC") as! BasicDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 1{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FamilyDetailsVC") as! FamilyDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 2{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 3{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EducationDetailsVC") as! EducationDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 4{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddressDetailsVC") as! AddressDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 5{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmergencyDetailVC") as! EmergencyDetailVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 6{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BAnkDetailsVC") as! BAnkDetailsVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 7{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ComplienceVC") as! ComplienceVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 8{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ComplienceVC") as! ComplienceVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 9{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ComplienceVC") as! ComplienceVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 10{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ComplienceVC") as! ComplienceVC
            self.present(nextViewController, animated:true, completion:nil)
        }else if indexPath.row == 11{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ComplienceVC") as! ComplienceVC
            self.present(nextViewController, animated:true, completion:nil)
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
                                //refreshAlert .dismiss(animated: true, completion: nil)
                                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                                 UserDefaults.standard.synchronize()
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewJointRegister") as! NewJointRegister
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
