//
//  EducationDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class EducationDetailsVC: UIViewController {

    @IBOutlet weak var txtPassYear: UITextField!
    @IBOutlet weak var txtBoard: UITextField!
    
    @IBOutlet weak var txtSpz4: UITextField!
    @IBOutlet weak var txtSpz3: UITextField!
    @IBOutlet weak var txtPassYear3: UITextField!
    @IBOutlet weak var txtSpez1: UITextField!
    @IBOutlet weak var txtBoard1: UITextField!
    @IBOutlet weak var txtPercent: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtSpz: UITextField!
    
    @IBOutlet weak var txtPerc4: UITextField!
    @IBOutlet weak var txtPassYear4: UITextField!
    @IBOutlet weak var txtUnivesity2: UITextField!
    @IBOutlet weak var txtPerc3: UITextField!
    @IBOutlet weak var txtUnivesity: UITextField!
    @IBOutlet weak var txtPec2: UITextField!
    @IBOutlet weak var txtSpz2: UITextField!
    @IBOutlet weak var txtPassYear2: UITextField!
    @IBOutlet weak var txtBoard2: UITextField!
    @IBOutlet weak var txtPerc1: UITextField!
    @IBOutlet weak var txtPassYear1: UITextField!
    
    @IBOutlet weak var btnClassXII: UIButton!
    
    @IBOutlet weak var btnPostGra: UIButton!
    @IBOutlet weak var btnDiploma: UIButton!
    @IBOutlet weak var btnGraduation: UIButton!
    @IBOutlet weak var btnClassX: UIButton!
    
    @IBOutlet weak var classXHeight: NSLayoutConstraint!
    
    @IBOutlet weak var classXIIHeight: NSLayoutConstraint!
    
    @IBOutlet weak var diplomaHeght: NSLayoutConstraint!
    @IBOutlet weak var postGraHeight: NSLayoutConstraint!
    @IBOutlet weak var graduationHeght: NSLayoutConstraint!
    
    @IBOutlet weak var diplomaView: UIView!
    @IBOutlet weak var postGraduationView: UIView!
    @IBOutlet weak var graduationView: UIView!
    @IBOutlet weak var XiiView: UIView!
    @IBOutlet weak var XView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.XiiView.isHidden = true
        self.classXIIHeight.constant = 0
        btnClassXII.isSelected = true
        
        self.graduationView.isHidden = true
        self.graduationHeght.constant = 0
        btnGraduation.isSelected = true
        
        self.postGraduationView.isHidden = true
        self.postGraHeight.constant = 0
        btnPostGra.isSelected = true
        
        self.diplomaView.isHidden = true
        self.diplomaHeght.constant = 0
        btnDiploma.isSelected = true

        updateUI()
        joineedetailApi()
        
    }
    @IBAction func btnPostGraAction(_ sender: Any) {
        if btnPostGra.isSelected {
            self.postGraHeight.constant = 214
            self.postGraduationView.isHidden = false
            btnPostGra.isSelected = false
            btnPostGra.setTitle("-", for: .normal)
               }else {
                   btnPostGra.isSelected = true
                   btnPostGra.setTitle("+", for: .normal)
                   self.postGraduationView.isHidden = true
                   self.postGraHeight.constant = 0
                }
    }
    @IBAction func btnDiplomaAction(_ sender: Any) {
        if btnDiploma.isSelected {
            self.diplomaHeght.constant = 214
            self.diplomaView.isHidden = false
            btnDiploma.isSelected = false
            btnDiploma.setTitle("-", for: .normal)
               }else {
                   btnDiploma.isSelected = true
                   btnDiploma.setTitle("+", for: .normal)
                   self.diplomaView.isHidden = true
                   self.diplomaHeght.constant = 0
                }
    }
    @IBAction func btnGraduationAction(_ sender: Any) {
        if btnGraduation.isSelected {
            self.graduationHeght.constant = 214
            self.graduationView.isHidden = false
            btnGraduation.isSelected = false
            btnGraduation.setTitle("-", for: .normal)
               }else {
                   btnGraduation.isSelected = true
                   btnGraduation.setTitle("+", for: .normal)
                   self.graduationView.isHidden = true
                   self.graduationHeght.constant = 0
                }
    }
    
    @IBAction func btnClassXAction(_ sender: Any) {
        if btnClassX.isSelected {
            self.classXHeight.constant = 214
            self.XView.isHidden = false
            btnClassX.isSelected = false
            btnClassX.setTitle("-", for: .normal)
               }else {
                   btnClassX.isSelected = true
                   btnClassX.setTitle("+", for: .normal)
                   self.XView.isHidden = true
                   self.classXHeight.constant = 0
                }
    }
    @IBAction func btnClassXIIAction(_ sender: Any) {
        if btnClassXII.isSelected {
            self.classXIIHeight.constant = 214
            self.XiiView.isHidden = false
            btnClassXII.isSelected = false
            btnClassXII.setTitle("-", for: .normal)
               }else {
                   btnClassXII.isSelected = true
                   btnClassXII.setTitle("+", for: .normal)
                   self.XiiView.isHidden = true
                   self.classXIIHeight.constant = 0
                }
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                self.callEduDetailsApi()
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
        txtPassYear.setLeftPaddingPoints(10)
        txtPassYear.layer.cornerRadius = 5.0
        txtPassYear.layer.masksToBounds = true
        txtPassYear.layer.borderWidth = 1.0
        txtPassYear.layer.borderColor = UIColor.lightGray.cgColor
        
        txtBoard.setLeftPaddingPoints(10)
        txtBoard.layer.cornerRadius = 5.0
        txtBoard.layer.masksToBounds = true
        txtBoard.layer.borderWidth = 1.0
        txtBoard.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpz4.setLeftPaddingPoints(10)
        txtSpz4.layer.cornerRadius = 5.0
        txtSpz4.layer.masksToBounds = true
        txtSpz4.layer.borderWidth = 1.0
        txtSpz4.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpz3.setLeftPaddingPoints(10)
        txtSpz3.layer.cornerRadius = 5.0
        txtSpz3.layer.masksToBounds = true
        txtSpz3.layer.borderWidth = 1.0
        txtSpz3.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPassYear3.setLeftPaddingPoints(10)
        txtPassYear3.layer.cornerRadius = 5.0
        txtPassYear3.layer.masksToBounds = true
        txtPassYear3.layer.borderWidth = 1.0
        txtPassYear3.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpez1.setLeftPaddingPoints(10)
        txtSpez1.layer.cornerRadius = 5.0
        txtSpez1.layer.masksToBounds = true
        txtSpez1.layer.borderWidth = 1.0
        txtSpez1.layer.borderColor = UIColor.lightGray.cgColor
        
        txtBoard1.setLeftPaddingPoints(10)
        txtBoard1.layer.cornerRadius = 5.0
        txtBoard1.layer.masksToBounds = true
        txtBoard1.layer.borderWidth = 1.0
        txtBoard1.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPercent.setLeftPaddingPoints(10)
        txtPercent.layer.cornerRadius = 5.0
        txtPercent.layer.masksToBounds = true
        txtPercent.layer.borderWidth = 1.0
        txtPercent.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpz.setLeftPaddingPoints(10)
        txtSpz.layer.cornerRadius = 5.0
        txtSpz.layer.masksToBounds = true
        txtSpz.layer.borderWidth = 1.0
        txtSpz.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPerc4.setLeftPaddingPoints(10)
        txtPerc4.layer.cornerRadius = 5.0
        txtPerc4.layer.masksToBounds = true
        txtPerc4.layer.borderWidth = 1.0
        txtPerc4.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPassYear4.setLeftPaddingPoints(10)
        txtPassYear4.layer.cornerRadius = 5.0
        txtPassYear4.layer.masksToBounds = true
        txtPassYear4.layer.borderWidth = 1.0
        txtPassYear4.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPassYear4.setLeftPaddingPoints(10)
        txtPassYear4.layer.cornerRadius = 5.0
        txtPassYear4.layer.masksToBounds = true
        txtPassYear4.layer.borderWidth = 1.0
        txtPassYear4.layer.borderColor = UIColor.lightGray.cgColor
        
        txtUnivesity2.setLeftPaddingPoints(10)
        txtUnivesity2.layer.cornerRadius = 5.0
        txtUnivesity2.layer.masksToBounds = true
        txtUnivesity2.layer.borderWidth = 1.0
        txtUnivesity2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPerc3.setLeftPaddingPoints(10)
        txtPerc3.layer.cornerRadius = 5.0
        txtPerc3.layer.masksToBounds = true
        txtPerc3.layer.borderWidth = 1.0
        txtPerc3.layer.borderColor = UIColor.lightGray.cgColor
        
        txtUnivesity.setLeftPaddingPoints(10)
        txtUnivesity.layer.cornerRadius = 5.0
        txtUnivesity.layer.masksToBounds = true
        txtUnivesity.layer.borderWidth = 1.0
        txtUnivesity.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPec2.setLeftPaddingPoints(10)
        txtPec2.layer.cornerRadius = 5.0
        txtPec2.layer.masksToBounds = true
        txtPec2.layer.borderWidth = 1.0
        txtPec2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSpz2.setLeftPaddingPoints(10)
        txtSpz2.layer.cornerRadius = 5.0
        txtSpz2.layer.masksToBounds = true
        txtSpz2.layer.borderWidth = 1.0
        txtSpz2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPassYear2.setLeftPaddingPoints(10)
        txtPassYear2.layer.cornerRadius = 5.0
        txtPassYear2.layer.masksToBounds = true
        txtPassYear2.layer.borderWidth = 1.0
        txtPassYear2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtBoard2.setLeftPaddingPoints(10)
        txtBoard2.layer.cornerRadius = 5.0
        txtBoard2.layer.masksToBounds = true
        txtBoard2.layer.borderWidth = 1.0
        txtBoard2.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPerc1.setLeftPaddingPoints(10)
        txtPerc1.layer.cornerRadius = 5.0
        txtPerc1.layer.masksToBounds = true
        txtPerc1.layer.borderWidth = 1.0
        txtPerc1.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPassYear1.setLeftPaddingPoints(10)
        txtPassYear1.layer.cornerRadius = 5.0
        txtPassYear1.layer.masksToBounds = true
        txtPassYear1.layer.borderWidth = 1.0
        txtPassYear1.layer.borderColor = UIColor.lightGray.cgColor

    }
    func callEduDetailsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addeducationdetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "university_1": txtUnivesity.text!,
            "passing_yr_1": txtPassYear.text!,
            "percentage_1": txtPercent.text!,
            "specialization_1": txtSpz.text!,
            "university_2": txtUnivesity2.text!,
            "passing_yr_2": txtPassYear1.text!,
            "percentage_2": txtPerc1.text!,
            "specialization_2": txtSpz2.text!,
            "university_3": txtUnivesity2.text!,
            "passing_yr_3": txtPassYear3.text!,
            "percentage_3": txtPec2.text!,
            "specialization_3": txtSpz3.text!,
            "university_4": txtUnivesity2.text!,
            "passing_yr_4":txtPassYear3.text!,
            "percentage_4": txtPerc4.text!,
            "university_5": txtUnivesity2.text!,
            "passing_yr_5": txtPassYear4.text!,
            "percentage_5": txtPerc3.text!,
            "specialization_5": txtSpz4.text!
            ] as? [String:AnyObject]
        print(parameters!)
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
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EducationDetailsVC") as! EducationDetailsVC
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

}
