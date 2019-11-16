//
//  LoginViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 05/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import KakaoOpenSDK
import Kingfisher

class LoginViewController: UIViewController {
    
    let pickerView = UIPickerView()
    let textField = UITextField(frame: .zero)
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nationImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        navigationController?.isNavigationBarHidden = true
        phoneNumTextField.attributedPlaceholder = NSAttributedString(string: "ex) 01012345678",
                                                                 attributes: [.foregroundColor: UIColor.steel])
        phoneNumTextField.inputAccessoryView = closeEventInputAccessary
        createPickerViewAndAccessarayView()
        getNationCode()
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func loginEvent(sender: UIButton) {
        authCheckByPhoneNumber()
    }
    
    @IBAction func showNationCodeList(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func signupEvent(sender: UIButton) {
//        self.showPopupView(vc: SharedPopupViewController())
        navigationController?.isNavigationBarHidden = false
        let vc = SignUpViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func faceBookSignIn(_ sender: Any) {
        if((AccessToken.current) != nil) {
            facebookUserInfoRequest()
        }
        else {
            getFacebookUserInfo()
        }
        
    }
    
    @IBAction func kakaoSignIn(_ sender: UIButton) {
        print("kakaoStart")
        guard let kakaoSession = KOSession.shared() else { return }
        if kakaoSession.isOpen() {
            print("kakaoSessionColose")
            kakaoSession.close()}
        
        kakaoSession.presentingViewController = self
        kakaoSession.open(completionHandler: { (error) in
            if error != nil || !kakaoSession.isOpen() {
                print("openError: ", error)
                return
            }
            KOSessionTask.userMeTask(completion: { (error, user) in
                if let account = user?.account {
                    var updateScopes = [String]()
                    if account.emailNeedsAgreement {
                        updateScopes.append("account_email")
                    }
                    KOSession.shared()?.updateScopes(updateScopes, completionHandler: { (error) in
                        guard error == nil else {
                            print("updateError: ", error)
                            return
                        }
                        KOSessionTask.userMeTask(completion: { (error, user) in
                            self.profile(error, user: user)
                        })
                    })
                } else {
                    self.profile(error, user: user)
                }
            })
        })
    }
    
    func getFacebookUserInfo(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            
            let fbloginresult = result!
            if(fbloginresult.grantedPermissions.contains("email")) {
                if((AccessToken.current) != nil) {
                    self.facebookUserInfoRequest()
                }
            }
        }
    }
    
    
    func facebookUserInfoRequest() {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                let dict: NSDictionary = result as! NSDictionary
                print("dict: ",dict)
                if let token = AccessToken.current?.tokenString {
                    print("fbtocken: \(token)")
                    
                    let userDefult = UserDefaults.standard
                    userDefult.setValue(token, forKey: "access_tocken")
                    userDefult.synchronize()
                }
                
                let email = dict["email"] as? String
                let uid = dict["id"] as! String
                
                print(uid)
                print(email)
                
                self.snsCheck(provider: "FACEBOOK", uid: uid, email: email)
            }
        })
    }
    
    
    //kakao profile
    func profile(_ error: Error?, user: KOUserMe?) {
        guard let user = user,
            error == nil else {
                print("userError: ", error)
                return
        }
        
        guard let token = user.id else { return }
        let name = user.nickname ?? ""
        let email = user.account?.email
        
        print(token)
        print(name)
        print(email)
        
        self.snsCheck(provider: "KAKAO", uid: token, email: email)
    }
    
    func createPickerViewAndAccessarayView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let selectBtn = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectRow))
        toolbar.items = [spaceBar, selectBtn]
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        view.addSubview(textField)
    }
    
    @objc func selectRow() {
        let nation = GlobalDatas.nationCodeList[pickerView.selectedRow(inComponent: 0)]
        codeLabel.text = nation.code
        if let nationImageURL = URL(string: nation.imgUrl ?? "") {
            nationImageView.kf.setImage(with: nationImageURL)
        }
        textField.resignFirstResponder()
    }
}

extension LoginViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("notDetermined")
            // Request when-in-use authorization initially
            manager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            print("fail")
            break
            
        case .authorizedWhenInUse:
            print("location Access")
            break
            
        case .authorizedAlways:
            print("location Access")
            break
        @unknown default:
            fatalError()
        }
    }
}

extension LoginViewController: GIDSignInUIDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)

        print(user.profile.email)
        print(user.userID)
        self.snsCheck(provider: "GOOGLE", uid: user.userID, email: user.profile.email)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GlobalDatas.nationCodeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GlobalDatas.nationCodeList[row].name
    }
    
}
extension LoginViewController {
    func getNationCode() {
        ServerUtil.shared.getNationCode(self) { (success, dict, message) in
            guard success, let data = dict, let array = data["nation_code"] as? NSArray else { return }
            
            GlobalDatas.nationCodeList = array.compactMap { NationCodeData($0 as! NSDictionary) }
            
            let nation = GlobalDatas.nationCodeList.first(where: { $0.code == "82"})
            self.codeLabel.text = nation!.code
            if let nationImageURL = URL(string: nation!.imgUrl ?? "") {
                self.nationImageView.kf.setImage(with: nationImageURL)
            }
            
            self.pickerView.reloadAllComponents()
        }
    }
    
    func snsCheck(provider: String, uid: String, email: String?) {
        let parameters = [
            "provider": provider,
            "uid": uid
        ] as [String:Any]
        ServerUtil.shared.postSnsAuth(self, parameters: parameters) { (success, dict, message) in
            guard success, let isSigned = dict?["is_signup"] as? Bool else { return }
            
            if isSigned {
                if let token = dict?["token"] as? String {
                    UserDefs.setUserToken(token: token)
                    UserDefs.setAutoLogin(true)
                    let navi = UINavigationController(rootViewController: HomeViewController())
                    navi.navigationBar.barStyle = .black
                    navi.navigationBar.tintColor = .white
                    navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
                    navi.navigationBar.shadowImage = UIImage()
                    navi.isNavigationBarHidden = false
                    UIApplication.shared.keyWindow?.rootViewController = navi
                }
            }
            else {
                self.navigationController?.isNavigationBarHidden = false
                let vc = SignUpViewController()
                if let email = email {
                    vc.email = email
                }
                vc.provider = provider
                vc.snsUID = uid
                self.show(vc, sender: nil)
            }
        }
    }
    
    func authCheckByPhoneNumber() {
        guard let phoneCode = codeLabel.text, let phoneNum = phoneNumTextField.text, !phoneCode.isEmpty, !phoneNum.isEmpty else {
            AlertHandler.shared.showAlert(vc: self, message: "enter your phone number.", okTitle: "OK")
            return
        }
        let parameters = [
            "national_code": phoneCode,
            "phone_num": phoneNum
        ] as [String:Any]
        ServerUtil.shared.postSendSms(self, parameters: parameters) { (success, dict, message) in
            guard success else { return }
            
            self.navigationController?.isNavigationBarHidden = false
            let vc = AuthCheckViewController()
            vc.phoneNum = phoneNum
            vc.nationalCode = phoneCode
            self.show(vc, sender: nil)
        }
    }
}
