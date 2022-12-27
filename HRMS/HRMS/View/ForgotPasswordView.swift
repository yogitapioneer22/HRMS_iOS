//
//  ForgotPasswordView.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 15/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol CustomAlertDelegate: AnyObject {
func okButtonPressed(_ alert: ForgotPasswordView, alertTag: Int)
func cancelButtonPressed(_ alert: ForgotPasswordView, alertTag: Int)
}

class ForgotPasswordView: UIViewController {
    var alertTag = 0
    
    @IBOutlet weak var txtEmail: UITextField!
    weak var delegate: CustomAlertDelegate?
    var alertTitle = ""
    var alertMessage = ""
    var okButtonTitle = "Ok"
    var cancelButtonTitle = "Cancel"
    var statusImage = UIImage.init(named: "smiley")
    var isCancelButtonHidden = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func submitAction(_ sender: Any) {
       // self.dismiss(animated: true, completion: nil)
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.callResetPassApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
//        self.dismiss(animated: true, completion: nil)
    }
    
    init() {
    super.init(nibName: "ForgotPasswordView", bundle: Bundle(for: ForgotPasswordView.self))
    self.modalPresentationStyle = .overCurrentContext
    self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    func show() {
    if #available(iOS 13, *) {
    UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
    } else {
    UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
    }
    }
    func callResetPassApi(){
        let loginUrl = AppConstants().baseUrl + "Userlogin/forgotpassword"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)

        let parameters = [
            "email": self.txtEmail.text!
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
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPVC") as! VerifyOTPVC
//                self.present(nextViewController, animated:true, completion:nil)
                            self.dismiss(animated: true, completion: nil)

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
