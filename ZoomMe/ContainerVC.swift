//
//  ContainerVC.swift
//  ZoomMe
//
//  Created by Evan on 6/17/17.
//  Copyright © 2017 Evan Laird. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum ShowWhichVC {
    case homeVC
}

var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {
    
    var homeVC: HomeVC!
    var leftVC: LeftPanelVC!
    
    var centerController: UIViewController!
    
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadowLet = (currentState != .collapsed)
            
            shouldShowShadow(status: shouldShowShadowLet)
        }
    }
    var isHidden = false
    let centerPanelOffset: CGFloat = 180
    
    var tap: UITapGestureRecognizer!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initCenter(screen: showVC)
    }
    
    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController
        
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        
        presentingController = homeVC
        
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
        
        
        
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }

}

extension ContainerVC: CenterVCDelegate {
    func toggleLeftPanel() {
        let notExpanded = (currentState != .leftPanelExpanded)
        
        if notExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC)
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelController: LeftPanelVC) {
        
        view.insertSubview(sidePanelController.view, at: 0)
        addChildSidePanelViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
        
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateMenuBar()
            
            setupCoverView()
            
            currentState = .leftPanelExpanded
            
            animateCenterPanelX(targetPosition: centerController.view.frame.width - centerPanelOffset)
            
        } else {
            isHidden = !isHidden
            
            hideCoverView()
            
            animateCenterPanelX(targetPosition: 0, completion: { (finished) in
                if finished {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
        }
    }
    
    func animateCenterPanelX(targetPosition: CGFloat, completion: ((Bool)-> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: { 
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func animateMenuBar() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: { 
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    func setupCoverView() {
        let coverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        coverView.alpha = 0.0
        coverView.backgroundColor = UIColor.darkGray
        coverView.tag = 24
        
        self.view.addSubview(coverView)
        UIView.animate(withDuration: 0.2) { 
            coverView.alpha = 0.75
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
        
    }
    
    func hideCoverView() {
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews {
            if subview.tag == 24 {
                UIView.animate(withDuration: 0.2, animations: { 
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    func shouldShowShadow(status: Bool) {
        if status == true {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftPanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftPanelVC") as? LeftPanelVC
    }
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}
