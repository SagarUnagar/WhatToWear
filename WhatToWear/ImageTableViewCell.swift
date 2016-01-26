//
//  ImageTableViewCell.swift
//  WhatToWear
//
//  Created by Sagar Unagar on 26/01/16.
//  Copyright © 2016 Sagar Unagar. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet var btnShare:UIButton!
    @IBOutlet var btnBookmark:UIButton!
    @IBOutlet var imgImage:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
