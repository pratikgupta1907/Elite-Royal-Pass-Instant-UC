//
//  RedeemVC.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 19/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit
import StoreKit

class RedeemVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var webViewPolicy: WKWebView!
    
    var whatisMe = "Reedem"
    var UCarray = [String]()
    var SelectedUC = "8"
    var PUBGID = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UCarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedeemCell", for: indexPath) as! RedeemCell
        cell.Redeem.text = "💵 " + UCarray[indexPath.row] + " UC"
        cell.RedeemButton.tag = indexPath.row
        cell.RedeemButton.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return cell
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        PUBGID = textField.text!
    }
    
    @objc func clicked(sender:UIButton) {
        SelectedUC = UCarray[sender.tag]
        
        let alert = UIAlertController(title: "Please Enter PUBID", message: "Please enter PUBGID and press Submit", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "PUBG ID"
            textField.keyboardType = .numberPad
            textField.delegate  = self
        })
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                if self.PUBGID.count > 6 {
                    
                    let Parameters:Parameters = [
                        "id":UserDefaults.standard.getid(),
                        "PUBG_ID":self.PUBGID,
                        "UC":self.SelectedUC
                    ]
                    
                    postWithParameter(Url: "RedeemUC.php", parameters: Parameters) { (json, err) in
                        if  err == nil {
                            
                            self.present(myAlt(titel:"Alert",message:json["message"].string ?? ""), animated: true, completion: nil)
                            
                            if json["message"].string?.contains("Congratulations") ?? false{
                                SKStoreReviewController.requestReview()
                            }
                            
                            
                        }
                    }
                    
                } else {
                    
                    self.present(myAlt(titel:"Alert",message:"PUBGID must be more than 6 digit."), animated: true, completion: nil)
                    
                }
                
            case .cancel:
                print("")
            case .destructive:
                print("")
            @unknown default:
                fatalError()
            }}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("")
            case .cancel:
                print("")
            case .destructive:
                print("")
            @unknown default:
                fatalError()
            }}))
        
        self.present(alert, animated: true, completion:  nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
    @IBOutlet weak var myView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ShowAd(selfo: self, showAdafterSecound: 0)
        
        let Parameters:Parameters = [
            "id": UserDefaults.standard.getid(),
            "WhatYouWant":"RedeemAmount"
        ]
        postWithParameter(Url: "GetCoinInfo.php", parameters: Parameters) { (json, err) in
            if  err == nil {
                // self.UCarray = [json["code"].string!]
                for i in json["amount"] {
                    self.UCarray.append(i.1.stringValue)
                }
                
                self.myView.delegate = self
                self.myView.dataSource = self
                self.myView.reloadData()
            }
        }
        
        if whatisMe == "Reedem" {
            webViewPolicy.isHidden = true
        }else{
            myView.isHidden = true
            let localfilePath = Bundle.main.url(forResource: "privacy", withExtension: "html");
            let myRequest = NSURLRequest(url: localfilePath!);
            webViewPolicy.load(myRequest as URLRequest);
            
        }
    }
}

