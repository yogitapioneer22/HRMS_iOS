//
//  VerifyOTPVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 24/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class VerifyOTPVC: UIViewController {
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtCode1: UITextField!
    
    @IBOutlet weak var txtCode6: UITextField!
    @IBOutlet weak var txtCode5: UITextField!
    @IBOutlet weak var txtCode4: UITextField!
    @IBOutlet weak var txtCode3: UITextField!
    @IBOutlet weak var txtCode2: UITextField!
    var empId = ""
    
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnVerify.layer.cornerRadius = 20
        self.btnResend.layer.cornerRadius = 20
        self.empId = AppConstants().defaults.string(forKey: "EmpId")  ?? "NA"
    }
    @IBAction func back(_ sender: Any) {
    }
    
    @IBAction func otpAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.verifyOtpApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func resendOtp(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func verifyOtpApi(){
        let loginUrl = AppConstants().baseUrl + "Userlogin/otpverify"
        
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        var otp = String(txtCode1.text! + txtCode2.text! + txtCode3.text! + txtCode4.text! + txtCode5.text! + txtCode6.text!)
        let parameters = [
            "empid": empId,
            "phone_otp": otp,
            "otp_ids[]": "1",
            "m_version": "5",
            "fcm_token":"dfsf",
            "device_token":"sd"
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
                        let designation = data["designation"].string
                        
                        AppConstants().defaults.set(token, forKey: "token")
                        AppConstants().defaults.set(username, forKey: "username")
                        AppConstants().defaults.set(designation, forKey: "designation")
                        
                      print(status)
                            
                            if status == "200"{
                                
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                                
                                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                                    self.present(nextViewController, animated:true, completion:nil)
                                    
                                }))
                                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                                    refreshAlert .dismiss(animated: true, completion: nil)
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
