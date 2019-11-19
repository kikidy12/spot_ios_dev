//
//  AttendanceCheckViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation
import Lottie

class AttendanceCheckViewController: UIViewController {
    
    let lottie = AnimationView()
    
    @IBOutlet weak var attdentView: UIView!
    @IBOutlet weak var attdentBtn: UIButton!
    
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ani = Animation.named("roulette")
        lottie.animation = ani
        lottie.frame = self.loadingView.bounds
        lottie.sizeToFit()
        lottie.loopMode = .loop
        lottie.contentMode = .scaleToFill
        self.loadingView.addSubview(lottie)
        loadingView.isHidden = true
        getAttendence()
    }
    
    @IBAction func attendentEvnet() {
        
        if attdentBtn.titleLabel?.text == "룰렛 돌리기" {
            loadingView.isHidden = false
            lottie.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.rouletteEvent()
            }
        }
        else {
            attendent()
        }
        
    }
    
    
    func setAttdent(_ count: Int = 0) {
        if count == 10 {
            attdentBtn.setTitle("룰렛 돌리기", for: .normal)
        }
        else {
            attdentBtn.setTitle("출석하기 (\(count)/10)", for: .normal)
        }
        
        attdentView.subviews.enumerated().forEach {
            if $0.offset < count {
                $0.element.tintColor = .darkishPink
            }
            else {
                $0.element.tintColor = .lightBlueGreyTwo
            }
        }
    }
}

extension AttendanceCheckViewController {
    func getAttendence() {
        ServerUtil.shared.getAttendance(self) { (success, dict, message) in
            guard success, let count = dict?["attendance_count"] as? Int else { return }
            
            self.setAttdent(count)
        }
    }
    
    func attendent() {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor
        numberFormatter.maximumSignificantDigits = 10
        
        guard let lat = CLLocationManager().location?.coordinate.latitude, let lng = CLLocationManager().location?.coordinate.longitude else { return }
        let parameter = [
            "latitude": lat,
            "longitude": lng
        ] as [String:Any]
        print(parameter)
        ServerUtil.shared.postAttendance(self, parameters: parameter) { (success, dict, message) in
            guard success, let count = dict?["attendance_count"] as? Int else {
                if let message = message {
                    AlertHandler.shared.showAlert(vc: self, message: message, okTitle: "OK")
                }
                return
            }
            
            self.setAttdent(count)
            let vc = AttendanceCheckPopupViewController()
            vc.count = count
            self.showPopupView(vc: vc)
        }
    }
    
    func rouletteEvent() {
        ServerUtil.shared.postRoulette(self) { (success, dict, message) in
            self.loadingView.isHidden = true
            self.lottie.stop()
            guard success, let roulette = dict?["roulette"] as? NSDictionary, let name = roulette["name"] as? String else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "error", okTitle: "확인")
                return
            }
            let vc = WinningPopUpViewController()
            vc.message = name
            vc.compClouser = {
                self.setAttdent(0)
                self.navigationController?.popViewController(animated: true)
            }
            self.showPopupView(vc: vc)
        }
    }
}
