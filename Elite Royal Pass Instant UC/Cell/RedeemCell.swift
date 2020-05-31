//
//  RedeemCell.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 19/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class RedeemCell: UITableViewCell {

    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var Redeem: UILabel!
    
    @IBOutlet weak var RedeemButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellview.layer.borderWidth = 1
               cellview.layer.cornerRadius = 15
               cellview.layer.borderColor = UIColor.systemOrange.cgColor
        
        RedeemButton.clipsToBounds = true
        RedeemButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
