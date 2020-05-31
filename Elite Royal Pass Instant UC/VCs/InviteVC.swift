//
//  InviteVC.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 11/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMobileAds

class InviteVC: UIViewController,GADRewardedAdDelegate{
    @IBOutlet weak var ban: GADBannerView!
    
    
    var rewardedAd: GADRewardedAd?
    let alert = UIAlertController(title: nil, message: "Loading Ad ...", preferredStyle: .alert)
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        let Parameters:Parameters = [
            "id": UserDefaults.standard.getid(),
            "WhatYouWant":"Ad_Token_Remove"
        ]
        postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.present(myAlt(titel:"AdToken Added",message:"One Token added in your account."), animated: true, completion: nil)
        })
        
        self.rewardedAd = self.createAndLoadRewardedAd()
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
         self.alert.dismiss(animated: true, completion: nil)
    }
    
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.rewardedAd = createAndLoadRewardedAd()
    }
    
    
    func createAndLoadRewardedAd() -> GADRewardedAd {
        
        rewardedAd = GADRewardedAd(adUnitID: videoads) //ca-app-pub-2710347124980493/6344386342 //ca-app-pub-3940256099942544/5224354917
        rewardedAd?.load(GADRequest()) { error in
            self.alert.dismiss(animated: true, completion: nil)
        }
        return rewardedAd!
    }
    
    @IBOutlet weak var watchAd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusConstraints()
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        self.rewardedAd = createAndLoadRewardedAd()
        
        ban.adUnitID = "ca-app-pub-2710347124980493/2253995881"
        ban.rootViewController = self
        ban.load(GADRequest())
    }
    
    @IBAction func watchAD(_ sender: Any) {
        if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let Parameters:Parameters = [
            "id": UserDefaults.standard.getid(),
            "WhatYouWant":"CoinsJSON"
        ]
        postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
            
            self.statusUCcoins.text = json["Ad_Token"].string ?? ""
            
        }
        watchAd.clipsToBounds = true
        watchAd.layer.cornerRadius = 10
        
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
            statusCoinImage.leadingAnchor.constraint(equalTo: statusCoinView.leadingAnchor,constant: 6),
            statusCoinImage.widthAnchor.constraint(equalToConstant: 20),
            statusCoinImage.heightAnchor.constraint(equalToConstant: 20),
            statusCoinImage.centerYAnchor.constraint(equalTo: statusCoinView.centerYAnchor)
        ])
        
        statusCoinView.addSubview(statusUCcoins)
        statusUCcoins.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusUCcoins.leadingAnchor.constraint(equalTo: statusCoinImage.trailingAnchor,constant: 8),
            statusUCcoins.trailingAnchor.constraint(equalTo: statusCoinView.trailingAnchor,constant: -5),
            statusUCcoins.topAnchor.constraint(equalTo: statusCoinView.topAnchor),
            statusUCcoins.bottomAnchor.constraint(equalTo: statusCoinView.bottomAnchor),
        ])
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
        vw.layer.borderColor = UIColor.systemGreen.cgColor
        return vw
    }()
    
    lazy var statustitel:UILabel = {
        let vw = UILabel()
        let St = NSMutableAttributedString(string:"Watch & Earn Ad Tokens 📺")
        
        vw.attributedText = St
        vw.font =  UIFont (name: "Montserrat-Bold", size: 17)
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
        vw.image = #imageLiteral(resourceName: "wallet")
        return vw
    }()
    
}
