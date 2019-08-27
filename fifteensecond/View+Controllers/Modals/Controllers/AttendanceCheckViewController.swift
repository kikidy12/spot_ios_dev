//
//  AttendanceCheckViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class AttendanceCheckViewController: UIViewController {
    
    @IBOutlet weak var attdentView: UIView!
    @IBOutlet weak var attdentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAttendence()
    }
    
    @IBAction func attendentEvnet() {
        attendent()
    }
    
    func setAttdent(_ count: Int = 0) {
        attdentBtn.setTitle("춣석하기 (\(count)/10)", for: .normal)
        attdentView.subviews.enumerated().forEach {
            if let imageView = $0.element as? UIImageView {
                if $0.offset < count {
                    imageView.image = #imageLiteral(resourceName: "attendLogo")
                }
                else {
                    imageView.image = #imageLiteral(resourceName: "radioBackground")
                }
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
        guard let lat = CLLocationManager().location?.coordinate.latitude, let lng = CLLocationManager().location?.coordinate.longitude else { return }
        let parameter = [
            "latitude": lat,
            "longitude": lng
        ] as [String:Any]
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
}
