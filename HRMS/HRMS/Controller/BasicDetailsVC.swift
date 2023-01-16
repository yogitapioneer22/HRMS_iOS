//
//  BasicDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown
class BasicDetailsVC: UIViewController {
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnMaritalStatus: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var jMonthPicker: UIDatePicker!
    @IBOutlet weak var dojDatePicker: UIDatePicker!
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtCaste: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var btnPersonalDetail: UIButton!
    @IBOutlet weak var txtMarritalStatus: UITextField!
    @IBOutlet weak var txtBloodGroup: UITextField!
    @IBOutlet weak var txtJoiningMonth: UITextField!
    @IBOutlet weak var txtDOJ: UITextField!
    @IBOutlet weak var txtOfficialEmail: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtlName: UITextField!
    @IBOutlet weak var txtmName: UITextField!
    @IBOutlet weak var txtfName: UITextField!
    @IBOutlet weak var personalViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAdditional: UIButton!
    @IBOutlet weak var additionalHeight: NSLayoutConstraint!
    @IBOutlet weak var txtAlternetMobile: UITextField!
    @IBOutlet weak var txtAadhar: UITextField!
    @IBOutlet weak var personalView: UIView!
    @IBOutlet weak var additionalView: UIView!
    @IBOutlet weak var txtAlergicTo: UITextField!
    @IBOutlet weak var txtHobbies: UITextField!
    @IBOutlet weak var txtPan: UITextField!
    @IBOutlet weak var txtNationality: UITextField!
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet weak var txtReligion: UITextField!
    @IBOutlet weak var txtRemarks: UITextField!
    @IBOutlet weak var txtSkillSet: UITextField!
    @IBOutlet weak var txtLevel: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtFinancYear: UITextField!
    
    @IBOutlet weak var btnBloodGroup: UIButton!
    @IBOutlet weak var btnReligion: UIButton!
    
    var dob = ""
    var doj = ""
    var joingMonth = ""
    let genderDropDown = DropDown()
    let marrital = DropDown()
    let lamguageDropDown = DropDown()
    let   bGDrop = DropDown()
    let   relisionDrop = DropDown()
    var languageList = [""]
    var is_prefilled = ""
    var lagua = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        self.additionalView.isHidden = true
        self.additionalHeight.constant = 0
        callLanguageListApi()
        joineedetailApi()
         gender()
        merital()
        bgroup()
        relision()
        if is_prefilled == "1"{
            dojDatePicker.isHidden = true
            dobDatePicker.isHidden = true
            
        }
        
     //   dobDatePicker.alpha = 0.0
        txtDOB.addTarget(self, action: #selector(dobTextField(_:)), for: .allEditingEvents)


    
    }

    @IBAction func bGAction(_ sender: Any) {
        if txtBloodGroup.isSelected {
            txtBloodGroup.isSelected = true
            bGDrop.hide()
               }else {
                   txtBloodGroup.isSelected = false
                   bGDrop.show()
                }
    }
    
    @IBAction func txtRelisionAction(_ sender: Any) {
        if txtReligion.isSelected {
            txtReligion.isSelected = true
            relisionDrop.hide()
               }else {
                   txtBloodGroup.isSelected = false
                   relisionDrop.show()
                }
    }
    
    @IBAction func dobTextField(_ sender: Any) {
        dobDatePicker.isHidden = true
        dobDatePicker.alpha = 1.0

    }
    func updateUI(){
        btnSave.layer.cornerRadius = 5.0
        btnSave.layer.masksToBounds = true
        //txtfName.setRightPaddingPoints(10)
        txtfName.setLeftPaddingPoints(10)
        txtfName.layer.cornerRadius = 5.0
        txtfName.layer.masksToBounds = true
        txtfName.layer.borderWidth = 1.0
        txtfName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtmName.setLeftPaddingPoints(10)
        txtmName.layer.cornerRadius = 5.0
        txtmName.layer.masksToBounds = true
        txtmName.layer.borderWidth = 1.0
        txtmName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtlName.setLeftPaddingPoints(10)
        txtlName.layer.cornerRadius = 5.0
        txtlName.layer.masksToBounds = true
        txtlName.layer.borderWidth = 1.0
        txtlName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtEmail.setLeftPaddingPoints(10)
        txtEmail.layer.cornerRadius = 5.0
        txtEmail.layer.masksToBounds = true
        txtEmail.layer.borderWidth = 1.0
        txtEmail.layer.borderColor = UIColor.lightGray.cgColor
        
        txtOfficialEmail.setLeftPaddingPoints(10)
        txtOfficialEmail.layer.cornerRadius = 5.0
        txtOfficialEmail.layer.masksToBounds = true
        txtOfficialEmail.layer.borderWidth = 1.0
        txtOfficialEmail.layer.borderColor = UIColor.lightGray.cgColor
        
        txtMarritalStatus.setLeftPaddingPoints(10)
        txtMarritalStatus.layer.cornerRadius = 5.0
        txtMarritalStatus.layer.masksToBounds = true
        txtMarritalStatus.layer.borderWidth = 1.0
        txtMarritalStatus.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDOB.setLeftPaddingPoints(10)
        txtDOB.layer.cornerRadius = 5.0
        txtDOB.layer.masksToBounds = true
        txtDOB.layer.borderWidth = 1.0
        txtDOB.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDOJ.setLeftPaddingPoints(10)
        txtDOJ.layer.cornerRadius = 5.0
        txtDOJ.layer.masksToBounds = true
        txtDOJ.layer.borderWidth = 1.0
        txtDOJ.layer.borderColor = UIColor.lightGray.cgColor
        
        txtJoiningMonth.setLeftPaddingPoints(10)
        txtJoiningMonth.layer.cornerRadius = 5.0
        txtJoiningMonth.layer.masksToBounds = true
        txtJoiningMonth.layer.borderWidth = 1.0
        txtJoiningMonth.layer.borderColor = UIColor.lightGray.cgColor
        
        txtGender.setLeftPaddingPoints(10)
        txtGender.layer.cornerRadius = 5.0
        txtGender.layer.masksToBounds = true
        txtGender.layer.borderWidth = 1.0
        txtGender.layer.borderColor = UIColor.lightGray.cgColor
        
        txtWeight.setLeftPaddingPoints(10)
        txtWeight.layer.cornerRadius = 5.0
        txtWeight.layer.masksToBounds = true
        txtWeight.layer.borderWidth = 1.0
        txtWeight.layer.borderColor = UIColor.lightGray.cgColor
        
        txtHeight.setLeftPaddingPoints(10)
        txtHeight.layer.cornerRadius = 5.0
        txtHeight.layer.masksToBounds = true
        txtHeight.layer.borderWidth = 1.0
        txtHeight.layer.borderColor = UIColor.lightGray.cgColor
        
        txtCaste.setLeftPaddingPoints(10)
        txtCaste.layer.cornerRadius = 5.0
        txtCaste.layer.masksToBounds = true
        txtCaste.layer.borderWidth = 1.0
        txtCaste.layer.borderColor = UIColor.lightGray.cgColor
        
        txtMobile.setLeftPaddingPoints(10)
        txtMobile.layer.cornerRadius = 5.0
        txtMobile.layer.masksToBounds = true
        txtMobile.layer.borderWidth = 1.0
        txtMobile.layer.borderColor = UIColor.lightGray.cgColor
        
        txtAlternetMobile.setLeftPaddingPoints(10)
        txtAlternetMobile.layer.cornerRadius = 5.0
        txtAlternetMobile.layer.masksToBounds = true
        txtAlternetMobile.layer.borderWidth = 1.0
        txtAlternetMobile.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLanguage.setLeftPaddingPoints(10)
        txtLanguage.layer.cornerRadius = 5.0
        txtLanguage.layer.masksToBounds = true
        txtLanguage.layer.borderWidth = 1.0
        txtLanguage.layer.borderColor = UIColor.lightGray.cgColor
        
        txtReligion.setLeftPaddingPoints(10)
        txtReligion.layer.cornerRadius = 5.0
        txtReligion.layer.masksToBounds = true
        txtReligion.layer.borderWidth = 1.0
        txtReligion.layer.borderColor = UIColor.lightGray.cgColor
        
        txtNationality.setLeftPaddingPoints(10)
        txtNationality.layer.cornerRadius = 5.0
        txtNationality.layer.masksToBounds = true
        txtNationality.layer.borderWidth = 1.0
        txtNationality.layer.borderColor = UIColor.lightGray.cgColor
        
        txtPan.setLeftPaddingPoints(10)
        txtPan.layer.cornerRadius = 5.0
        txtPan.layer.masksToBounds = true
        txtPan.layer.borderWidth = 1.0
        txtPan.layer.borderColor = UIColor.lightGray.cgColor
        
        txtAadhar.setLeftPaddingPoints(10)
        txtAadhar.layer.cornerRadius = 5.0
        txtAadhar.layer.masksToBounds = true
        txtAadhar.layer.borderWidth = 1.0
        txtAadhar.layer.borderColor = UIColor.lightGray.cgColor
        
        txtBloodGroup.setLeftPaddingPoints(10)
        txtBloodGroup.layer.cornerRadius = 5.0
        txtBloodGroup.layer.masksToBounds = true
        txtBloodGroup.layer.borderWidth = 1.0
        txtBloodGroup.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFinancYear.setLeftPaddingPoints(10)
        txtFinancYear.layer.cornerRadius = 5.0
        txtFinancYear.layer.masksToBounds = true
        txtFinancYear.layer.borderWidth = 1.0
        txtFinancYear.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDesignation.setLeftPaddingPoints(10)
        txtDesignation.layer.cornerRadius = 5.0
        txtDesignation.layer.masksToBounds = true
        txtDesignation.layer.borderWidth = 1.0
        txtDesignation.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLevel.setLeftPaddingPoints(10)
        txtLevel.layer.cornerRadius = 5.0
        txtLevel.layer.masksToBounds = true
        txtLevel.layer.borderWidth = 1.0
        txtLevel.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSkillSet.setLeftPaddingPoints(10)
        txtSkillSet.layer.cornerRadius = 5.0
        txtSkillSet.layer.masksToBounds = true
        txtSkillSet.layer.borderWidth = 1.0
        txtSkillSet.layer.borderColor = UIColor.lightGray.cgColor
        
        txtRemarks.setLeftPaddingPoints(10)
        txtRemarks.layer.cornerRadius = 5.0
        txtRemarks.layer.masksToBounds = true
        txtRemarks.layer.borderWidth = 1.0
        txtRemarks.layer.borderColor = UIColor.lightGray.cgColor
        
        txtHobbies.setLeftPaddingPoints(10)
        txtHobbies.layer.cornerRadius = 5.0
        txtHobbies.layer.masksToBounds = true
        txtHobbies.layer.borderWidth = 1.0
        txtHobbies.layer.borderColor = UIColor.lightGray.cgColor
        
        txtAlergicTo.setLeftPaddingPoints(10)
        txtAlergicTo.layer.cornerRadius = 5.0
        txtAlergicTo.layer.masksToBounds = true
        txtAlergicTo.layer.borderWidth = 1.0
        txtAlergicTo.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtLanguage.text = lagua
    }
    
    func validatePANCardNumber(_ strPANNumber : String) -> Bool{
                let regularExpression = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
                let panCardValidation = NSPredicate(format : "SELF MATCHES %@", regularExpression)
                return panCardValidation.evaluate(with: strPANNumber)
            }
    func gender(){
        genderDropDown.dataSource = ["Male", "Female"]
        genderDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtGender.text = item
        }
        genderDropDown.width = 200
    }
    func merital(){
        marrital.dataSource = ["UnMarried", "Married", "Widow","Widower","Divorced"]
        marrital.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtMarritalStatus.text = item
        }
        marrital.width = 200
    }
    func relision(){
        relisionDrop.dataSource = ["Hiduism", "Islam", "Christianity","Sikhism","Buddhism","Jainism","Zorostrianism","Judaism"]
        relisionDrop.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtReligion.text = item
        }
        relisionDrop.width = 200
    }
    func bgroup(){
        bGDrop.dataSource = ["A-", "A+", "B-","B+","O+", "O-","AB+","AB-"]
        bGDrop.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtBloodGroup.text = item
        }
        bGDrop.width = 200
    }
    
    @IBAction func maritalStatusAction(_ sender: Any) {
        if btnMaritalStatus.isSelected {
            btnMaritalStatus.isSelected = true
            marrital.hide()
               }else {
                   btnMaritalStatus.isSelected = false
                   marrital.show()
                }
    }
    @IBAction func languageAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageListVC") as! LanguageListVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func language(){
      //  lamguageDropDown.dataSource = ["Hindi", "English", "Other"]
        lamguageDropDown.dataSource = self.languageList
        lamguageDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtLanguage.text = item
        }
        lamguageDropDown.width = 200
    }
    
    @IBAction func genderAction(_ sender: Any) {
        if btnGender.isSelected {
            btnGender.isSelected = true
            genderDropDown.hide()
               }else {
                   btnGender.isSelected = false
                   genderDropDown.show()
                }
    }
    @IBAction func jMonthAction(_ sender: Any) {
        dobDatePicker.alpha = 1.0

        self.joingMonth = jMonthPicker.date.toString(dateFormat: "MMM-yyyy")
        print(self.dob)
    }
    @IBAction func dojAction(_ sender: Any) {
        dobDatePicker.alpha = 1.0

        self.doj = dojDatePicker.date.toString(dateFormat: "dd-MMM-yyyy")
        print(self.dob)
    }
    @IBAction func datePicker(_ sender: Any) {
        dobDatePicker.alpha = 1.0
        self.dob = dobDatePicker.date.toString(dateFormat: "dd-MMM-yyyy")
        print(self.dob)
    }
    
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func personalDetailsAction(_ sender: Any) {

        if btnPersonalDetail.isSelected {
            self.personalViewHeight.constant = 674
            self.personalView.isHidden = false
            btnPersonalDetail.isSelected = false
            btnPersonalDetail.setTitle("-", for: .normal)
               }else {
                   btnPersonalDetail.isSelected = true
                   btnPersonalDetail.setTitle("+", for: .normal)
                   self.personalView.isHidden = true
                   self.personalViewHeight.constant = 0
                }
    }
    @IBAction func additionalAction(_ sender: Any) {
        if btnAdditional.isSelected {
            btnAdditional.isSelected = false
            btnAdditional.setTitle("+", for: .normal)
            self.additionalView.isHidden = true
            self.additionalHeight.constant = 0
               }else {
                   self.additionalHeight.constant = 587
                   self.additionalView.isHidden = false
                   btnAdditional.isSelected = true
                   btnAdditional.setTitle("-", for: .normal)
                }
    }
    
    @IBAction func save(_ sender: Any) {
        
       

        
        if  txtEmail.text!.isValidEmail() {
            if  self.validatePANCardNumber(txtPan.text!) != true{
                let alert = UIAlertController(title: "", message: " Please Enter valid PAN Number", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            if Reachability.isConnectedToNetwork() {
                print("Internet connection OK")
                DispatchQueue.main.async {
                    self.callPersonalDetailsApi()
                    
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
    func callPersonalDetailsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addpersonaldetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "fname": txtfName.text!,
            "mname": txtmName.text!,
            "lname": txtlName.text!,
            "official_email": txtEmail.text!,
            "marital_status": txtMarritalStatus.text!,
            "dob": self.dob,
            "joinmonth": self.doj,
            "gender": txtGender.text!,
            "alt_phone": txtAlternetMobile.text!,
            "pannumber": txtPan.text!,
            "blood_group": txtBloodGroup.text!,
            "adhar_no": txtAadhar.text!,
            "skill_set": txtSkillSet.text!,
            "remarks": txtRemarks.text!
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
                         //   refreshAlert .dismiss(animated: true, completion: nil)

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FamilyDetailsVC") as! FamilyDetailsVC
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
    func callLanguageListApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/getlanguagelist"
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
                            if status == "200"{

                                self.languageList   = title
                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
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
                        let data = json["data"]["personal_detail"].dictionary
                        let fname = data.map {$0["fname"]?.stringValue}
                        let mName = data.map {$0["mname"]?.stringValue}
                        let lName = data.map {$0["lname"]?.stringValue}
                        let email = data.map {$0["email"]?.stringValue}
                        let off_email = data.map {$0["off_email"]?.stringValue}
                        let marital_status = data.map {$0["marital_status"]?.stringValue}
                        
                        let dob = data.map {$0["dob"]?.stringValue}
                        let doj = data.map {$0["doj"]?.stringValue}
                        let joinmonth = data.map {$0["joinmonth"]?.stringValue}
                        let gender = data.map {$0["gender"]?.stringValue}
                        let weight = data.map {$0["weight"]?.stringValue}
                        let height = data.map {$0["height"]?.stringValue}
                        
                        let caste = data.map {$0["caste"]?.stringValue}
                        let contact_no = data.map {$0["contact_no"]?.stringValue}
                        let alt_phone = data.map {$0["alt_phone"]?.stringValue}
                        let designation = data.map {$0["designation"]?.stringValue}
                        let language = data.map {$0["language"]?.stringValue}
                        let religion = data.map {$0["religion"]?.stringValue}
                        let nationalty = data.map {$0["nationalty"]?.stringValue}
                        let pannumber = data.map {$0["blood_group"]?.stringValue}
                        let financial_year = data.map {$0["financial_year"]?.stringValue}
                        let adhar_no = data.map {$0["adhar_no"]?.stringValue}
                        let level = data.map {$0["level"]?.stringValue}
                        let skill_set = data.map {$0["skill_set"]?.stringValue}
                        let hobbies = data.map {$0["hobbies"]?.stringValue}
                        
                        let is_prefilled = data.map {$0["is_prefilled"]?.stringValue} ?? ""
                        self.is_prefilled = is_prefilled!
                        self.txtfName.text! = (fname ?? "") ?? ""
                        self.txtmName.text! = (mName ?? "") ?? ""
                        self.txtlName.text! = (lName ?? "") ?? ""
                        
                        self.txtEmail.text! = (email ?? "") ?? ""
                        self.txtOfficialEmail.text! = (off_email ?? "") ?? ""
                        self.txtMarritalStatus.text! = (marital_status ?? "") ?? ""
                        
                      //  self.txtDOB.text! = (dob ?? "") ?? ""
                      //  self.txtDOJ.text! = (doj ?? "") ?? ""
                      //  self.txtJoiningMonth.text! = (joinmonth ?? "") ?? ""
                        
                        self.txtCaste.text! = (caste ?? "") ?? ""
                        self.txtMobile.text! = (contact_no ?? "") ?? ""
                        self.txtAlternetMobile.text! = (alt_phone ?? "") ?? ""
                        
                       // self.txtLanguage.text! = (language ?? "") ?? ""
                        self.txtReligion.text! = (religion ?? "") ?? ""
                        self.txtPan.text! = (pannumber ?? "") ?? ""
                        self.txtNationality.text! = (nationalty ?? "") ?? ""
                        self.txtRemarks.text! = (religion ?? "") ?? ""
                        self.txtSkillSet.text! = (skill_set ?? "") ?? ""
                        self.txtHobbies.text! = (hobbies ?? "") ?? ""
                        self.txtLevel.text! = (level ?? "") ?? ""
     
                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
                    }
                }
}
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }

}
