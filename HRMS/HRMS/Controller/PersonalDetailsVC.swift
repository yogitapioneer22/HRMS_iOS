//
//  PersonalDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import  DropDown

class PersonalDetailsVC: UIViewController {
    @IBOutlet weak var txtIsFresher: UITextField!
    
    @IBOutlet weak var txtLto: UITextField!
    @IBOutlet weak var txtLFrom: UITextField!
    @IBOutlet weak var txtTo: UITextField!
    @IBOutlet weak var txtFrom: UITextField!
    @IBOutlet weak var txtReason: UITextField!
    @IBOutlet weak var txtLRole: UITextField!
    @IBOutlet weak var txtExp: UITextField!
    @IBOutlet weak var txtDesig: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var txtLastCTC: UITextField!
    @IBOutlet weak var txtEnterRoll: UITextField!
    @IBOutlet weak var txtExperience: UITextField!
    @IBOutlet weak var txtOtherCDetails: UITextField!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var emAddress: UITextField!
    @IBOutlet weak var txtDatJ: UITextField!
    @IBOutlet weak var currentDesg: UITextField!
    @IBOutlet weak var lastEm: UITextField!
    
    @IBOutlet weak var txtEMAdd: UITextField!
    @IBOutlet weak var txtLEm: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtTotalEx: UITextField!
    @IBOutlet weak var txtLReason: UITextField!
    @IBOutlet weak var btnProfesional: UIButton!
    @IBOutlet weak var txtLCDesig: UITextField!
    
    @IBOutlet weak var lastComView: UIView!
    @IBOutlet weak var professnalView: UIView!
    @IBOutlet weak var lastComHeight: NSLayoutConstraint!
    @IBOutlet weak var professionHeight: NSLayoutConstraint!
    @IBOutlet weak var btnLastCom: UIButton!
    let fresherDrop = DropDown()
    var fromDate = ""
    var toDate = ""
    let screenSize: CGRect = UIScreen.main.bounds
    let customView = UIView()
   var is_prefilled = "1"
    var lagList = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastComView.isHidden = true
        self.lastComHeight.constant = 0
        btnLastCom.isSelected = true
        updateUI()
        fresher()
        //customView.frame = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width - 200, height: 200))
        customView.frame = CGRect.init(x: 0, y: 0, width: 200, height: 200)
      //  customView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 200)
          customView.backgroundColor = UIColor.gray     //give color to the view
        //  customView.center = self.view.center
         // self.view.addSubview(customView)
    }
    @IBAction func btnProfessionaAction(_ sender: Any) {
        if btnProfesional.isSelected {
            self.professionHeight.constant = 674
            self.professnalView.isHidden = false
            btnProfesional.isSelected = false
            btnProfesional.setTitle("-", for: .normal)
               }else {
                   btnProfesional.isSelected = true
                   btnProfesional.setTitle("+", for: .normal)
                   self.professnalView.isHidden = true
                   self.professionHeight.constant = 0
                }
    }
    
    @IBAction func btnLastComAction(_ sender: Any) {
        
        if btnLastCom.isSelected {
            btnLastCom.isSelected = false
            self.lastComHeight.constant = 372
            self.lastComView.isHidden = false
            btnLastCom.setTitle("-", for: .normal)
               }else {
                   btnLastCom.isSelected = true
                   btnLastCom.setTitle("+", for: .normal)
                   self.lastComView.isHidden = true
                   self.lastComHeight.constant = 0
                }
    }
    @IBAction func txtFresherPressed(_ sender: Any) {
        if txtIsFresher.isSelected {
            txtIsFresher.isSelected = true
            fresherDrop.hide()
               }else {
                   txtIsFresher.isSelected = false
                   fresherDrop.show()
                }
    }
    @IBAction func toDateAction(_ sender: Any) {
        self.toDate = toDatePicker.date.toString(dateFormat: "MMM-yyyy")
    }
    @IBAction func fromDateAction(_ sender: Any) {
        self.fromDate = fromDatePicker.date.toString(dateFormat: "MMM-yyyy")

    }
    @IBAction func saveAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.callProfessionaDetailsApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func fresher(){
        fresherDrop.dataSource = ["Yes", "No"]
        fresherDrop.selectionAction = { [unowned self] (index: Int, item: String) in
         // print("Selected item: \(item) at index: \(index)")
            self.txtIsFresher.text = item
        }
        fresherDrop.width = 200
       // fresherDrop.direction = .bottom
        fresherDrop.frame = customView.frame
       // fresherDrop.leftAnchor.constraint(equalTo: txtIsFresher.leftAnchor, constant: 20).isActive = true
//        fresherDrop.rightAnchor.constraint(equalTo: txtIsFresher.rightAnchor, constant: -20).isActive = true
//
//        fresherDrop.centerYAnchor.constraint(equalTo: txtIsFresher.centerYAnchor).isActive = true
//        fresherDrop.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    
    func updateUI(){
        btnSave.layer.cornerRadius = 5.0
        btnSave.layer.masksToBounds = true
        //txtfName.setRightPaddingPoints(10)
        txtIsFresher.setLeftPaddingPoints(10)
        txtIsFresher.layer.cornerRadius = 5.0
        txtIsFresher.layer.masksToBounds = true
        txtIsFresher.layer.borderWidth = 1.0
        txtIsFresher.layer.borderColor = UIColor.lightGray.cgColor
        
        txtReason.setLeftPaddingPoints(10)
        txtReason.layer.cornerRadius = 5.0
        txtReason.layer.masksToBounds = true
        txtReason.layer.borderWidth = 1.0
        txtReason.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLRole.setLeftPaddingPoints(10)
        txtLRole.layer.cornerRadius = 5.0
        txtLRole.layer.masksToBounds = true
        txtLRole.layer.borderWidth = 1.0
        txtLRole.layer.borderColor = UIColor.lightGray.cgColor
        
        txtExp.setLeftPaddingPoints(10)
        txtExp.layer.cornerRadius = 5.0
        txtExp.layer.masksToBounds = true
        txtExp.layer.borderWidth = 1.0
        txtExp.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDesig.setLeftPaddingPoints(10)
        txtDesig.layer.cornerRadius = 5.0
        txtDesig.layer.masksToBounds = true
        txtDesig.layer.borderWidth = 1.0
        txtDesig.layer.borderColor = UIColor.lightGray.cgColor
        
        txtName.setLeftPaddingPoints(10)
        txtName.layer.cornerRadius = 5.0
        txtName.layer.masksToBounds = true
        txtName.layer.borderWidth = 1.0
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLastCTC.setLeftPaddingPoints(10)
        txtLastCTC.layer.cornerRadius = 5.0
        txtLastCTC.layer.masksToBounds = true
        txtLastCTC.layer.borderWidth = 1.0
        txtLastCTC.layer.borderColor = UIColor.lightGray.cgColor
        
        txtEnterRoll.setLeftPaddingPoints(10)
        txtEnterRoll.layer.cornerRadius = 5.0
        txtEnterRoll.layer.masksToBounds = true
        txtEnterRoll.layer.borderWidth = 1.0
        txtEnterRoll.layer.borderColor = UIColor.lightGray.cgColor
        
        txtExperience.setLeftPaddingPoints(10)
        txtExperience.layer.cornerRadius = 5.0
        txtExperience.layer.masksToBounds = true
        txtExperience.layer.borderWidth = 1.0
        txtExperience.layer.borderColor = UIColor.lightGray.cgColor
        
        txtOtherCDetails.setLeftPaddingPoints(10)
        txtOtherCDetails.layer.cornerRadius = 5.0
        txtOtherCDetails.layer.masksToBounds = true
        txtOtherCDetails.layer.borderWidth = 1.0
        txtOtherCDetails.layer.borderColor = UIColor.lightGray.cgColor
        
        txtOtherCDetails.setLeftPaddingPoints(10)
        txtOtherCDetails.layer.cornerRadius = 5.0
        txtOtherCDetails.layer.masksToBounds = true
        txtOtherCDetails.layer.borderWidth = 1.0
        txtOtherCDetails.layer.borderColor = UIColor.lightGray.cgColor
        
        emAddress.setLeftPaddingPoints(10)
        emAddress.layer.cornerRadius = 5.0
        emAddress.layer.masksToBounds = true
        emAddress.layer.borderWidth = 1.0
        emAddress.layer.borderColor = UIColor.lightGray.cgColor
        
        txtDatJ.setLeftPaddingPoints(10)
        txtDatJ.layer.cornerRadius = 5.0
        txtDatJ.layer.masksToBounds = true
        txtDatJ.layer.borderWidth = 1.0
        txtDatJ.layer.borderColor = UIColor.lightGray.cgColor
        
        currentDesg.setLeftPaddingPoints(10)
        currentDesg.layer.cornerRadius = 5.0
        currentDesg.layer.masksToBounds = true
        currentDesg.layer.borderWidth = 1.0
        currentDesg.layer.borderColor = UIColor.lightGray.cgColor
        
        lastEm.setLeftPaddingPoints(10)
        lastEm.layer.cornerRadius = 5.0
        lastEm.layer.masksToBounds = true
        lastEm.layer.borderWidth = 1.0
        lastEm.layer.borderColor = UIColor.lightGray.cgColor
        
        txtEMAdd.setLeftPaddingPoints(10)
        txtEMAdd.layer.cornerRadius = 5.0
        txtEMAdd.layer.masksToBounds = true
        txtEMAdd.layer.borderWidth = 1.0
        txtEMAdd.layer.borderColor = UIColor.lightGray.cgColor
        
        txtTotalEx.setLeftPaddingPoints(10)
        txtTotalEx.layer.cornerRadius = 5.0
        txtTotalEx.layer.masksToBounds = true
        txtTotalEx.layer.borderWidth = 1.0
        txtTotalEx.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLEm.setLeftPaddingPoints(10)
        txtLEm.layer.cornerRadius = 5.0
        txtLEm.layer.masksToBounds = true
        txtLEm.layer.borderWidth = 1.0
        txtLEm.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLReason.setLeftPaddingPoints(10)
        txtLReason.layer.cornerRadius = 5.0
        txtLReason.layer.masksToBounds = true
        txtLReason.layer.borderWidth = 1.0
        txtLReason.layer.borderColor = UIColor.lightGray.cgColor
        
        txtLCDesig.setLeftPaddingPoints(10)
        txtLCDesig.layer.cornerRadius = 5.0
        txtLCDesig.layer.masksToBounds = true
        txtLCDesig.layer.borderWidth = 1.0
        txtLCDesig.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFrom.setLeftPaddingPoints(10)
        txtFrom.layer.cornerRadius = 5.0
        txtFrom.layer.masksToBounds = true
        txtFrom.layer.borderWidth = 1.0
        txtFrom.layer.borderColor = UIColor.lightGray.cgColor

        txtTo.setLeftPaddingPoints(10)
        txtTo.layer.cornerRadius = 5.0
        txtTo.layer.masksToBounds = true
        txtTo.layer.borderWidth = 1.0
        txtTo.layer.borderColor = UIColor.lightGray.cgColor

        txtLFrom.setLeftPaddingPoints(10)
        txtLFrom.layer.cornerRadius = 5.0
        txtLFrom.layer.masksToBounds = true
        txtLFrom.layer.borderWidth = 1.0
        txtLFrom.layer.borderColor = UIColor.lightGray.cgColor

        txtLto.setLeftPaddingPoints(10)
        txtLto.layer.cornerRadius = 5.0
        txtLto.layer.masksToBounds = true
        txtLto.layer.borderWidth = 1.0
        txtLto.layer.borderColor = UIColor.lightGray.cgColor
    }
    func callProfessionaDetailsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addprofeessionaldetail"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "emprname1": txtName.text!,
            "emprdesg1": txtDesig.text!,
            "empradd1": txtEMAdd.text!,
            "emprexp1": txtExp.text!,
            "emprrole1": txtLRole.text!,
            "emprname2": txtLEm.text!,
            "emprdesg2": txtLCDesig.text!,
            "empradd2": txtEMAdd.text!,
            "emprexp2": txtExperience.text!,
            "emprrole2": txtEnterRoll.text!,
            "emprname3": "1test",
            "emprdesg3": "1test",
            "empradd3": "1test",
            "emprexp3": "1test",
            "emprrole3": "test",
            "totalexp": "test1",
            "last_company_name": "test1",
            "emprfrom1": self.fromDate,
            "emprto1": self.toDate,
            "empreason1": txtReason.text!,
            "emprfrom2": self.fromDate,
            "emprto2": self.toDate,
            "empreason2": "1test",
            "emprfrom3": "test1",
            "emprto3": "test",
            "empreason3": "test1",
            "emprname4": "test1",
            "emprdesg4": "test1",
            "empradd4": "test1",
            "emprexp4": "test",
            "emprrole4": "test1",
            "emprfrom4": "test1",
            "emprto4": "test1",
            "empreason4": "test1",
            "is_fresher": self.txtIsFresher.text!,
            "last_reportingto_name": txtReason.text!,
            "last_reportingto_designation": "test1",
            "last_ctc": txtLastCTC.text!,
            "lastcomp_firstdesignation": self.txtLCDesig.text!
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
    func callProfessionDocsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addprofessionaldocs"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "matric": "1",
            "secondary": "1",
            "certification": "1",
            "last_company_exp": "1",
            "professional_doc": "test.jpg"
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
                        let data = json["data"]["professional_detail"].dictionary
                        let is_fresher = data.map {$0["is_fresher"]?.stringValue}
                        let last_company_name = data.map {$0["last_company_name"]?.stringValue}
                        let lastcomp_firstdesignation = data.map {$0["lastcomp_firstdesignation"]?.stringValue}
                        let emprexp1 = data.map {$0["emprexp1"]?.stringValue}
                        let emprname1 = data.map {$0["emprname1"]?.stringValue}
                        let emprto1 = data.map {$0["emprto1"]?.stringValue}
                        let emprexp2 = data.map {$0["emprexp2"]?.stringValue}
                        let totalexp = data.map {$0["totalexp"]?.stringValue}
                        let emprname2 = data.map {$0["emprname2"]?.stringValue}
                        let emprfrom1 = data.map {$0["emprfrom1"]?.stringValue}
                        let empradd1 = data.map {$0["empradd1"]?.stringValue}
                        let emprdesg1 = data.map {$0["emprdesg1"]?.stringValue}
                        let emprrole1 = data.map {$0["emprrole1"]?.stringValue}
                        let emprdesg2 = data.map {$0["emprdesg2"]?.stringValue}
                        let empreason3 = data.map {$0["empreason3"]?.stringValue}
                        let emprrole3 = data.map {$0["emprrole3"]?.stringValue}
                        let empreason2 = data.map {$0["empreason2"]?.stringValue}
                        let emprto2 = data.map {$0["emprto2"]?.stringValue}
                        let last_ctc = data.map {$0["last_ctc"]?.stringValue}
                    
                        
                        let is_prefilled = data.map {$0["is_prefilled"]?.stringValue} ?? ""
                        self.is_prefilled = is_prefilled!
                        self.txtLEm.text! = (emprname1 ?? "") ?? ""
                        self.txtTo.text! = (emprto1 ?? "") ?? ""
                        self.txtDesig.text! = (emprdesg1 ?? "") ?? ""
                        
                        self.txtReason.text! = (empreason2 ?? "") ?? ""
                        self.txtLReason.text! = (empreason2 ?? "") ?? ""
                        self.txtExperience.text! = (emprexp1 ?? "") ?? ""
                        
                        self.txtExp.text! = (totalexp ?? "") ?? ""
                        self.txtName.text! = (last_company_name ?? "") ?? ""
                        self.txtLastCTC.text! = (last_ctc ?? "") ?? ""
                        
                        self.txtLRole.text! = (emprrole1 ?? "") ?? ""
                        self.txtOtherCDetails.text! = (emprrole3 ?? "") ?? ""

                       
     
                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
                    }
                }
}

}
