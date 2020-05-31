//
//  LuckyEnvelopeVC.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 18/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LuckyEnvelopeVC: UIViewController {
    
    @IBOutlet weak var outerCard: UIView!
    
    @IBOutlet weak var imageLook: UIImageView!
    @IBOutlet weak var UClbel: UILabel!
    
    @IBOutlet weak var addtoWallet: UIButton!
    @IBOutlet weak var reward: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        addtoWallet.layer.cornerRadius = 10
        
        outerCard.layer.cornerRadius = 13
        outerCard.layer.borderWidth = 3
        outerCard.layer.borderColor = UIColor.systemOrange.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.UClbel.isHidden = false
            self.imageLook.image = #imageLiteral(resourceName: "OpenEnvo.png")
            self.addtoWallet.isHidden = false
            self.reward.isHidden = false
        }
        
        
        let pm:Parameters = [
            "id":UserDefaults.standard.getid(),
            "TaskName":"Lucky_Envelope"
        ]
        
        postWithParameter(Url: "TasksEngine.php", parameters: pm) { (JSON, Error) in
            let floatinString =  String(JSON["reward"].float ?? 0.00) + " UC"
            self.UClbel.text = floatinString
        }
        
    }
    
    @IBAction func addTowallet(_ sender: Any) {
        addtoWallet.isHidden = true
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        self.navigationItem.hidesBackButton = false
        ShowAd(selfo: self, showAdafterSecound: 0)
    }
    
}
