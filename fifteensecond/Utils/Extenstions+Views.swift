//
//  Extenstions.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation
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
    
    func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        print(currentVersion)
        print(url.absoluteString)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
                completion(version != currentVersion, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
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
    
    func phoneCall(_ phoneNum: String) {
        let str = phoneNum.components(separatedBy: [" ", "\n"]).joined()
        guard let url = URL(string: "tel://\(str)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            print("전화불가")
        }
    }
    
    func openNaverNavi(lat: Double, lng: Double) {
        let urlString = "nmap://navigation?dlat=\(lat)&dlng=\(lng)"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: nil)
            }
            else {
                UIApplication.shared.open(URL(string: "https://itunes.apple.com/kr/app/id311867728?mt=8")!, completionHandler: nil)
            }
        }
    }
    
    
    @IBAction func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}
