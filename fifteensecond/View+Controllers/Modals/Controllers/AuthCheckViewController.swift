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

        phoneLabel.text = nationalCode + phoneNum + "로\n발송된 인증번호를 입력해주세요"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func SMSAuth() {
        print("snsAuth")
        self.codeTextField.text = ""
        PhoneAuthProvider.provider().verifyPhoneNumber("+821089049034", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("error")
                print(error)
                return
            }
            guard let vid = verificationID else {
                print("idFail")
                return
            }
            self.lastTime = 180
            self.setTimer()
            self.verifiID = vid
        }
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
            
            guard success, let data = dict?["user"] as? NSDictionary, let token = dict?["token"] as? String else { return }
            UserDefs.setUserToken(token: token)
            UserDefs.setAutoLogin(true)
            
            self.navigationController?.isNavigationBarHidden = false
            let vc = HomeViewController()
            self.show(vc, sender: nil)

        }
//        guard let code = codeTextField.text, !code.isEmpty else { return }
//        let credential = PhoneAuthProvider.provider().credential(
//            withVerificationID: verifiID,
//            verificationCode: code)
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if let error = error {
//                self.codeTextField.text = ""
//                print(error)
//                return
//            }
//
//            self.performSegue(withIdentifier: "nextStep", sender: nil)
//        }
    }

}
