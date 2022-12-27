//
//  EmployeeIdLogin.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 15/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class EmployeeIdLogin: UIViewController {
    @IBOutlet weak var btnBysms: UIButton!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmId: UITextField!
    @IBOutlet weak var btnByEmail: UIButton!
    @IBOutlet weak var btnThumb: UIButton!
    @IBOutlet weak var btnNewJoinee: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.black.cgColor
        emailView.layer.cornerRadius = 10
        passwordView.layer.borderWidth = 1
        passwordView.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.cornerRadius = 10
        
        self.btnLogin.layer.cornerRadius = 15
        self.btnThumb.layer.cornerRadius = 15
        self.btnNewJoinee.layer.cornerRadius = 15
    }

    @IBAction func showPassword(_ sender: Any) {
    }
    @IBAction func forgotPassword(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
//        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func thumbAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func loginBtnAction(_ sender: Any) {
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
    
    @IBAction func newjoineeAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewJointRegister") as! NewJointRegister
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func callLoginApi(){
        let loginUrl = AppConstants().baseUrl + "Userlogin/login"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)

        let parameters = [
            "empid": self.txtEmId.text!,
            "password": self.txtPassword.text!,
                    "device_token": "sd",
                    "otp_ids[]": "1",
                    "m_version": "3"
                ] as? [String:AnyObject]

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
    public class LoadingOverlay{

        var overlayView = UIView()
        var activityIndicator = UIActivityIndicatorView()
        var bgView = UIView()

        class var shared: LoadingOverlay {
            struct Static {
                static let instance: LoadingOverlay = LoadingOverlay()
            }
            return Static.instance
        }

        public func showOverlay(view: UIView) {

            bgView.frame = view.frame
            bgView.backgroundColor = UIColor.gray
            bgView.addSubview(overlayView)
            bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
            overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            overlayView.center = view.center
            overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
            overlayView.backgroundColor = UIColor.black
            overlayView.clipsToBounds = true
            overlayView.layer.cornerRadius = 10

            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.style = .whiteLarge
            activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)

            overlayView.addSubview(activityIndicator)
            view.addSubview(bgView)
            self.activityIndicator.startAnimating()

        }

        public func hideOverlayView() {
            activityIndicator.stopAnimating()
            bgView.removeFromSuperview()
        }
    }
