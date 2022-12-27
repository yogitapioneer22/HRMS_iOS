//
//  GeneratePasscodeVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 17/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class GeneratePasscodeVC: UIViewController {
    @IBOutlet weak var txtRePass2: UITextField!
    
    @IBOutlet weak var txtRePass4: UITextField!
    @IBOutlet weak var txtRePass3: UITextField!
    @IBOutlet weak var txtRePass1: UITextField!
    @IBOutlet weak var txtPass4: UITextField!
    @IBOutlet weak var txtPass3: UITextField!
    @IBOutlet weak var txtPass2: UITextField!
    @IBOutlet weak var txtPass1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        let passcode = String(txtPass1.text! + txtPass2.text! + txtPass3.text! + txtPass4.text!)
        let confirmPasscode = String(txtRePass1.text! + txtRePass2.text! + txtRePass3.text! + txtRePass4.text!)
        if passcode == confirmPasscode{
            
            if Reachability.isConnectedToNetwork() {
                print("Internet connection OK")
                DispatchQueue.main.async {
                    self.passcodeApi()
                    
                }
            } else {
                print("Internet connection FAILED")
                let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let refreshAlert = UIAlertController(title: "Opps", message: "Passcode miss matched!", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)

            }))

            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    @IBAction func setupLatter(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func passcodeApi(){
        let loginUrl = AppConstants().baseUrl + "Passcode/generatepasscode"
        
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
      let appToken =  UserDefaults.standard.string(forKey: "token")
        let parameters = [
            "token": appToken,
            "device_token":"45",
            "passcode":"1234"
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
//                        let token = data["token"].string
//                        let username = data["username"].string
//                        let emp_id = data["emp_id"].string
//                        let designation = data["designation"].string
//                        let doj = data["doj"].string
//                        let department = data["department"].string
//                        let level = data["level"].string
//                        let reportingTo = data["reportingTo"].string
//                        let highest_qual = data["highest_qual"].string
//                        let official_email = data["official_email"].string
//
//
                      print(status)
                    if status == "200"{
//                                self.lblName.text = username
//                                self.lblDetail.text = emp_id
//                                self.txtDOJ.text = doj
//                                self.txtDesignation.text = designation
//                                self.txtDepartment.text = department
//                                self.txtLevel.text = level
//                                self.txtReportingM.text = reportingTo
//                                self.txtQualification.text = highest_qual
//                                self.txtEmaIl.text = official_email
//                                
//                                
//
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
