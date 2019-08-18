//
//  Extenstions.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Foundation


extension UIViewController {
    func closeVc(goToRoot: Bool = false, destination: UIViewController? = nil) {
        if let navi = self.navigationController {
            if goToRoot {
                navi.popToRootViewController(animated: true)
            }
            else {
                if let dest = destination {
                    navi.popToViewController(dest, animated: true)
                }
                else {
                    navi.popViewController(animated: true)
                }
            }
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showPopupView(vc: UIViewController) {
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func phoneCallRequest(_ phoneNum: String) {
        guard let url = URL(string: "tel://\(phoneNum)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var closeEventInputAccessary:UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeBtn = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeTextField))
        toolbar.items = [spaceBar, closeBtn]
        return toolbar
    }
    
    @objc func closeTextField() {
        self.view.endEditing(true)
    }
    
    func setActivateBtn(button: UIButton, isActivate: Bool = false) {
        let gradient = CAGradientLayer()
        if isActivate {
            gradient.colors = [UIColor.peachyPink.cgColor, UIColor.darkishPink.cgColor]
        }
        else {
            gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        }
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.frame = button.bounds
        
        if let oldLayer = button.layer.sublayers?.first(where: {$0 is CAGradientLayer}) {
            button.layer.replaceSublayer(oldLayer, with: gradient)
        }
        else {
            button.layer.addSublayer(gradient)
        }
        
        button.bringSubviewToFront(button.titleLabel!)
    }
}
