//
//  FamilyDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
class FamilyDetailsVC: UIViewController {
    @IBOutlet weak var txtFatherName: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var FdobPicker: UIDatePicker!
    @IBOutlet weak var txtOtherRelation: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtRelation: UITextField!
    @IBOutlet weak var txtSpouseDOB: UITextField!
    @IBOutlet weak var txtSpouseContact: UITextField!
    @IBOutlet weak var txtSpouseOccupation: UITextField!
    @IBOutlet weak var txtNoOfKids: UITextField!
    @IBOutlet weak var txtSpouse: UITextField!
    @IBOutlet weak var txtMotherDOB: UITextField!
    @IBOutlet weak var txtMotherContact: UITextField!
    @IBOutlet weak var txtMotherOccupation: UITextField!
    @IBOutlet weak var txtMotherName: UITextField!
    @IBOutlet weak var txtFatherDOB: UITextField!
    @IBOutlet weak var txtFatherContact: UITextField!
    @IBOutlet weak var SdobPicker: UIDatePicker!
    @IBOutlet weak var dobPicker: UIDatePicker!
    @IBOutlet weak var txtFatherOccupation: UITextField!
    @IBOutlet weak var MdobPicker: UIDatePicker!
    
    var fDOB = ""
    var mDOB   = ""
    var sDOB  = ""
    var DOB = ""
    var is_prefilled = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        joineedetailApi()
        
    }
    @IBAction func btnReligionAction(_ sender: Any) {
    }
    @IBAction func SdobAction(_ sender: Any) {
        self.sDOB = SdobPicker.date.toString(dateFormat: "MMM-yyyy")
        print( self.sDOB )
    }
    @IBAction func MdobAction(_ sender: Any) {
        self.mDOB = MdobPicker.date.toString(dateFormat: "MMM-yyyy")
        print( self.mDOB )
    }
    
    @IBAction func dobAction(_ sender: Any) {
        self.DOB = dobPicker.date.toString(dateFormat: "MMM-yyyy")
        print( self.DOB )
    }
    @IBAction func FdobAction(_ sender: Any) {
        self.fDOB = FdobPicker.date.toString(dateFormat: "MMM-yyyy")
        print( self.fDOB )
    }
    func updateUI(){
        btnSave.layer.cornerRadius = 5.0
        btnSave.layer.masksToBounds = true
        txtOtherRelation.setLeftPaddingPoints(10)
        txtOtherRelation.layer.cornerRadius = 5.0
        txtOtherRelation.layer.masksToBounds = true
        txtOtherRelation.layer.borderWidth = 1.0
        txtOtherRelation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDOB.setLeftPaddingPoints(10)
        txtDOB.layer.cornerRadius = 5.0
        txtDOB.layer.masksToBounds = true
        txtDOB.layer.borderWidth = 1.0
        txtDOB.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFatherName.setLeftPaddingPoints(10)
        txtFatherName.layer.cornerRadius = 5.0
        txtFatherName.layer.masksToBounds = true
        txtFatherName.layer.borderWidth = 1.0
        txtFatherName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtContact.setLeftPaddingPoints(10)
        txtContact.layer.cornerRadius = 5.0
        txtContact.layer.masksToBounds = true
        txtContact.layer.borderWidth = 1.0
        txtContact.layer.borderColor = UIColor.lightGray.cgColor
        
        txtOccupation.setLeftPaddingPoints(10)
        txtOccupation.layer.cornerRadius = 5.0
        txtOccupation.layer.masksToBounds = true
        txtOccupation.layer.borderWidth = 1.0
        txtOccupation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRelation.setLeftPaddingPoints(10)
        txtRelation.layer.cornerRadius = 5.0
        txtRelation.layer.masksToBounds = true
        txtRelation.layer.borderWidth = 1.0
        txtRelation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpouseDOB.setLeftPaddingPoints(10)
        txtSpouseDOB.layer.cornerRadius = 5.0
        txtSpouseDOB.layer.masksToBounds = true
        txtSpouseDOB.layer.borderWidth = 1.0
        txtSpouseDOB.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDOB.setLeftPaddingPoints(10)
        txtDOB.layer.cornerRadius = 5.0
        txtDOB.layer.masksToBounds = true
        txtDOB.layer.borderWidth = 1.0
        txtDOB.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpouseContact.setLeftPaddingPoints(10)
        txtSpouseContact.layer.cornerRadius = 5.0
        txtSpouseContact.layer.masksToBounds = true
        txtSpouseContact.layer.borderWidth = 1.0
        txtSpouseContact.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpouseOccupation.setLeftPaddingPoints(10)
        txtSpouseOccupation.layer.cornerRadius = 5.0
        txtSpouseOccupation.layer.masksToBounds = true
        txtSpouseOccupation.layer.borderWidth = 1.0
        txtSpouseOccupation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtNoOfKids.setLeftPaddingPoints(10)
        txtNoOfKids.layer.cornerRadius = 5.0
        txtNoOfKids.layer.masksToBounds = true
        txtNoOfKids.layer.borderWidth = 1.0
        txtNoOfKids.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpouse.setLeftPaddingPoints(10)
        txtSpouse.layer.cornerRadius = 5.0
        txtSpouse.layer.masksToBounds = true
        txtSpouse.layer.borderWidth = 1.0
        txtSpouse.layer.borderColor = UIColor.lightGray.cgColor
        
        txtMotherDOB.setLeftPaddingPoints(10)
        txtMotherDOB.layer.cornerRadius = 5.0
        txtMotherDOB.layer.masksToBounds = true
        txtMotherDOB.layer.borderWidth = 1.0
        txtMotherDOB.layer.borderColor = UIColor.lightGray.cgColor
        
        txtMotherContact.setLeftPaddingPoints(10)
        txtMotherContact.layer.cornerRadius = 5.0
        txtMotherContact.layer.masksToBounds = true
        txtMotherContact.layer.borderWidth = 1.0
        txtMotherContact.layer.borderColor = UIColor.lightGray.cgColor
        
        txtMotherOccupation.setLeftPaddingPoints(10)
        txtMotherOccupation.layer.cornerRadius = 5.0
        txtMotherOccupation.layer.masksToBounds = true
        txtMotherOccupation.layer.borderWidth = 1.0
        txtMotherOccupation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtMotherName.setLeftPaddingPoints(10)
        txtMotherName.layer.cornerRadius = 5.0
        txtMotherName.layer.masksToBounds = true
        txtMotherName.layer.borderWidth = 1.0
        txtMotherName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFatherDOB.setLeftPaddingPoints(10)
        txtFatherDOB.layer.cornerRadius = 5.0
        txtFatherDOB.layer.masksToBounds = true
        txtFatherDOB.layer.borderWidth = 1.0
        txtFatherDOB.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFatherContact.setLeftPaddingPoints(10)
        txtFatherContact.layer.cornerRadius = 5.0
        txtFatherContact.layer.masksToBounds = true
        txtFatherContact.layer.borderWidth = 1.0
        txtFatherContact.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFatherOccupation.setLeftPaddingPoints(10)
        txtFatherOccupation.layer.cornerRadius = 5.0
        txtFatherOccupation.layer.masksToBounds = true
        txtFatherOccupation.layer.borderWidth = 1.0
        txtFatherOccupation.layer.borderColor = UIColor.lightGray.cgColor
        
      
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
                self.callFamilyDetailsApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func callFamilyDetailsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addfamilydetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "fathername": fDOB,
            "fatheroccupation": txtFatherOccupation.text!,
            "fathercnt": txtContact.text!,
            "mothername": txtMotherName.text!,
            "motheroccupation": txtMotherOccupation.text!,
            "mothercnt": txtMotherContact.text!,
            "wifename": txtSpouse.text!,
            "kids": txtNoOfKids.text!,
            "wifecnt": "",
            "other_name": txtOtherRelation.text!,
            "other_relation": txtOtherRelation.text!,
            "other_contact": txtContact.text!,
          
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
                           // refreshAlert .dismiss(animated: true, completion: nil)

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsVC
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
          
                   self.is_prefilled = is_prefilled! ?? ""
                        self.txtFatherName.text! = (fathername ?? "") ?? ""
                        self.txtFatherOccupation.text! = (fatheroccupation ?? "") ?? ""
                        self.txtFatherContact.text! = (fathercnt ?? "") ?? ""
                        
                        self.txtFatherDOB.text! = (father_dob ?? "") ?? ""
                        self.txtMotherName.text! = (mothername ?? "") ?? ""
                        self.txtMotherOccupation.text! = (motheroccupation ?? "") ?? ""
                        
                        self.txtMotherDOB.text! = (mother_dob ?? "") ?? ""
                        self.txtMotherContact.text! = (mothercnt ?? "") ?? ""
                        self.txtSpouse.text! = (wifename ?? "") ?? ""
                        
                        self.txtSpouseDOB.text! = (spouse_dob ?? "") ?? ""
                        self.txtSpouseOccupation.text! = (spouse_occupation ?? "") ?? ""
                        self.txtOtherRelation.text! = (other_relation ?? "") ?? ""
                        
                       // self.txtLanguage.text! = (language ?? "") ?? ""
                        self.txtRelation.text! = (other_relation ?? "") ?? ""
                        self.txtOccupation.text! = (other_occupation ?? "") ?? ""
                        self.txtContact.text! = (other_contact ?? "") ?? ""
                       // self.txtDOB.text! = (DOB ?? "") ?? ""
                       
     
                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
                    }
                }
}

}
