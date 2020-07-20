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
    
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        line.backgroundColor = lineClr
        innerView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
