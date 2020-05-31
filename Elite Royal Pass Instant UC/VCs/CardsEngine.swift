//
//  CardsEngine.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 15/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SRScratchView


class CardsEngine: UIViewController,SRScratchViewDelegate{
    func scratchCardEraseProgress(eraseProgress: Float) {
        if eraseProgress > 40 {
            scratcher.isHidden = true
            self.Reward.isHidden = false
            self.label.isHidden = false
            self.addTowallet.isHidden = false
            
        }
    }
    
    @IBOutlet weak var giftTumbnail: UIImageView!
    @IBOutlet weak var Reward: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var outerCard: UIView!
    @IBOutlet weak var addTowallet: UIButton!
    var whatisThis = ""
    
    //hide in lucky card
    @IBOutlet weak var coupnsBackground: UIImageView!
    @IBOutlet weak var scratcher: SRScratchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        outerCard.layer.cornerRadius = 13
        outerCard.layer.borderWidth = 3
        outerCard.layer.borderColor = UIColor.systemOrange.cgColor
        addTowallet.layer.cornerRadius = 10
        
        if whatisThis == "Lucky_Card"{
            coupnsBackground.isHidden = true
            scratcher.isHidden = true
            
        }else if whatisThis == "Scratch_Card"{
            scratcher.delegate = self
            coupnsBackground.image = #imageLiteral(resourceName: "Scratchbackground")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.whatisThis == "Lucky_Card"{
                self.giftTumbnail.isHidden = true
                self.Reward.isHidden = false
                self.label.isHidden = false
                self.addTowallet.isHidden = false
                self.coupnsBackground.isHidden = false
            }
        }
        
        let pm:Parameters = [
            "id":UserDefaults.standard.getid(),
            "TaskName":whatisThis
        ]
        
        postWithParameter(Url: "TasksEngine.php", parameters: pm) { (JSON, Error) in
            self.label.text =  String(JSON["reward"].float ?? 0.0) + " UC"
        }
        
        if whatisThis == "Lucky_Card"{
            self.label.isHidden = true
            scratcher.isHidden = true
            giftTumbnail.isHidden = false
            
        }else if whatisThis == "Scratch_Card"{
            coupnsBackground.image = #imageLiteral(resourceName: "Scratchbackground")
            scratcher.delegate = self
        }
    }
    
    @IBAction func walletTap(_ sender: Any) {
        addTowallet.isHidden = true
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        self.navigationItem.hidesBackButton = false
        ShowAd(selfo: self, showAdafterSecound: 0)
    }
    
}
