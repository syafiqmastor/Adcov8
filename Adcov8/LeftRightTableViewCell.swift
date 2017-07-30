//
//  LeftRightTableViewCell.swift
//  Adcov8
//
//  Created by Syafiq Mastor on 7/30/17.
//  Copyright © 2017 syafiqmastor. All rights reserved.
//

import UIKit

class LeftRightTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
