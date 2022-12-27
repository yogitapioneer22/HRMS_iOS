//
//  PasscodeVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 14/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class PasscodeVC: UIViewController ,CustomAlertDelegate{
    func cancelButtonPressed(_ alert: ForgotPasswordView, alertTag: Int) {
        print("Cancell")
    }
    
    
    @IBOutlet weak var txtPass2: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var txtPass4: UITextField!
    @IBOutlet weak var txtPass3: UITextField!
    @IBOutlet weak var txtPass1: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logiAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.callLoginApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func okButtonPressed(_ alert: ForgotPasswordView, alertTag: Int) {
       print("OK Clicked")
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        let customAlert = ForgotPasswordView()
        customAlert.alertTitle = "Thank you"
        customAlert.alertMessage = "Your order successfully done."
        customAlert.alertTag = 1
       // customAlert.statusImage = UIImage.init(named: "smiley")
        customAlert.isCancelButtonHidden = true
        customAlert.delegate = self
        customAlert.show()

    }
    @IBAction func dontHaveAc(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func callLoginApi(){
        let loginUrl = AppConstants().baseUrl + "Userlogin/loginwithpasscode"
        let headers:HTTPHeaders = [
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let passcode = String(txtPass1.text! + txtPass2.text! + txtPass3.text! + txtPass4.text!)
        let parameters = [
                    "passcode": passcode,
                    "device_token": "5555"
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
                        
                        AppConstants().defaults.set(emp_id, forKey: "EmpId")
                        AppConstants().defaults.set(email_id, forKey: "EmailId")
                        AppConstants().defaults.set(phone, forKey: "Phone")
                        
                        print(status)
                            
                        if status == "200"{
                                
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                                
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPVC") as! VerifyOTPVC
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
