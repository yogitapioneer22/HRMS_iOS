//
//  PaySlipVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 18/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class PaySlipVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

    @IBOutlet weak var tavleView: UITableView!
    var month = [""]
    var salary = [0]
    var deduct = [0]
    var days = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tavleView.delegate = self
        self.tavleView.dataSource = self

        paySlipApi()
        
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaySlipTableViewCell", for: indexPath) as? PaySlipTableViewCell
        cell?.lblDays.text = days[indexPath.row]
        cell?.lblMonth.text = month[indexPath.row]
        cell?.lblSalary.text = String(salary[indexPath.row])
        cell?.lblDiduction.text = String(deduct[indexPath.row])
        return  cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
  
    func paySlipApi(){
        let loginUrl = AppConstants().baseUrl + "Salary/payslip"
        
        let headers:HTTPHeaders = [
          
        ]
        LoadingOverlay.shared.showOverlay(view: view)
        let appToken =  UserDefaults.standard.string(forKey: "token")
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
                        
                    let salary_month =  json["data"].arrayValue.map {$0["salary_month"].stringValue}
                       let working_days =  json["data"].arrayValue.map {$0["working_days"].stringValue}
                        let gross_salary =  json["data"].arrayValue.map {$0["gross_salary"].intValue}
                        let total_deduction =  json["data"].arrayValue.map {$0["total_deduction"].intValue}
                        
                        self.days = working_days
                        self.salary = gross_salary
                        self.month = salary_month
                        self.deduct = total_deduction
                        
                        self.tavleView.reloadData()
//                        let netsalary =  json["data"].arrayValue.map {$0["netsalary"].stringValue}
//                        let month =  json["data"].arrayValue.map {$0["month"].stringValue}
//                        let start_date =  json["data"].arrayValue.map {$0["start_date"].intValue}
//                        let end_date =  json["data"].arrayValue.map {$0["end_date"].stringValue}
                        
                        if data.count == 0{
                            
                            let refreshAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                self.present(refreshAlert, animated: true, completion: nil)

                                
                            }))
                            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                            refreshAlert .dismiss(animated: true, completion: nil)
                                                                   }))
                            self.present(refreshAlert, animated: true, completion: nil)
                        }
                   
                      print(status)
                    if status == "200"{
    
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
