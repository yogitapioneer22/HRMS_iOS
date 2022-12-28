//
//  HomeVC.swift
//  HRMS
//
//  Created by Brijesh bhardwaj on 12/12/22.
//

import UIKit
import MarqueeLabel
class HomeVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblWelcome: MarqueeLabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var homeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        lblWelcome.type = .continuous
        lblWelcome.scrollDuration = 3.0
        lblWelcome.animationCurve = .easeInOut
        lblWelcome.fadeLength = 10.0
        lblWelcome.leadingBuffer = 0.0
        lblWelcome.trailingBuffer = 0.0
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        homeCollection.setCollectionViewLayout(layout, animated: true)
        var dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium

        self.lblTime.text = dateFormatter.string(from: NSDate() as Date)
      
        self.view1.layer.cornerRadius = 8
        self.view1.layer.borderWidth = 1
        self.view1.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.view2.layer.cornerRadius = 8
        self.view2.layer.borderWidth = 1
        self.view2.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.view3.layer.cornerRadius = 8
        self.view3.layer.borderWidth = 1
        self.view3.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.view4.layer.cornerRadius = 8
        self.view4.layer.borderWidth = 1
        self.view4.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        

    }
    @IBAction func sideMenuAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func notification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func setting(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 8
    }
    
    @IBAction func btn1Action(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaySlipVC") as! PaySlipVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func btn2Action(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RaiseRequestVC") as! RaiseRequestVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func btn3Action(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WFHVC") as! WFHVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func btn4Action(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TaskReminderVC") as! TaskReminderVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (homeCollection.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell)!
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
        
        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = homeCollection.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:160)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
