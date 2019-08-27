//
//  SplashViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: UIViewController {

    var locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.delegate = self
        
        NotificationCenter.default.addObserver(self, selector:#selector(locCheck), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
    }
    
    @objc func locCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse, CLLocationManager.authorizationStatus() == .authorizedAlways {
            if UserDefs.isAutoLogin {
                showHomeVc()
            }
            else {
                showLoginVc()
            }
        }
    }
    
    func showHomeVc() {
        let navi = UINavigationController(rootViewController: HomeViewController())
        navi.navigationBar.barStyle = .black
        navi.navigationBar.tintColor = .white
        navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navi.navigationBar.shadowImage = UIImage()
        self.present(navi, animated: true, completion: nil)
    }
    
    func showLoginVc() {
        let navi = UINavigationController(rootViewController: LoginViewController())
        navi.navigationBar.barStyle = .black
        navi.navigationBar.tintColor = .white
        navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navi.navigationBar.shadowImage = UIImage()
        self.present(navi, animated: true, completion: nil)
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
            AlertHandler.shared.showAlert(vc: self, message: "권한설정해주세요", okTitle: "OK", cancelTitle: "NO", okHandler: { (_) in
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
