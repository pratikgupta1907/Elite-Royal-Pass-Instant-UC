//
//  mainCell.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 10/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class mainCell: UITableViewCell {
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var tasknum: UILabel!
    
    @IBOutlet weak var taskname: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageToput: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        line.backgroundColor = lineClr
        imageToput.clipsToBounds = true
        mainView.layer.cornerRadius = 10
        imageToput.layer.cornerRadius = 10
        imageToput.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        mainView.shadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
