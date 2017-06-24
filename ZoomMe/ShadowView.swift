//
//  ShadowView.swift
//  ZoomMe
//
//  Created by Evan on 6/17/17.
//  Copyright © 2017 Evan Laird. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
