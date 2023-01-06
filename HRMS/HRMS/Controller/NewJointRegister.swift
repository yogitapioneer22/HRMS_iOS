//
//  NewJointRegister.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
class NewJointRegister: UIViewController {

    @IBOutlet weak var btnShowPass: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var Emailview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Emailview.layer.borderWidth = 1
        Emailview.layer.cornerRadius = 10
        Emailview.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.borderWidth = 1
        passwordView.layer.cornerRadius = 10

        passwordView.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func showPassword(_ sender: Any) {
    }
    @IBAction func loginAction(_ sender: Any) {
        
        callLoginApi()
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        self.present(nextViewController, animated:true, completion:nil)
    }
    func callLoginApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/Joineelogin"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)

        let parameters = [
            "empid": String(txtEmail.text!),
            "password": String(txtPassword.text!),
                    "device_token": "sd",
                    "m_version": "3"
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
                        let status = json["status"].string
                        let data = json["data"]
                        let emp_id = data["emp_id"].string
                        let email_id = data["email_id"].string
                        let phone = data["phone"].string
                        
//                        AppConstants().defaults.set(emp_id, forKey: "EmpId")
//                        AppConstants().defaults.set(email_id, forKey: "EmailId")
//                        AppConstants().defaults.set(phone, forKey: "Phone")
                        
                      print(status)
                            
                            if status == "200"{
                                
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                                
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
                                    self.present(nextViewController, animated:true, completion:nil)
                                    
                                }))
                        
                                self.present(refreshAlert, animated: true, completion: nil)
                            }else{
                                
                                let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                                
                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                    refreshAlert .dismiss(animated: true, completion: nil)
                                    
                                }))

                                self.present(refreshAlert, animated: true, completion: nil)
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
