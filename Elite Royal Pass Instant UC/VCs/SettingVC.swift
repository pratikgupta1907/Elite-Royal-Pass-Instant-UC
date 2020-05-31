//
//  SettingVC.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 14/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Kingfisher
import MessageUI

class SettingVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! settingCellTableViewCell
        cell.img.image = imageArray[indexPath.row]
        cell.labl.text = nameArray[indexPath.row]
        cell.buttonCliked.tag = indexPath.row
        cell.buttonCliked.addTarget(self, action: #selector(cliked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func cliked(sender:UIButton){
        if sender.tag == 0 {
            let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "RedeemVC") as! RedeemVC
            newViewController.whatisMe = "Reedem"
            navigationController?.pushViewController(newViewController, animated: true)
        }else if sender.tag == 1 {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(createEmailUrl(to:myMail, subject: "Feedback", body: "")!)
            } else {
                UIApplication.shared.openURL(createEmailUrl(to:myMail, subject: "Feedback", body: "")!)
            }
            
        } else  if sender.tag == 2 {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(createEmailUrl(to:myMail, subject: "Bug/Problem", body: "")!)
            } else {
                UIApplication.shared.openURL(createEmailUrl(to:myMail, subject: "Bug/Problem", body: "")!)
            }
        }else  if sender.tag == 3 {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "https://apps.apple.com/us/developer/junaid-mukadam/id1365586675")!)
            } else {
                UIApplication.shared.openURL(URL(string: "https://apps.apple.com/us/developer/junaid-mukadam/id1365586675")!)
            }
            
        }else if sender.tag == 4{
            let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "RedeemVC") as! RedeemVC
            newViewController.whatisMe = "Webview"
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    let imageArray = [#imageLiteral(resourceName: "commerce"),#imageLiteral(resourceName: "love-and-romance.png"),#imageLiteral(resourceName: "interface"),#imageLiteral(resourceName: "signs.png"),#imageLiteral(resourceName: "document.png")]
    let nameArray = ["Redeem","Feedback","Bug / Problem","Rate Us","Privacy Policy"]
    let myMail = "saifmukadam2110@gmail.com"
    @IBOutlet weak var myView: UITableView!
    @IBOutlet weak var profileVIew: UIView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        profileVIew.layer.cornerRadius = 15
        profileVIew.layer.borderWidth = 2
        profileVIew.layer.borderColor = UIColor.systemOrange.cgColor
        
        name.text = UserDefaults.standard.getUsername()
        email.text = UserDefaults.standard.getUserEmail()
        
        if UserDefaults.standard.getUserProfilePic().contains("https"){
            let url = URL(string: UserDefaults.standard.getUserProfilePic())
            profilePic.kf.setImage(with: url)
        }
        //  print(UserDefaults.standard.getUserProfilePic())
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController!.navigationBar.topItem!.title = "Setting"
    }
    
    override func viewDidLayoutSubviews() {
        profilePic.layer.borderWidth = 2
        profilePic.layer.borderColor = UIColor.systemOrange.cgColor
        profilePic.clipsToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.height/2
        
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
}
