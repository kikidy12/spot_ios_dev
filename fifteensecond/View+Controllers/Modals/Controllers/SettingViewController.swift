//
//  SettingViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import KakaoOpenSDK

class SettingViewController: UIViewController {
    
    var providerList = [ProviderDatas]() {
        didSet {
            providerList.forEach {
                if $0.provider == "GOOGLE" {
                    googleBtn.layer.borderColor = UIColor.steel.cgColor
                    googleBtn.setTitleColor(.steel, for: .normal)
                    googleBtn.setTitle("연동완료", for: .normal)
                    googleBtn.isEnabled = false
                }
                if $0.provider == "KAKAO" {
                    kakaoBtn.layer.borderColor = UIColor.steel.cgColor
                    kakaoBtn.setTitleColor(.steel, for: .normal)
                    kakaoBtn.setTitle("연동완료", for: .normal)
                    kakaoBtn.isEnabled = false
                }
                if $0.provider == "FACEBOOK" {
                    facebookBtn.layer.borderColor = UIColor.steel.cgColor
                    facebookBtn.setTitleColor(.steel, for: .normal)
                    facebookBtn.setTitle("연동완료", for: .normal)
                    facebookBtn.isEnabled = false
                }
            }
        }
    }
    
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else {return nil}
        return version
    }
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumLabel.text = GlobalDatas.currentUser.phoneNum
        emailLabel.text = GlobalDatas.currentUser.email
        
        versionLabel.text = version
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "환경설정"
        getSnsConnection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func logoutEvent() {
        logout()
    }
    
    @IBAction func showTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotServiceTerm", withExtension: "docx")
        vc.titleStr = "서비스 이용 약관"
        self.show(vc, sender: nil)
    }
    
    @IBAction func deleteUserEvent() {
        AlertHandler.shared.showAlert(vc: self, message: "탈퇴하시겠습니까?", okTitle: "확인", cancelTitle: "취소") { (_) in
            self.deleteUser()
        }
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
        guard let kakaoSession = KOSession.shared() else { return }
        if kakaoSession.isOpen() {
            print("kakaoSessionColose")
            kakaoSession.close()}
        
        kakaoSession.presentingViewController = self
        kakaoSession.open(completionHandler: { (error) in
            if error != nil || !kakaoSession.isOpen() {
                print("openError: ", error ?? "error")
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
                            print("updateError: ", error ?? "error")
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
                let uid = dict["id"] as! String
                
                print(uid)
                
                self.snsConnect(provider: "FACEBOOK", uid: uid)
            }
        })
    }
    
    
    //kakao profile
    func profile(_ error: Error?, user: KOUserMe?) {
        guard let user = user,
            error == nil else {
                print("userError: ", error ?? "")
                return
        }
        
        guard let token = user.id else { return }
        let name = user.nickname ?? ""
        
        print(token)
        print(name)
        
        self.snsConnect(provider: "KAKAO", uid: token)
    }

}

extension SettingViewController: GIDSignInUIDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        
        self.snsConnect(provider: "GOOGLE", uid: user.userID)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension SettingViewController {
    func logout() {
        ServerUtil.shared.deleteAuth(self) { (success, dict, message) in
            guard success else {
//                AlertHandler.shared.showAlert(vc: self, message: message!, okTitle: "확인")
                return }
            
            UserDefs.setAutoLogin(false)
            UserDefs.setUserToken(token: "")
            GlobalDatas.currentUser = nil
            let navi = UINavigationController(rootViewController: LoginViewController())
            navi.navigationBar.barStyle = .black
            navi.navigationBar.tintColor = .white
            navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navi.navigationBar.shadowImage = UIImage()
            self.present(navi, animated: true, completion: nil)
        }
    }
    
    func getSnsConnection() {
        ServerUtil.shared.getSnsAuth(self) { (success, dict, message) in
            guard success, let array = dict?["provider"] as? NSArray else {
                return
            }
            
            self.providerList = array.compactMap { ProviderDatas($0 as! NSDictionary) }
        }
    }
    
    func snsConnect(provider: String, uid: String) {
        let parameters = [
            "provider" : provider,
            "uid": uid
            ] as [String: Any]
        ServerUtil.shared.putSnsAuth(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.getSnsConnection()
        }
    }
    
    func deleteUser() {
        let parameters = [
            "id": GlobalDatas.currentUser.id!
        ] as [String: Any]
        ServerUtil.shared.postUserDelete(self, parameters: parameters) { (success, dict, message) in
            guard success else { return }
            
            UserDefs.setAutoLogin(false)
            UserDefs.setUserToken(token: "")
            GlobalDatas.currentUser = nil
            let navi = UINavigationController(rootViewController: LoginViewController())
            navi.navigationBar.barStyle = .black
            navi.navigationBar.tintColor = .white
            navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navi.navigationBar.shadowImage = UIImage()
            self.present(navi, animated: true, completion: nil)
        }
    }
}
