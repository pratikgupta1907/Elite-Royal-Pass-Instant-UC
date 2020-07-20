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
import Kingfisher
import GoogleMobileAds
import ImageSlideshow

let lineClr = #colorLiteral(red: 0.9002514354, green: 0.909164816, blue: 0.909164816, alpha: 1)

class ViewController: UIViewController{
    
    
    
    
    var Ad_Token = "0"
    
    var Gtitel = ""
    var message = ""
    var but1 = ""
    var but2 = ""
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stripeViewConstraints()
        statusConstraints()
        slideshowConstraint()
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
        if indexPath.row == 0 {
            
            //                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngineTwo") as! CardsEngineTwo
            //                newViewController.whatisThis = "Slot_Machine"
            //                navigationController?.pushViewController(newViewController, animated: true)
            
            //            }else if self.indexPath == 1 {
            //                whatis = "Lucky_Card"
            //                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngine") as! CardsEngine
            //                newViewController.whatisThis = whatis
            //                navigationController?.pushViewController(newViewController, animated: true)
            //            }else if self.indexPath == 2 {
            //                whatis = "Lucky_Envelope"  //Refer_Friend
            //                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "LuckyEnvelopeVC") as! LuckyEnvelopeVC
            //                navigationController?.pushViewController(newViewController, animated: true)
            //            }else if self.indexPath == 3 {
            //                whatis = "Scratch_Card"
            //                let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngine") as! CardsEngine
            //                newViewController.whatisThis = whatis
            //                navigationController?.pushViewController(newViewController, animated: true)
        }else if indexPath.row == 1 {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1514485237&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")!)
            } else {
                UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1514485237&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software")!)
            }
        }else if indexPath.row == 2 {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "https://www.instagram.com/thisis_saif/")!)
            } else {
                UIApplication.shared.openURL(URL(string: "https://www.instagram.com/thisis_saif/")!)
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController!.navigationBar.topItem!.title = "Royal Pass Instant ♛"
        let Parameters:Parameters = [
            "id": UserDefaults.standard.getid(),
            "WhatYouWant":"CoinsJSON"
        ]
        
        postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
            self.statusUCcoins.text = "¢" + (json["Coins"].string ?? "")
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
            
            self.slideshow.contentScaleMode = .scaleAspectFill
            self.slideshow.circular = true
            self.slideshow.slideshowInterval = 5
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = #colorLiteral(red: 0.3932482004, green: 0.3170551956, blue: 0.7376483083, alpha: 1)
            pageIndicator.pageIndicatorTintColor = UIColor.white
            self.slideshow.pageIndicator = pageIndicator
            self.slideshow.setImageInputs([
                KingfisherSource(urlString: json["Banner1"].string ?? "https://i.ya-webdesign.com/images/afro-transparent-png-2.png")!,
                KingfisherSource(urlString: json["Banner2"].string ?? "https://i.ya-webdesign.com/images/afro-transparent-png-2.png")!,
            ])
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
            self.slideshow.addGestureRecognizer(gestureRecognizer)
        }
        
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
        
        
    }
    
    @objc func didTap() {
        print(slideshow.currentPage)
    }
    
    
    
    func stripeViewConstraints() {
        self.view.addSubview(stripeView)
        stripeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stripeView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stripeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stripeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stripeView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.03)
        ])
        
        
        stripeView.addSubview(openHistory)
        openHistory.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openHistory.heightAnchor.constraint(equalTo: stripeView.heightAnchor, multiplier: 1),
            openHistory.trailingAnchor.constraint(equalTo: stripeView.trailingAnchor,constant: -10),
            openHistory.bottomAnchor.constraint(equalTo: stripeView.bottomAnchor)
        ])
        
    }
    
    func statusConstraints() {
        self.view.addSubview(statusView)
        statusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: self.stripeView.bottomAnchor),
            statusView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            statusView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05)
        ])
        
        statusView.addSubview(statustitel)
        statustitel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statustitel.heightAnchor.constraint(equalTo: statusView.heightAnchor, multiplier: 1),
            statustitel.leadingAnchor.constraint(equalTo: statusView.leadingAnchor,constant: 10),
            statustitel.widthAnchor.constraint(equalTo: statusView.widthAnchor, multiplier: 0.8),
            statustitel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor)
        ])
        
        
        statusView.addSubview(statusUCcoins)
        statusUCcoins.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusUCcoins.trailingAnchor.constraint(equalTo: statusView.trailingAnchor,constant: -10),
            statusUCcoins.widthAnchor.constraint(equalTo: statusView.widthAnchor, multiplier: 0.5),
            statusUCcoins.centerYAnchor.constraint(equalTo: statusView.centerYAnchor,constant: -5)
        ])
    }
    
    
    func slideshowConstraint() {
        
        self.view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: self.statusView.bottomAnchor,constant: 0),
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            line.heightAnchor.constraint(equalToConstant: 0.8)
        ])
        
        self.view.addSubview(slideshow)
        slideshow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slideshow.topAnchor.constraint(equalTo: self.line.bottomAnchor,constant: 10),
            slideshow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 8),
            slideshow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -8),
            slideshow.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.25)
        ])
        
        
    }
    
    
    func tabeViewConstraints() {
        self.view.addSubview(line2)
        line2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line2.topAnchor.constraint(equalTo: self.slideshow.bottomAnchor,constant: 10),
            line2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            line2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            line2.heightAnchor.constraint(equalToConstant: 0.8)
        ])
        
        self.view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: self.line2.bottomAnchor,constant: 10),
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
    
    lazy var statustitel:UILabel = {
        let vw = UILabel()
        let St = NSMutableAttributedString(string:"RP Instant ♛")
        vw.attributedText = St
        vw.clipsToBounds = true
        vw.minimumScaleFactor = 0.25
        vw.font =  UIFont (name: "ArialHebrew-Bold", size: 25) //"Montserrat-Bold"
        return vw
    }()
    
    lazy var statusUCcoins:UILabel = {
        let vw = UILabel()
        vw.text  = ""
        vw.textAlignment = .right
        vw.clipsToBounds = true
        vw.minimumScaleFactor = 0.25
        vw.font =  UIFont (name: "Montserrat-Bold", size: 25)
        return vw
    }()
    
    lazy var myView:UITableView = {
        let vw = UITableView()
        vw.backgroundColor = .clear
        vw.separatorStyle = .none
        vw.showsVerticalScrollIndicator = false
        return vw
    }()
    
    
    lazy var slideshow:ImageSlideshow = {
        let slideshow = ImageSlideshow()
        return slideshow
    }()
    
    
    lazy var stripeView:UIView = {
        let vw = UIView()
        return vw
    }()
    
    lazy var openHistory:UIButton = {
        let vw = UIButton()
        vw.titleLabel?.textAlignment = .left
        vw.setTitleColor(UIColor.systemRed, for: .normal)
        vw.titleLabel?.font = UIFont.init(name: "ArialHebrew-Bold", size: 13)
        vw.setTitle("Open history", for: .normal)
        return vw
    }()
    
    
    lazy var line:UIView = {
        let vw = UIView()
        vw.backgroundColor = lineClr
        return vw
    }()
    
    lazy var line2:UIView = {
        let vw = UIView()
        vw.backgroundColor = lineClr
        return vw
    }()
    
    
    
    let task = ["Slot_Machine","Lucky_Card","Lucky_Envelope","Scratch_Card"]
    let taskName = ["Slot Machine","Lucky Card","Lucky Envelope","Scratch Card"]
    let taskNum = ["First Task","Second Task","Third Task","Fourth Task"]
    var currentTask = 0
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = Bundle.main.loadNibNamed("mainCell", owner: self, options: nil)?.first as! mainCell
            cell.imageToput.image = #imageLiteral(resourceName: "gradiance")
            cell.startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
            cell.selectionStyle = .none
            
            for i in 0...3 {
                if  Date().timeIntervalSince1970 * 1000 > UserDefaults.standard.double(forKey: String(i)) {
                    cell.tasknum.text = taskNum[i]
                    cell.taskname.text = taskName[i]
                    currentTask = i
                    cell.startButton.isHidden = false
                    break;
                }else{
                    
                    let minsLeftT1 = (UserDefaults.standard.double(forKey: String(0)) -  Date().timeIntervalSince1970*1000) / 60000
                    let minsLeftT2 = (UserDefaults.standard.double(forKey: String(1)) -  Date().timeIntervalSince1970*1000) / 60000
                    let minsLeftT3 = (UserDefaults.standard.double(forKey: String(2)) -  Date().timeIntervalSince1970*1000) / 60000
                    let minsLeftT4 = (UserDefaults.standard.double(forKey: String(3)) -  Date().timeIntervalSince1970*1000) / 60000
                    
                    let allTimes = [minsLeftT1,minsLeftT2,minsLeftT3,minsLeftT4]
                    print(allTimes.min()!)
                    
                    cell.tasknum.text = "No Task :("
                    cell.taskname.text = "Wait : \(String(describing: round(allTimes.min()!)))" + " mins"
                    cell.startButton.isHidden = true
                    
                    
                }
                
            }
            
            
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("FollowCell", owner: self, options: nil)?.first as! FollowCell
            cell.selectionStyle = .none
            if indexPath.row == 2 {
                cell.icon.image = #imageLiteral(resourceName: "instagram")
                cell.button.setTitle("Follow", for: .normal)
                cell.labl.text = "Follow Developer"
                cell.des.text = "Give your feedback to developer"
            }
            return cell
        }
    }
    
    @objc func startTapped(){
        print(currentTask)
        if Int(Ad_Token)! != 0 {
            let currentTimeInMiliseconds = Date().timeIntervalSince1970 * 1000
            UserDefaults.standard.set(currentTimeInMiliseconds+1800000, forKey: String(currentTask))
            
            if Int(Ad_Token)! != 0 {
                if currentTask == 0 {
                    let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngineTwo") as! CardsEngineTwo
                    newViewController.whatisThis = task[currentTask]
                    navigationController?.pushViewController(newViewController, animated: true)
                }else if currentTask == 1 {
                    let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngine") as! CardsEngine
                    newViewController.whatisThis = task[currentTask]
                    navigationController?.pushViewController(newViewController, animated: true)
                }else if currentTask == 2 {
                    let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "LuckyEnvelopeVC") as! LuckyEnvelopeVC
                    navigationController?.pushViewController(newViewController, animated: true)
                }else if currentTask == 3 {
                    let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "CardsEngine") as! CardsEngine
                    newViewController.whatisThis = task[currentTask]
                    navigationController?.pushViewController(newViewController, animated: true)
                }
            }else{
                self.present(myAlt(titel:"Ad Tokens Required",message:"You Don't Have Enough Ad Tokens.Please Watch Ad or Wait For One Day."), animated: true, completion: nil)
            }
            
            
            
            
            
        }else{
            self.present(myAlt(titel:"Ad Tokens Required",message:"You Don't Have Enough Ad Tokens.Please Watch Ad or Wait For One Day."), animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        }else{
            return 63
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

extension UIView {
    
    var heightConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
}

extension UIView {
    
    func shadow()  {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}
