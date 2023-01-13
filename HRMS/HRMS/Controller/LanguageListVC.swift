//
//  LanguageListVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/01/23.
//

import UIKit
import Alamofire
import SwiftyJSON
class LanguageListVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var lagList = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callLanguageListApi()
        
    }
    
    @IBAction func back(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "BasicDetailsVC") as! BasicDetailsVC
//
//        self.navigationController?.pushViewController(nextVC, animated: true)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BasicDetailsVC") as! BasicDetailsVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lagList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageListTableViewCell", for: indexPath) as? LanguageListTableViewCell
        cell?.lblList.text! = lagList[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "BasicDetailsVC") as! BasicDetailsVC
        
        nextVC.lagua = lagList[indexPath.row]
        self.present(nextVC, animated:true, completion:nil)
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
                self.lagList   = title
                self.tableView.reloadData()
                break
            case .failure:
                print(Error.self)
                
                
            }
        }
        
    }
}
