//
//  NotificationVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
class NotificationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var notificationTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        notificationApi()
    }
    @IBAction func backAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(next, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (self.notificationTable.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as? NotificationTableViewCell)!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func notificationApi(){
        let loginUrl = AppConstants().baseUrl + "Notification/allnotification"
        
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
       let appToken = UserDefaults.standard.string(forKey: "token")
        let parameters = [
            "token": appToken
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
                        let data = json["data"].arrayValue
//                        let salary_month =  json["data"].arrayValue.map {$0["salary_month"].stringValue}
//                        let working_days =  json["data"].arrayValue.map {$0["working_days"].stringValue}
//                        let gross_salary =  json["data"].arrayValue.map {$0["gross_salary"].intValue}
//                        let total_deduction =  json["data"].arrayValue.map {$0["total_deduction"].stringValue}
//                        let netsalary =  json["data"].arrayValue.map {$0["netsalary"].stringValue}
//                        let month =  json["data"].arrayValue.map {$0["month"].stringValue}
//                        let start_date =  json["data"].arrayValue.map {$0["start_date"].intValue}
//                        let end_date =  json["data"].arrayValue.map {$0["end_date"].stringValue}
//
//
                   
                      print(status)
                    if status == "200"{
                        if data.count == 0{
                            let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                                
                            }))
                            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                            refreshAlert .dismiss(animated: true, completion: nil)
                                                                   }))
                            self.present(refreshAlert, animated: true, completion: nil)
                        }
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
