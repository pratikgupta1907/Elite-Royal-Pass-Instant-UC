//
//  AppDelegate.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 09/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SwiftyJSON
import Alamofire
import GoogleMobileAds
import AppLovinSDK
import Siren
import AdColony

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    var window: UIWindow?
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            
            let userId = user.userID ?? "000"
            let idToken = user.authentication.idToken ?? "null"
            let fullName = user.profile.name ?? "null"
            let email = user.profile.email ?? "null"
            let profileID = user.profile.imageURL(withDimension: 100)?.absoluteString
            
            let Parameters:Parameters = [
                "id":userId,
                "Name":fullName,
                "Email":email,
                "Profile_URL":profileID ?? "null",
                "Token":idToken,
                "Referred":"00"
            ]
            
            postWithParameter(Url: "Profilepost.php", parameters: Parameters) { (json, err) in
                
                if json["code"].string ?? "null" == "007" ||  json["message"].string?.contains("Duplicate entry") ?? false {
                    
                    UserDefaults.standard.setLoggedIn(value: true)
                    UserDefaults.standard.setid(value: userId)
                    UserDefaults.standard.setUsername(value: fullName)
                    UserDefaults.standard.setUserEmail(value: email)
                    UserDefaults.standard.setUserUserProfilePic(value: profileID ?? "null")
                    UserDefaults.standard.setReferralCode(value: json["RfCode"].string ?? "null")
                    
                    let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = MainStoryboard.instantiateViewController(withIdentifier: "RootNavigationController") as? UINavigationController
                    self.window?.rootViewController = controller
                }
            }
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = "959079939873-cbkcfmfkdus66dgtead2lghj5dq8pfsm.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self //If AppDelegate conforms to GIDSignInDelegate
        
        if UserDefaults.standard.isLoggedIn(){
            
            let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = MainStoryboard.instantiateViewController(withIdentifier: "RootNavigationController") as? UINavigationController
            self.window?.rootViewController = controller
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        LoadIntrest()
        
        ALSdk.initializeSdk()
        
        AdColony.configure(withAppID: "app5f7f3980d2224d8095", zoneIDs: ["vzc6286ae7bdc84439a8"], options: nil) { [weak self] (zones) in
            // configured
        }
        
        
        let siren = Siren.shared
        let rules = Rules(promptFrequency: .immediately, forAlertType: .force)
        siren.rulesManager = RulesManager(globalRules: rules)
        siren.wail()

        
        return true
    }
}
