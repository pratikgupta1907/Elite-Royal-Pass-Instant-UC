//
//  articlesVC.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 04/07/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Alamofire
import AppLovinSDK
import SwiftyJSON
import FBAudienceNetwork
import GoogleMobileAds
import Kingfisher
import AdColony

class ArticlesVC: UIViewController,UITableViewDelegate,UITableViewDataSource,FBRewardedVideoAdDelegate {
    
    @IBOutlet weak var Banner: GADBannerView!
    
    @IBOutlet weak var myView: UITableView!
    
    //////////////////////// ALL ADs /////////////////
    var rewardedVideoAd: FBRewardedVideoAd? = nil
    var incentivizedInterstitial: ALIncentivizedInterstitialAd?
    weak var interstitial:AdColonyInterstitial?
    
    
    
    
    //////////////////////// Facebook /////////////////
    
    
    func loadRewardedVideoAd() {
        rewardedVideoAd = FBRewardedVideoAd(placementID: "709116646536627_739621373486154")
        rewardedVideoAd!.delegate = self
        rewardedVideoAd!.load()
    }
    
    func rewardedVideoAdDidLoad(_ rewardedVideoAd: FBRewardedVideoAd) {
        print("Video ad is loaded and ready to be displayed")
        self.alert.dismiss(animated: true) {
            if rewardedVideoAd.isAdValid {
                rewardedVideoAd.show(fromRootViewController: self)
            }
        }
    }
    
    func rewardedVideoAd(_ rewardedVideoAd: FBRewardedVideoAd, didFailWithError error: Error) {
        print("Video failed",error)
        self.alert.dismiss(animated: true,completion: nil)
    }
    
    func rewardedVideoAdVideoComplete(_ rewardedVideoAd: FBRewardedVideoAd) {
        let Parameters:Parameters = [
            "id": UserDefaults.standard.getid(),
            "WhatYouWant":"Ad_Token_Remove"
        ]
        postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
            let message = json["message"].string ?? "Token Added"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.present(myAlt(titel:"Alert",message: message), animated: true, completion: nil)
            })
        }
    }
    //////////////////////// Facebook End/////////////////
    
    let alert = UIAlertController(title: nil, message: "Loading Ad ...", preferredStyle: .alert)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article", for: indexPath) as! article
        cell.articlelabel.text = "Watch Ad Server " + String(indexPath.row+1)
        cell.watchAD.tag = indexPath.row
        cell.watchAD.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        
        if indexPath.row == 3 {
            cell.watchAD.isHidden = true
            cell.articlelabel.text = "If you can't watch Ad even after trying all the Servers it's time to take a BREAK."
            cell.articlelabel.textAlignment = .center
        }
        
        return cell
    }
    
    @objc func tapped(sender:UIButton){
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        let tag = sender.tag
        
        if tag == 0 {
            loadRewardedVideoAd() //facebook
        }else if tag == 1 {
            loadRewardedAd() //AdLovin
        }else if tag == 2 {
            requestInterstitialAdColony() //AdColony
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Earn Token"
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
        Banner.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.size.width)
        Banner.adUnitID = "ca-app-pub-2710347124980493/2253995881"
        Banner.rootViewController = self
        Banner.load(GADRequest())
    }
}

//////////////////////// AdLovin /////////////////
extension ArticlesVC: ALAdRewardDelegate,ALAdLoadDelegate {
    func adService(_ adService: ALAdService, didLoad ad: ALAd) {
        print("Video ad is loaded and ready to be displayed")
        self.alert.dismiss(animated: true) {
            if self.incentivizedInterstitial!.isReadyForDisplay
            {
                self.incentivizedInterstitial!.showAndNotify(self)
            }
        }
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        print(code)
        self.alert.dismiss(animated: true,completion: nil)
    }
    
    
    
    func rewardValidationRequest(for ad: ALAd, didSucceedWithResponse response: [AnyHashable : Any]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            let Parameters:Parameters = [
                "id": UserDefaults.standard.getid(),
                "WhatYouWant":"Ad_Token_Remove"
            ]
            postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
                let message = json["message"].string ?? "Token Added"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.present(myAlt(titel:"Alert",message: message), animated: true, completion: nil)
                })
            }
        }
    }
    
    func rewardValidationRequest(for ad: ALAd, didExceedQuotaWithResponse response: [AnyHashable : Any]) {
        print(response)
        self.alert.dismiss(animated: true,completion: nil)
    }
    
    func rewardValidationRequest(for ad: ALAd, wasRejectedWithResponse response: [AnyHashable : Any]) {
        print(response)
        self.alert.dismiss(animated: true,completion: nil)
    }
    
    func rewardValidationRequest(for ad: ALAd, didFailWithError responseCode: Int) {
        print(responseCode)
        self.alert.dismiss(animated: true,completion: nil)
    }
    
    func loadRewardedAd()
    {
        incentivizedInterstitial = ALIncentivizedInterstitialAd(zoneIdentifier: "dcec1ee81fee1bbc")
        incentivizedInterstitial!.preloadAndNotify(self)
    }
    
}

//////////////////////// AdLovin End /////////////////


//////////////////////// AdColony  /////////////////

extension ArticlesVC:AdColonyInterstitialDelegate {
    func adColonyInterstitialDidLoad(_ interstitial: AdColonyInterstitial) {
        self.interstitial = interstitial
        self.alert.dismiss(animated: true) {
            if  !interstitial.expired {
                interstitial.show(withPresenting: self)
            }
        }
    }
    func adColonyInterstitialDidFail(toLoad error: AdColonyAdRequestError) {
        print("Interstitial request failed with error: \(error.localizedDescription) and suggestion: \(error.localizedRecoverySuggestion!)")
        self.alert.dismiss(animated: true, completion: nil)
    }
    
    func adColonyInterstitialDidClose(_ interstitial: AdColonyInterstitial) {
            print("Interstitial did close")
            let Parameters:Parameters = [
                "id": UserDefaults.standard.getid(),
                "WhatYouWant":"Ad_Token_Remove"
            ]
            postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
                let message = json["message"].string ?? "Token Added"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.present(myAlt(titel:"Alert",message: message), animated: true, completion: nil)
            })
        }
    }
    
    
    func requestInterstitialAdColony() {
        AdColony.requestInterstitial(inZone: "vzc6286ae7bdc84439a8", options: nil, andDelegate: self)
    }
    
    
}
//////////////////////// AdColony  End/////////////////
