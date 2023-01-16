//
//  AddressDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class AddressDetailsVC: UIViewController {
    @IBOutlet weak var txtLocalAdd: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var txtPIN2: UITextField!
    @IBOutlet weak var txtCity2: UITextField!
    @IBOutlet weak var txtState2: UITextField!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtPermanentAdd: UITextField!
    let stateDrop1 = DropDown()
    let stateDrop2 = DropDown()
    var stateList = [""]
    var sameAddress =  ""
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        state1()
        state2()
        callStateListApi()
        
    }
    @IBAction func checkBoxAction(_ sender: Any) {
        if btnCheckBox.isSelected {
            btnCheckBox.isSelected = false
            btnCheckBox.setImage(#imageLiteral(resourceName: "square radio button black copy"), for: .normal)
            self.txtLocalAdd.text! = ""
            self.txtState2.text! = ""
            self.txtCity2.text! = ""
            self.txtPIN2.text! = ""
            self.sameAddress =  "1"
            
        }else {
            btnCheckBox.isSelected = true
            btnCheckBox.setImage(#imageLiteral(resourceName: "square radio button green copy"), for: .normal)
            self.txtLocalAdd.text! = txtPermanentAdd.text!
            self.txtState2.text! = txtState.text!
            self.txtCity2.text! = txtCity.text!
            self.txtPIN2.text! = txtPinCode.text!
            self.sameAddress =  "2"
        }
    }
    
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.callAddsApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUI(){
        btnSave.layer.cornerRadius = 5.0
        btnSave.layer.masksToBounds = true
        //txtfName.setRightPaddingPoints(10)
        txtPIN2.setLeftPaddingPoints(10)
        txtPIN2.layer.cornerRadius = 5.0
        txtPIN2.layer.masksToBounds = true
        txtPIN2.layer.borderWidth = 1.0
        txtPIN2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtCity2.setLeftPaddingPoints(10)
        txtCity2.layer.cornerRadius = 5.0
        txtCity2.layer.masksToBounds = true
        txtCity2.layer.borderWidth = 1.0
        txtCity2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLocalAdd.setLeftPaddingPoints(10)
        txtLocalAdd.layer.cornerRadius = 5.0
        txtLocalAdd.layer.masksToBounds = true
        txtLocalAdd.layer.borderWidth = 1.0
        txtLocalAdd.layer.borderColor = UIColor.lightGray.cgColor
        
        txtState2.setLeftPaddingPoints(10)
        txtState2.layer.cornerRadius = 5.0
        txtState2.layer.masksToBounds = true
        txtState2.layer.borderWidth = 1.0
        txtState2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPinCode.setLeftPaddingPoints(10)
        txtPinCode.layer.cornerRadius = 5.0
        txtPinCode.layer.masksToBounds = true
        txtPinCode.layer.borderWidth = 1.0
        txtPinCode.layer.borderColor = UIColor.lightGray.cgColor
        
        txtCity.setLeftPaddingPoints(10)
        txtCity.layer.cornerRadius = 5.0
        txtCity.layer.masksToBounds = true
        txtCity.layer.borderWidth = 1.0
        txtCity.layer.borderColor = UIColor.lightGray.cgColor
        
        txtState.setLeftPaddingPoints(10)
        txtState.layer.cornerRadius = 5.0
        txtState.layer.masksToBounds = true
        txtState.layer.borderWidth = 1.0
        txtState.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPermanentAdd.setLeftPaddingPoints(10)
        txtPermanentAdd.layer.cornerRadius = 5.0
        txtPermanentAdd.layer.masksToBounds = true
        txtPermanentAdd.layer.borderWidth = 1.0
        txtPermanentAdd.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    @IBAction func state1(_ sender: Any) {
        if txtState.isSelected {
            txtState.isSelected = true
            stateDrop1.hide()
               }else {
                   txtState.isSelected = false
                   stateDrop1.show()
                }
    }
    @IBAction func state2(_ sender: Any) {
        if txtState2.isSelected {
            txtState2.isSelected = true
            stateDrop2.hide()
               }else {
                   txtState2.isSelected = false
                   stateDrop2.show()
                }
    }
    func state1(){
        stateDrop1.dataSource = stateList
        stateDrop1.selectionAction = { [unowned self] (index: Int, item: String) in
         // print("Selected item: \(item) at index: \(index)")
            self.txtState.text = item
        }
        stateDrop1.width = 200
    }
    func state2(){
        stateDrop2.dataSource = stateList
        stateDrop2.selectionAction = { [unowned self] (index: Int, item: String) in
         // print("Selected item: \(item) at index: \(index)")
            self.txtState2.text = item
        }
        stateDrop2.width = 200
    }
    func callAddsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addaddressdetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "paddress": txtPermanentAdd.text!,
            "p_state": txtState.text!,
            "p_city": txtCity.text!,
            "p_pincode": txtPinCode.text!,
            "cadress": txtLocalAdd.text!,
            "l_state": txtState2.text!,
            "l_city": txtCity2.text!,
            "l_pincode": txtPIN2.text!,
            "is_sameaddress": self.sameAddress
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
                    
                        
                      print(status)
                            
                            if status == "200"{
                                
                        let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                                
                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                          //  refreshAlert .dismiss(animated: true, completion: nil)

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmergencyDetailVC") as! EmergencyDetailVC
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
                        let data = json["data"]["family_detail"].dictionary
                        let mothername = data.map {$0["mothername"]?.stringValue}
                        let motheroccupation = data.map {$0["motheroccupation"]?.stringValue}
                        let other_relation = data.map {$0["other_relation"]?.stringValue}
                        let spouse_dob = data.map {$0["spouse_dob"]?.stringValue}
                        let fathercnt = data.map {$0["fathercnt"]?.stringValue}
                        let fatheroccupation = data.map {$0["fatheroccupation"]?.stringValue}
                        
                        let other_dob = data.map {$0["other_dob"]?.stringValue}
                        let mothercnt = data.map {$0["mothercnt"]?.stringValue}
                        let father_dob = data.map {$0["father_dob"]?.stringValue}
                        let wifename = data.map {$0["wifename"]?.stringValue}
                        let other_occupation = data.map {$0["other_occupation"]?.stringValue}
                        let other_contact = data.map {$0["other_contact"]?.stringValue}
                        
                        let fathername = data.map {$0["fathername"]?.stringValue}
                        let wifecnt = data.map {$0["wifecnt"]?.stringValue}
                        let mother_dob = data.map {$0["mother_dob"]?.stringValue}
                        let is_prefilled = data.map {$0["is_prefilled"]?.stringValue}
                        let kids = data.map {$0["kids"]?.stringValue}
                        let other_name = data.map {$0["other_name"]?.stringValue}
                        let spouse_occupation = data.map {$0["spouse_occupation"]?.stringValue}
          
                  // self.is_prefilled = is_prefilled! ?? ""
//                        self.txtFatherName.text! = (fathername ?? "") ?? ""
//                        self.txtFatherOccupation.text! = (fatheroccupation ?? "") ?? ""
//                        self.txtFatherContact.text! = (fathercnt ?? "") ?? ""
//                        
//                        self.txtFatherDOB.text! = (father_dob ?? "") ?? ""
//                        self.txtMotherName.text! = (mothername ?? "") ?? ""
//                        self.txtMotherOccupation.text! = (motheroccupation ?? "") ?? ""
//                        
//                        self.txtMotherDOB.text! = (mother_dob ?? "") ?? ""
//                        self.txtMotherContact.text! = (mothercnt ?? "") ?? ""
//                        self.txtSpouse.text! = (wifename ?? "") ?? ""
//                        
//                        self.txtSpouseDOB.text! = (spouse_dob ?? "") ?? ""
//                        self.txtSpouseOccupation.text! = (spouse_occupation ?? "") ?? ""
//                        self.txtOtherRelation.text! = (other_relation ?? "") ?? ""
//                        
//                       // self.txtLanguage.text! = (language ?? "") ?? ""
//                        self.txtRelation.text! = (other_relation ?? "") ?? ""
//                        self.txtOccupation.text! = (other_occupation ?? "") ?? ""
//                        self.txtContact.text! = (other_contact ?? "") ?? ""
                       // self.txtDOB.text! = (DOB ?? "") ?? ""
                       
     
                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
                    }
                }
}
    func callStateListApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/statelist"
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
                let data = json["data"]
                let title = json["data"].arrayValue.map {$0["title"].stringValue}
                self.stateList   = title
             //   self.tableView.reloadData()
                break
            case .failure:
                print(Error.self)
                
                
            }
        }
        
    }
}
