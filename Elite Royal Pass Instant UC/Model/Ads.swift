//
//  Ads.swift
//  List View 2
//
//  Created by Junaid Mukadam on 19/10/19.
//  Copyright © 2019 Junaid Mukadam. All rights reserved.
//

import Foundation
import GoogleMobileAds
import UIKit

//let testIntrest = "ca-app-pub-3940256099942544/1033173712"      //Test
let testIntrest = "ca-app-pub-2710347124980493/6481979535"    //Mine

//let videoads = "ca-app-pub-3940256099942544/5224354917" // Test
let videoads = "ca-app-pub-2710347124980493/6344386342" // Main


public var interstitial: GADInterstitial!
func LoadIntrest() {
    interstitial = GADInterstitial(adUnitID: testIntrest)
    let request = GADRequest()
    interstitial.load(request)
}

func ShowAd(selfo:UIViewController,showAdafterSecound:Double){
    DispatchQueue.main.asyncAfter(deadline: .now() + showAdafterSecound) {
    if interstitial.isReady {
        interstitial.present(fromRootViewController: selfo)
        LoadIntrest()
    } else {
        print("Ad wasn't ready")
        LoadIntrest()
    }
  }
}

