//
//  AddressDetailsVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 09/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddressDetailsVC: UIViewController {
    @IBOutlet weak var txtLocalAdd: UITextField!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var txtPIN2: UITextField!
    @IBOutlet weak var txtCity2: UITextField!
    @IBOutlet weak var txtState2: UITextField!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtPermanentAdd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func checkBoxAction(_ sender: Any) {
        if btnCheckBox.isSelected {
            btnCheckBox.isSelected = false
            btnCheckBox.setImage(#imageLiteral(resourceName: "square radio button black copy"), for: .normal)
            self.txtLocalAdd.text! = ""
            self.txtState2.text! = ""
            self.txtCity2.text! = ""
            self.txtPIN2.text! = ""
            
        }else {
            btnCheckBox.isSelected = true
            btnCheckBox.setImage(#imageLiteral(resourceName: "square radio button green copy"), for: .normal)
            self.txtLocalAdd.text! = txtPermanentAdd.text!
            self.txtState2.text! = txtState.text!
            self.txtCity2.text! = txtCity.text!
            self.txtPIN2.text! = txtPinCode.text!
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
            "is_sameaddress": "1"
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

}