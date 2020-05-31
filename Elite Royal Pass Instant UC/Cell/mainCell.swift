//
//  mainCell.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 10/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class mainCell: UITableViewCell {

    @IBOutlet weak var LockLabel: UILabel!
    @IBOutlet weak var imageToput: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageToput.clipsToBounds = true
        imageToput.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
