//
//  SettingViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else {return nil}
        return version
    }
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumLabel.text = GlobalDatas.currentUser.phoneNum
        emailLabel.text = GlobalDatas.currentUser.email
        
        versionLabel.text = version
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "환경설정"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func logoutEvent() {
        logout()
        
//        UserDefs.setAutoLogin(false)
//        self.present(SplashViewController(), animated: true, completion: nil)
    }

}

extension SettingViewController {
    func logout() {
        ServerUtil.shared.deleteAuth(self) { (success, dict, message) in
            guard success else {
//                AlertHandler.shared.showAlert(vc: self, message: message!, okTitle: "확인")
                return }
            
            UserDefs.setAutoLogin(false)
            let navi = UINavigationController(rootViewController: LoginViewController())
            navi.navigationBar.barStyle = .black
            navi.navigationBar.tintColor = .white
            navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navi.navigationBar.shadowImage = UIImage()
            self.present(navi, animated: true, completion: nil)
        }
    }
}
