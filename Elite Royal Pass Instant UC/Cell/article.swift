//
//  article.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 04/07/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class article: UITableViewCell {
    
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var articlelabel: UILabel!
    @IBOutlet weak var watchAD: UIButton!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellview.layer.borderWidth = 1
        cellview.layer.cornerRadius = 10
        cellview.layer.borderColor = UIColor.systemOrange.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
