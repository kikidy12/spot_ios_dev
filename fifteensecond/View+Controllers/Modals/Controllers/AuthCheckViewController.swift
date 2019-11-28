//
//  AuthCheckViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 08/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthCheckViewController: UIViewController {

    var lastTime = 180
    var nationalCode: String = ""
    var phoneNum: String = ""
    var verifiID = ""
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        phoneLabel.text = phoneNum + "로\n발송된 인증번호를 입력해주세요"
        codeTextField.attributedPlaceholder = NSAttributedString(string: "4자리 숫자입력",
                                                                 attributes: [.foregroundColor: UIColor.steel])
        
        
        settingTimer()
    }
    
    func settingTimer() {
        self.timerLabel.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.lastTime -= 1
            
            self.timerLabel.text = "\(self.lastTime)s"
            if self.lastTime == 0 {
                timer.invalidate()
                self.timerLabel.isHidden = true
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.lastTime <= 0 {
                timer.invalidate()
                self.timerLabel.isHidden = true
//                self.resendLabel.isHidden = false
            }
            self.lastTime -= 1
            self.timerLabel.text = "\(self.lastTime)s"
        }
    }
    
    @IBAction func authCheck(sender: UIButton) {
        guard let authCode = codeTextField.text, !authCode.isEmpty else {
            AlertHandler.shared.showAlert(vc: self, message: "enter user code", okTitle: "OK")
            return
        }
        let parameters = [
            "national_code": nationalCode,
            "phone_num": phoneNum,
            "phone_auth_code": authCode
        ] as [String:Any]
        ServerUtil.shared.postAuth(self, parameters: parameters) { (success, dict, message) in
            guard success, let token = dict?["token"] as? String else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "", okTitle: "확인")
                return
            }
            UserDefs.setUserToken(token: token)
            UserDefs.setAutoLogin(true)
            
            if UserDefs.isOpenedApp {
                let navi = UINavigationController(rootViewController: HomeViewController())
                navi.navigationBar.barStyle = .black
                navi.navigationBar.tintColor = .white
                navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
            }
            else {
                let vc = TutoMainViewController()
                self.show(vc, sender: nil)
            }
        }
    }

}
