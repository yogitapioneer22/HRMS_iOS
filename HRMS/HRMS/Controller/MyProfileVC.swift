//
//  MyProfileVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 16/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
class MyProfileVC: UIViewController {

    
    @IBOutlet weak var txtEmaIl: UITextField!
    
    @IBOutlet weak var txtQualification: UITextField!
    @IBOutlet weak var txtReportingM: UITextField!
    @IBOutlet weak var txtLevel: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtDOJ: UITextField!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backView.layer.cornerRadius = 40
        allInfoApi()
    }
    

    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func allInfoApi(){
        let loginUrl = AppConstants().baseUrl + "Userlogin/allinfo"
        
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
                        let data = json["data"]
                        let token = data["token"].string
                        let username = data["username"].string
                        let emp_id = data["emp_id"].string
                        let designation = data["designation"].string
                        let doj = data["doj"].string
                        let department = data["department"].string
                        let level = data["level"].string
                        let reportingTo = data["reportingTo"].string
                        let highest_qual = data["highest_qual"].string
                        let official_email = data["official_email"].string
                        let company_profile = data["company_profile"].string
                        AppConstants().defaults.set(company_profile, forKey: "company_profile")
//                        AppConstants().defaults.set(company_profile, forKey: "company_profile")
//                        AppConstants().defaults.set(company_profile, forKey: "company_profile")
//                        AppConstants().defaults.set(company_profile, forKey: "company_profile")
//                        AppConstants().defaults.set(company_profile, forKey: "company_profile")
                   
                      print(status)
                    if status == "200"{
                                self.lblName.text = username
                                self.lblDetail.text = emp_id
                                self.txtDOJ.text = doj
                                self.txtDesignation.text = designation
                                self.txtDepartment.text = department
                                self.txtLevel.text = level
                                self.txtReportingM.text = reportingTo
                                self.txtQualification.text = highest_qual
                                self.txtEmaIl.text = official_email
                                
                                
//
//                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
//
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//                                    self.present(nextViewController, animated:true, completion:nil)
//
//                                }))
//                                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//                                    refreshAlert .dismiss(animated: true, completion: nil)
//                                }))
//                                self.present(refreshAlert, animated: true, completion: nil)
//                            }else{
//
//                                let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
//
//                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
//                                    refreshAlert .dismiss(animated: true, completion: nil)
//
//                                }))
//
//                                self.present(refreshAlert, animated: true, completion: nil)
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
