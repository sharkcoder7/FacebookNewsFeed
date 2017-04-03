//
//  AlertExtension.swift
//  Swift Structure
//
//  Created by ioshero on 16/08/16.
//  Copyright © 2016 ioshero. All rights reserved.
//

import Foundation
import UIKit

/** This class is for presenting alert controller without providing the presenter view controller */
extension UIAlertController {
    
    //override func show() {
    func show() {
        present(true, completion: nil)
    }
    
    //override func present(animated: Bool, completion: (() -> Void)?) {
    func present(_ animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
        }
    }
}
