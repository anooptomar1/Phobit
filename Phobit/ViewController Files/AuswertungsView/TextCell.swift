//
//  TextCell.swift
//  Phobit
//
//  Created by LonoS on 21.12.17.
//  Copyright © 2017 LonoS. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    
    @IBOutlet weak var textField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
