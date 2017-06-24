//
//  RoundImage.swift
//  ZoomMe
//
//  Created by Evan on 6/17/17.
//  Copyright © 2017 Evan Laird. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }

}
