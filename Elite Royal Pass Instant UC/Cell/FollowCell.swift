//
//  FollowCell.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 27/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class FollowCell: UITableViewCell {

    @IBOutlet weak var labl: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var innerView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 10
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor  = UIColor.systemOrange.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
