//
//  SplashViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if UserDefs.isAutoLogin {
                let navi = UINavigationController(rootViewController: HomeViewController())
                navi.navigationBar.barStyle = .black
                navi.navigationBar.tintColor = .white
                navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navi.navigationBar.shadowImage = UIImage()
                self.present(navi, animated: true, completion: nil)
            }
            else {
                let navi = UINavigationController(rootViewController: LoginViewController())
                navi.navigationBar.barStyle = .black
                navi.navigationBar.tintColor = .white
                navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navi.navigationBar.shadowImage = UIImage()
                self.present(navi, animated: true, completion: nil)
            }
            
        }
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
