//
//  EmergencyDetailVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class EmergencyDetailVC: UIViewController {
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtRelation: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    var is_prefilled = ""
    let relationDrop = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        relation()
        joineedetailApi()
    }
    
    @IBAction func txtRelationAction(_ sender: Any) {
        if txtRelation.isSelected {
            txtRelation.isSelected = true
            relationDrop.hide()
               }else {
                   txtRelation.isSelected = false
                   relationDrop.show()
                }
    }
    func relation(){
        relationDrop.dataSource = ["Mother", "Father","Brother","Sister","Wife","Husband","Son","Doughter","Uncle","Aunt","Friend"]
        relationDrop.selectionAction = { [unowned self] (index: Int, item: String) in
         // print("Selected item: \(item) at index: \(index)")
            self.txtRelation.text = item
        }
        relationDrop.width = 200
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let phoneNumberString = txtPhone.text!
          let phoneNumberValidation = phoneNumberString.isPhoneNumber
          print(phoneNumberValidation)
        if phoneNumberValidation == false{
            let alert = UIAlertController(title: "", message: "Enter Valid Mobile Number!", preferredStyle: .alert)
            self.present(alert, animated: true) {
               sleep(1)
               alert.dismiss(animated: true)
            }
        }else{
            if Reachability.isConnectedToNetwork() {
                print("Internet connection OK")
                DispatchQueue.main.async {
                    self.callEmgApi()
                }
            } else {
                print("Internet connection FAILED")
                let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
      
    }
    func updateUI(){
        btnSave.layer.cornerRadius = 5.0
        btnSave.layer.masksToBounds = true
        //txtfName.setRightPaddingPoints(10)
        txtPhone.setLeftPaddingPoints(10)
        txtPhone.layer.cornerRadius = 5.0
        txtPhone.layer.masksToBounds = true
        txtPhone.layer.borderWidth = 1.0
        txtPhone.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRelation.setLeftPaddingPoints(10)
        txtRelation.layer.cornerRadius = 5.0
        txtRelation.layer.masksToBounds = true
        txtRelation.layer.borderWidth = 1.0
        txtRelation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtAddress.setLeftPaddingPoints(10)
        txtAddress.layer.cornerRadius = 5.0
        txtAddress.layer.masksToBounds = true
        txtAddress.layer.borderWidth = 1.0
        txtAddress.layer.borderColor = UIColor.lightGray.cgColor
        
        txtName.setLeftPaddingPoints(10)
        txtName.layer.cornerRadius = 5.0
        txtName.layer.masksToBounds = true
        txtName.layer.borderWidth = 1.0
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    func callEmgApi(){
        
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/emergencycontactdetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "name": "1",
            "address": "1",
            "phone": "1",
            "relation": "1"
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
                          //  refreshAlert .dismiss(animated: true, completion: nil)

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BAnkDetailsVC") as! BAnkDetailsVC
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
    func joineedetailApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/joineedetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken
                ] as? [String:AnyObject]
         print(parameters)
        AF.request(loginUrl, method: .post, parameters: parameters! as Parameters, encoding: URLEncoding.default, headers: headers).responseJSON {
                    response in
            LoadingOverlay.shared.hideOverlayView()
                    switch (response.result) {
                    case .success(let value):
                   let json = JSON(value)
                        print(json)
                        
                        let message = json["msg"].string
                        let status = json["status"].string
                        //let data = json["data"]["personal_detail"].arrayValue.map {$0["fname"].stringValue}
                       // let title = json["data"].arrayValue.map {$0["title"].stringValue}
            if status == "200"{
                        let data = json["data"]["emergency_detail"].dictionary
                        let phone = data.map {$0["phone"]?.stringValue}
                        let relation = data.map {$0["relation"]?.stringValue}
                        let name = data.map {$0["name"]?.stringValue}
                        let address = data.map {$0["address"]?.stringValue}
                        let is_prefilled = data.map {$0["is_prefilled"]?.stringValue}
                      self.is_prefilled = is_prefilled! ?? ""
                        self.txtPhone.text! = (phone ?? "") ?? ""
                        self.txtName.text! = (name ?? "") ?? ""
                        self.txtRelation.text! = (relation ?? "") ?? ""
                        self.txtAddress.text! = (address ?? "") ?? ""
               

                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
                    }
                }
}
}
