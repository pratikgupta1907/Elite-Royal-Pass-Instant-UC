//
//  GoogleLogin.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 12/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import SwiftyJSON
import Alamofire
import GoogleMobileAds

class GoogleLogin: UIViewController,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    
    var window: UIWindow?
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @IBOutlet weak var giftImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appleLogin = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        appleLogin.cornerRadius = 15
        
        let googleButton = UIButton()
        googleButton.setTitle(" Sign in with Google", for: .normal)
        googleButton.setImage(#imageLiteral(resourceName: "google.png"), for: .normal)
        googleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        googleButton.setTitleColor(UIColor.black, for: .normal)
        googleButton.layer.borderColor = UIColor.black.cgColor
        googleButton.layer.borderWidth = 0.5
        googleButton.layer.cornerRadius = 20
        googleButton.addTarget(self, action: #selector(googlePressed), for: .touchUpInside)
        
        
        GIDSignIn.sharedInstance().presentingViewController = self
        appleLogin.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        self.view.addSubview(appleLogin)
        appleLogin.translatesAutoresizingMaskIntoConstraints  = false
        NSLayoutConstraint.activate([
            appleLogin.topAnchor.constraint(equalTo: self.giftImageView.bottomAnchor, constant: 10),
            appleLogin.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            appleLogin.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            appleLogin.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06)
        ])
        
        self.view.addSubview(googleButton)
        googleButton.translatesAutoresizingMaskIntoConstraints  = false
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: appleLogin.bottomAnchor, constant: 20),
            googleButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalTo: appleLogin.heightAnchor, multiplier: 1) //0.065
        ])
        
    }
    
    @objc func googlePressed(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName:String = (appleIDCredential.fullName?.givenName ?? "givenName") + " " +  (appleIDCredential.fullName?.familyName  ?? "familyName")
            let email:String = appleIDCredential.email ?? "null"
            
            
            let Parameters:Parameters = [
                "id":userIdentifier,
                "Name":fullName ,
                "Email":email ,
                "Profile_URL":"null",
                "Token":userIdentifier+userIdentifier+userIdentifier,
                "Referred": "00",
            ]
            
            //print(Parameters)
            postWithParameter(Url: "Profilepost.php", parameters: Parameters) { (json, err) in
                
                if json["code"].string ?? "null" == "007" ||  json["message"].string?.contains("Duplicate entry") ?? false {
                    
                    UserDefaults.standard.setLoggedIn(value: true)
                    UserDefaults.standard.setid(value: userIdentifier)
                    UserDefaults.standard.setUsername(value: fullName)
                    UserDefaults.standard.setUserEmail(value: email)
                    UserDefaults.standard.setUserUserProfilePic(value: "null")
                    UserDefaults.standard.setReferralCode(value: json["RfCode"].string ?? "null")
                    
                    DispatchQueue.main.async {
                        let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = MainStoryboard.instantiateViewController(withIdentifier: "RootNavigationController") as! UINavigationController
                        newViewController.modalPresentationStyle = .fullScreen
                        self.present(newViewController, animated: true, completion: nil)
                    }
                }
            }
        default:
            break
        }
    }
    
    
}
