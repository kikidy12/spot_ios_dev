//
//  SplashViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation

class SplashViewController: UIViewController {

    var locManager = CLLocationManager()
    
    var lottie: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        locManager.delegate = self
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.locCheck), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
        
        lottie = AnimationView(animation: Animation.named("logolottie"))
        lottie.frame.size = CGSize(width: 250, height: 250)
        lottie.contentMode = .scaleToFill
        lottie.center = view.center
        view.addSubview(lottie)
        lottie.loopMode = .playOnce
        
    }
    
    @objc func locCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse, CLLocationManager.authorizationStatus() == .authorizedAlways {
            
            if UserDefs.isAutoLogin {
                self.showHomeVc()
            }
            else {
                self.showLoginVc()
            }
        }
    }
    
    func showHomeVc() {
        lottie.play { (_) in
            if UserDefs.isOpenedApp {
                let navi = UINavigationController(rootViewController: HomeViewController())
                navi.navigationBar.barStyle = .black
                navi.navigationBar.tintColor = .white
                navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
            }
            else {
                let navi = UINavigationController(rootViewController: TutoMainViewController())
                navi.navigationBar.barStyle = .black
                navi.navigationBar.tintColor = .white
                navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
            }
        }
    }
    
    func showLoginVc() {
        lottie.play { (_) in
            let navi = UINavigationController(rootViewController: LoginViewController())
            navi.navigationBar.barStyle = .black
            navi.navigationBar.tintColor = .white
            navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navi.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow?.rootViewController = navi
        }
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SplashViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("notDetermined")
            // Request when-in-use authorization initially
            manager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            AlertHandler.shared.showAlert(vc: self, message: "위치정보 사용을 허용해 주세요.", okTitle: "설정", cancelTitle: "취소", okHandler: { (_) in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }, cancelHandler: { (_) in
                exit(0)
            })

            break
            
        case .authorizedWhenInUse:
            if UserDefs.isAutoLogin {
                showHomeVc()
            }
            else {
                showLoginVc()
            }
            
            break
            
        case .authorizedAlways:
            if UserDefs.isAutoLogin {
                showHomeVc()
            }
            else {
                showLoginVc()
            }
            break
        @unknown default:
            fatalError()
        }
    }
}
