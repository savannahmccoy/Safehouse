//
//  DirectionTableViewCell.swift
//  SafeHouse
//
//  Created by Savannah McCoy on 7/15/17.
//  Copyright © 2017 Savannah McCoy. All rights reserved.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {

    @IBOutlet weak var directionLabel: UILabel!
    
    var delegate = OnlineViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
