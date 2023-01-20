//
//  BAnkDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class BAnkDetailsVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var textViewAgree: UILabel!
    @IBOutlet weak var txtReasonForChange: UITextField!
    @IBOutlet weak var txtCheque: UITextField!
    @IBOutlet weak var txtAccountNo: UITextField!
    @IBOutlet weak var txtBranch: UITextField!
    @IBOutlet weak var lblIfsc: UITextField!
    @IBOutlet weak var lblBankName: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    var check = ""
    var is_prefilled = ""
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        joineedetailApi()
        updateUI()
        
    }
    @IBAction func uploadDoc(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                   imagePicker.delegate = self
                   imagePicker.sourceType = .photoLibrary
                   imagePicker.allowsEditing = false

                   present(imagePicker, animated: true, completion: nil)
               }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
          if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              imgView.image = image
          }

      }

    
    @IBAction func checkAction(_ sender: Any) {
        if btnCheck.isSelected {
            btnCheck.isSelected = false
            btnCheck.setImage(#imageLiteral(resourceName: "square radio button black copy"), for: .normal)
            self.check = "0"
        }else {
            btnCheck.isSelected = true
            btnCheck.setImage(#imageLiteral(resourceName: "square radio button green copy"), for: .normal)
            self.check = "1"
        }
    }
    @IBAction func back(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OnboardingDetailsVC") as! OnboardingDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func updateUI(){
        btnSave.layer.cornerRadius = 5.0
        btnSave.layer.masksToBounds = true
        //txtfName.setRightPaddingPoints(10)
        lblName.setLeftPaddingPoints(10)
        lblName.layer.cornerRadius = 5.0
        lblName.layer.masksToBounds = true
        lblName.layer.borderWidth = 1.0
        lblName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtReasonForChange.setLeftPaddingPoints(10)
        txtReasonForChange.layer.cornerRadius = 5.0
        txtReasonForChange.layer.masksToBounds = true
        txtReasonForChange.layer.borderWidth = 1.0
        txtReasonForChange.layer.borderColor = UIColor.lightGray.cgColor
        
        txtCheque.setLeftPaddingPoints(10)
        txtCheque.layer.cornerRadius = 5.0
        txtCheque.layer.masksToBounds = true
        txtCheque.layer.borderWidth = 1.0
        txtCheque.layer.borderColor = UIColor.lightGray.cgColor
        
        lblBankName.setLeftPaddingPoints(10)
        lblBankName.layer.cornerRadius = 5.0
        lblBankName.layer.masksToBounds = true
        lblBankName.layer.borderWidth = 1.0
        lblBankName.layer.borderColor = UIColor.lightGray.cgColor
        
        lblIfsc.setLeftPaddingPoints(10)
        lblIfsc.layer.cornerRadius = 5.0
        lblIfsc.layer.masksToBounds = true
        lblIfsc.layer.borderWidth = 1.0
        lblIfsc.layer.borderColor = UIColor.lightGray.cgColor
        
        txtBranch.setLeftPaddingPoints(10)
        txtBranch.layer.cornerRadius = 5.0
        txtBranch.layer.masksToBounds = true
        txtBranch.layer.borderWidth = 1.0
        txtBranch.layer.borderColor = UIColor.lightGray.cgColor
        
        txtAccountNo.setLeftPaddingPoints(10)
        txtAccountNo.layer.cornerRadius = 5.0
        txtAccountNo.layer.masksToBounds = true
        txtAccountNo.layer.borderWidth = 1.0
        txtAccountNo.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    @IBAction func saveAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
            DispatchQueue.main.async {
                self.callBankDetailsApi()

            }
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func callBankDetailsApi(){
        let loginUrl = AppConstants().baseUrl + "Newjoineelogin/addbankdocs"
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token") ?? "NA"
        let parameters = [
            "token": appToken,
            "bank_name": lblBankName.text!,
            "ifsc_code": lblIfsc.text!,
            "branch": txtBranch.text!,
            "fname": lblName.text!,
            "bankaccount_number": txtAccountNo.text!,
            "bankaccount_name": lblBankName.text!,
            "is_acceptbankpolicy": self.check,
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
                            refreshAlert .dismiss(animated: true, completion: nil)

//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EducationDetailsVC") as! EducationDetailsVC
//                self.present(nextViewController, animated:true, completion:nil)
                                    
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
                        let data = json["data"]["bank_detail"].dictionary
                        let is_acceptbankpolicy = data.map {$0["is_acceptbankpolicy"]?.stringValue}
                        let bankaccount_number = data.map {$0["bankaccount_number"]?.stringValue}
                        let bankaccount_name = data.map {$0["bankaccount_name"]?.stringValue}
                        let bank_name = data.map {$0["bank_name"]?.stringValue}
                        let ifsc_code = data.map {$0["ifsc_code"]?.stringValue}
                        let branch = data.map {$0["branch"]?.stringValue}
                        let reason_accountchange = data.map {$0["reason_accountchange"]?.stringValue}
                        
                        let bank_document = data.map {$0["bank_document"]?.stringValue}
                        let document_copy = data.map {$0["document_copy"]?.stringValue}
                        let is_prefilled = data.map {$0["is_prefilled"]?.stringValue}
                      
                      self.is_prefilled = is_prefilled! ?? ""
                        self.txtBranch.text! = (branch ?? "") ?? ""
                        self.txtAccountNo.text! = (bankaccount_number ?? "") ?? ""
                       // self.txtCheque.text! = (bank_document ?? "") ?? ""
                        self.txtReasonForChange.text! = (reason_accountchange ?? "") ?? ""
                        self.lblBankName.text! = (bank_name ?? "") ?? ""
                        self.lblName.text! = (bankaccount_name ?? "") ?? ""
                        self.lblIfsc.text! = (ifsc_code ?? "") ?? ""

                        
                            }
                        break
                    case .failure:
                        print(Error.self)
                        
                       
                    }
                }
}

}
