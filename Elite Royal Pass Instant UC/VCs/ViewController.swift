//
//  ViewController.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 09/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMobileAds

class ViewController: UIViewController{
    
    var indexPath = 0
    var Ad_Token = "0"
    
    var Gtitel = ""
    var message = ""
    var but1 = ""
    var but2 = ""
    var link = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer()
        winRoaylePass.isUserInteractionEnabled = true
        winRoaylePass.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(winroyalPassCliked))
        
        statusConstraints()
        royalpassConstraints()
        tabeViewConstraints()
        
        if Connectivity.isConnectedToInternet {
            
        } else {
            let alert2 = UIAlertController(title: "Connection Error", message: "The Internet connection appears to be offline.Please connect to Internet and open the app again.", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "EXIT APP", style: .default, handler: { action in
                switch action.style{
                case .default:
                    exit(0)
                case .cancel:
                    print("")
                case .destructive:
                    print("")
                @unknown default:
                    fatalError()
                }}))
            
            present(alert2, animated: true, completion: nil)
            print("Not Connected")
        }
        
        
        
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Int(Ad_Token)! > 0  || indexPath.row > 3 {
            self.indexPath = indexPath.row
            let currentTimeInMiliseconds = Date().timeIntervalSince1970 * 1000
            UserDefaults.standard.set(currentTimeInMiliseconds+1800000, forKey: String(self.indexPath))
            var whatis = "Lucky_Card"
            if self.indexPath == 0 {
                whatis = "Slot_Machine"
                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngineTwo") as! CardsEngineTwo
                newViewController.whatisThis = whatis
                navigationController?.pushViewController(newViewController, animated: true)
                
            }else if self.indexPath == 1 {
                whatis = "Lucky_Card"
                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngine") as! CardsEngine
                newViewController.whatisThis = whatis
                navigationController?.pushViewController(newViewController, animated: true)
            }else if self.indexPath == 2 {
                whatis = "Lucky_Envelope"  //Refer_Friend
                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "LuckyEnvelopeVC") as! LuckyEnvelopeVC
                navigationController?.pushViewController(newViewController, animated: true)
            }else if self.indexPath == 3 {
                whatis = "Scratch_Card"
                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngine") as! CardsEngine
                newViewController.whatisThis = whatis
                navigationController?.pushViewController(newViewController, animated: true)
            }else if indexPath.row == 4 {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "https://apps.apple.com/in/app/royal-pass-instant-earn-uc/id1514485237")!)
                } else {
                    UIApplication.shared.openURL(URL(string: "https://apps.apple.com/in/app/royal-pass-instant-earn-uc/id1514485237")!)
                }
            }else if indexPath.row == 5 {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "https://www.instagram.com/thisis_saif/")!)
                } else {
                    UIApplication.shared.openURL(URL(string: "https://www.instagram.com/thisis_saif/")!)
                }
                
            }
        }else{
            
            self.present(myAlt(titel:"Ad Tokens Required",message:"You Don't Have Enough Ad Tokens.Please Watch Ad or Wait For One Day."), animated: true, completion: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController!.navigationBar.topItem!.title = "Home"
        let Parameters:Parameters = [
            "id": UserDefaults.standard.getid(),
            "WhatYouWant":"CoinsJSON"
        ]
        
        postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
            self.statusUCcoins.text = json["Coins"].string ?? ""
            UserDefaults.standard.setUsername(value: json["Name"].string ?? "null")
            UserDefaults.standard.setUserEmail(value: json["Email"].string ?? "null")
            UserDefaults.standard.setUserUserProfilePic(value: json["Profile"].string ?? "null")
            UserDefaults.standard.setReferralCode(value: json["RfCode"].string ?? "null")
            self.Ad_Token = json["Ad_Token"].string ?? "0"
            
            self.Gtitel = json["title"].string ?? "Giveaway"
            self.message = json["message"].string ?? "Follow us on Instagram to participate in Giveaway"
            self.but1 = json["but1"].string ?? "Follow"
            self.but2 = json["but2"].string ?? "Cancel"
            self.link = json["link"].string ?? "https://www.instagram.com/royal_pass_instant/"
        }
        
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
        
    }
    
    func royalpassConstraints() {
        self.view.addSubview(winRoaylePass)
        winRoaylePass.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            winRoaylePass.topAnchor.constraint(equalTo: self.statusView.bottomAnchor),
            winRoaylePass.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 8),
            winRoaylePass.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -8),
            winRoaylePass.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.24)
        ])
    }
    
    func statusConstraints() {
        self.view.addSubview(statusView)
        statusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            statusView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            statusView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08)
        ])
        
        statusView.addSubview(statustitel)
        statustitel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statustitel.heightAnchor.constraint(equalTo: statusView.heightAnchor, multiplier: 1),
            statustitel.leadingAnchor.constraint(equalTo: statusView.leadingAnchor,constant: 10),
            statustitel.widthAnchor.constraint(equalTo: statusView.widthAnchor, multiplier: 0.7),
            statustitel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor)
        ])
        
        statusView.addSubview(statusCoinView)
        statusCoinView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusCoinView.heightAnchor.constraint(equalTo: statusView.heightAnchor, multiplier: 0.44),
            statusCoinView.trailingAnchor.constraint(equalTo: statusView.trailingAnchor,constant: -10),
            statusCoinView.widthAnchor.constraint(equalTo: statusView.widthAnchor, multiplier: 0.21),
            statusCoinView.centerYAnchor.constraint(equalTo: statusView.centerYAnchor)
        ])
        
        statusCoinView.addSubview(statusCoinImage)
        statusCoinImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusCoinImage.leadingAnchor.constraint(equalTo: statusCoinView.leadingAnchor,constant: 3),
            statusCoinImage.widthAnchor.constraint(equalToConstant: 23),
            statusCoinImage.heightAnchor.constraint(equalToConstant: 23),
            statusCoinImage.centerYAnchor.constraint(equalTo: statusCoinView.centerYAnchor)
        ])
        
        statusCoinView.addSubview(statusUCcoins)
        statusUCcoins.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusUCcoins.leadingAnchor.constraint(equalTo: statusCoinImage.trailingAnchor,constant: 5),
            statusUCcoins.trailingAnchor.constraint(equalTo: statusCoinView.trailingAnchor,constant: -5),
            statusUCcoins.topAnchor.constraint(equalTo: statusCoinView.topAnchor),
            statusUCcoins.bottomAnchor.constraint(equalTo: statusCoinView.bottomAnchor),
        ])
    }
    
    func tabeViewConstraints() {
        self.view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: self.winRoaylePass.bottomAnchor,constant: 10),
            myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 8),
            myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -8),
            myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    @objc func winroyalPassCliked(){
        let alert2 = UIAlertController(title: Gtitel, message: message, preferredStyle: .alert)
        alert2.addAction(UIAlertAction(title: but1, style: .default, handler: { action in
            switch action.style{
            case .default:
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: self.link)!)
                } else {
                    UIApplication.shared.openURL(URL(string: self.link)!)
                }
                
            case .cancel:
                print("")
            case .destructive:
                print("")
            @unknown default:
                fatalError()
            }
        }))
        
        alert2.addAction(UIAlertAction(title: but2, style: .default, handler: { (action) in
            switch action.style{
            case .default:
                print("")
            case .cancel:
                print("")
            case .destructive:
                print("")
            @unknown default:
                fatalError()
            }
        }))
        present(alert2, animated: true, completion: nil)
    }
    
    
    lazy var statusView:UIView = {
        let vw = UIView()
        return vw
    }()
    
    let statusCoinView:UIView = {
        let vw = UIView()
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 13.5
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: vw.frame.size.width, height: vw.frame.size.height)
        
        vw.layer.insertSublayer(gradient, at: 0)
        vw.layer.borderWidth = 1
        vw.layer.borderColor = UIColor.systemOrange.cgColor
        return vw
    }()
    
    lazy var statustitel:UILabel = {
        let vw = UILabel()
        let St = NSMutableAttributedString(string:"Royal Pass Instant ♛")
        St.setColorForText("♛", with: UIColor.systemOrange)
        vw.attributedText = St
        vw.font =  UIFont (name: "Montserrat-Bold", size: 20)
        return vw
    }()
    
    lazy var statusUCcoins:UILabel = {
        let vw = UILabel()
        vw.text  = ""
        vw.textAlignment = .left
        vw.font =  UIFont (name: "Montserrat-Bold", size: 12)
        return vw
    }()
    
    lazy var statusCoinImage:UIImageView = {
        let vw = UIImageView()
        vw.image = #imageLiteral(resourceName: "UC")
        return vw
    }()
    
    
    lazy var myView:UITableView = {
        let vw = UITableView()
        vw.backgroundColor = .clear
        vw.separatorStyle = .none
        vw.showsVerticalScrollIndicator = false
        return vw
    }()
    
    lazy var winRoaylePass:UIImageView = {
        let vw = UIImageView()
        vw.image = #imageLiteral(resourceName: "Winroyal Pass")
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 10
        return vw
    }()
    
    let images:[UIImage] = [#imageLiteral(resourceName: "LUCKY SLOT"),#imageLiteral(resourceName: "LUCKY CARD.png"),#imageLiteral(resourceName: "REF FRIEND.png"),#imageLiteral(resourceName: "LUCKY SCRACH.png")]
}



extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= 3{
            let cell = Bundle.main.loadNibNamed("mainCell", owner: self, options: nil)?.first as! mainCell
            cell.imageToput.image = images[indexPath.row]
            cell.LockLabel.isHidden = true
            cell.selectionStyle = .none
            
            if  Date().timeIntervalSince1970 * 1000 < UserDefaults.standard.double(forKey: String(indexPath.row)) {
                cell.LockLabel.isHidden = false
                cell.isUserInteractionEnabled = false
                let minsLeft = (UserDefaults.standard.double(forKey: String(indexPath.row)) -  Date().timeIntervalSince1970*1000) / 60000
                cell.LockLabel.text = "🔒 LOCKED FOR NEXT \(String(format:"%.f",round(minsLeft))) Mins"
            }
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("FollowCell", owner: self, options: nil)?.first as! FollowCell
            cell.selectionStyle = .none
            if indexPath.row == 5 {
                cell.icon.image = #imageLiteral(resourceName: "instagram")
                cell.labl.text = "Follow Developer"
            }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row <= 3{
            return 150
        }else{
            return 73
        }
    }
    
}


extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
