//
//  CenterVCDelegate.swift
//  ZoomMe
//
//  Created by Evan on 6/17/17.
//  Copyright © 2017 Evan Laird. All rights reserved.
//

import Foundation
import UIKit

protocol  CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
    
}
