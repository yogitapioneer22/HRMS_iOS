//
//  NewJointRegister.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
class NewJointRegister: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var imgPassword: UIImageView!
    
    @IBOutlet weak var btnSign: UIButton!
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
        btnSign.layer.cornerRadius = 10
        self.txtPassword.isSecureTextEntry = true
        passwordView.layer.borderColor = UIColor.black.cgColor
        txtPassword.delegate = self

    }
    @IBAction func showPassword(_ sender: Any) {
        if btnShowPass.isSelected {
            btnShowPass.isSelected = false
            imgPassword.image = UIImage(named:"ic_passwordShow_eye")

           // btnShowPass.setImage(#imageLiteral(resourceName: "ic_passwordHide_eye"), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        }else {
            btnShowPass.isSelected = true
            imgPassword.image = UIImage(named:"ic_passwordHide_eye")
           // btnShowPass.setImage(#imageLiteral(resourceName: "ic_passwordShow_eye"), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
    @IBAction func loginAction(_ sender: Any) {
        
        callLoginApi()
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        self.present(nextViewController, animated:true, completion:nil)
        
        if txtEmail.text!.isValidEmail() {
            
            
            if Reachability.isConnectedToNetwork() {
                print("Internet connection OK")
                DispatchQueue.main.async {
                    self.callLoginApi()
                    
                }
            } else {
                print("Internet connection FAILED")
                let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "", message: " Please Enter valid email id", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    func callLoginApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/Joineelogin"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)

        let parameters = [
            "email": String(txtEmail.text!),
            "password": String(txtPassword.text!),
                    "fcm_token": "",
                    "m_version": "1"
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
                        let token = data["token"].string
                        
                        AppConstants().defaults.set(token, forKey: "token")
//                        AppConstants().defaults.set(email_id, forKey: "EmailId")
//                        AppConstants().defaults.set(phone, forKey: "Phone")
                        
                      print(status)
                            
                            if status == "200"{
                                
                                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                UserDefaults.standard.synchronize()
                                let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                                self.present(alert, animated: true) {
                                   sleep(2)
                                   alert.dismiss(animated: true)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IntroOnboardingVC") as! IntroOnboardingVC
                                    self.present(nextViewController, animated:true, completion:nil)
                                    
                            
                                })
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
