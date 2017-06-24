//
//  RoundShadowButton.swift
//  ZoomMe
//
//  Created by Evan on 6/17/17.
//  Copyright © 2017 Evan Laird. All rights reserved.
//

import UIKit

class RoundShadowButton: UIButton {
    
    var orgSize: CGRect?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        orgSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.3
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String?) {
        
        let spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor.lightGray
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 123
        
        if shouldLoad {
            
            self.addSubview(spinner)
            
            self.setTitle("", for: .normal)
            
            UIView.animate(withDuration: 0.3, animations: { 
                self.layer.cornerRadius = self.frame.height/2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height/2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: {(finished) in
                spinner.center = CGPoint(x: self.frame.width/2 + 2, y: self.frame.width/2 + 2)
                if finished == true {
                    spinner.startAnimating()
                    UIView.animate(withDuration: 0.3, animations: { 
                        spinner.alpha = 1.0
                        
                    })
                }
                
            })
            self.isUserInteractionEnabled = false
        } else {
            self.isUserInteractionEnabled = true
            for subview in self.subviews {
                if subview.tag == 123 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.3, animations: { 
                self.layer.cornerRadius = 5.0
                self.layer.frame = self.orgSize!
                self.setTitle(message, for: .normal)
            })
        }
        
        

    }
}







