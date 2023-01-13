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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
