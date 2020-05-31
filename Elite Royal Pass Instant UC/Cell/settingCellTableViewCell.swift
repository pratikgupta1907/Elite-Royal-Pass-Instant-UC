//
//  settingCellTableViewCell.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 14/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class settingCellTableViewCell: UITableViewCell {

    @IBOutlet weak var labl: UILabel!
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var buttonCliked: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellview.clipsToBounds = true
        img.clipsToBounds = true
       
        //img.layer.borderWidth = 1
      //  img.layer.cornerRadius = 10
      //  img.layer.borderColor = UIColor.white.cgColor
        
        cellview.layer.borderWidth = 1
        cellview.layer.cornerRadius = 15
        cellview.layer.borderColor = UIColor.systemOrange.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
