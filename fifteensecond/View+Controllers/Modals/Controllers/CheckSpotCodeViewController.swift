//
//  CheckSpotCodeViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/10/22.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CheckSpotCodeViewController: UIViewController {
    
    @IBOutlet weak var numberfirstView: UITextField!
    @IBOutlet weak var numbersecondView: UITextField!
    @IBOutlet weak var numberthirdView: UITextField!
    @IBOutlet weak var numberfourthView: UITextField!
    @IBOutlet weak var numberfifthView: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "15Seconds 인증하기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberfirstView.text = ""
        numbersecondView.text = ""
        numberthirdView.text = ""
        numberfourthView.text = ""
        numberfifthView.text = ""
        
        view.endEditing(true)
    }
    
    @IBAction func editLimitEvent(_ sender: UITextField) {
        if let tempText = sender.text, tempText.count > 1 {
            sender.text = String(tempText.dropLast())
        }
        
        if sender == numberfirstView, sender.text!.count == 1 {
            numbersecondView.becomeFirstResponder()
        }
        if sender == numbersecondView, sender.text!.count == 1 {
            numberthirdView.becomeFirstResponder()
        }
        if sender == numberthirdView, sender.text!.count == 1 {
            numberfourthView.becomeFirstResponder()
        }
        if sender == numberfourthView, sender.text!.count == 1 {
            numberfifthView.becomeFirstResponder()
        }
        if sender == numberfifthView, sender.text!.count == 1 {
            numberfifthView.resignFirstResponder()
        }
    }
    
    @IBAction func checkCode() {
        guard !numberfirstView.text!.isEmpty, !numbersecondView.text!.isEmpty, !numberthirdView.text!.isEmpty, !numberfourthView.text!.isEmpty, !numberfifthView.text!.isEmpty else {
            return
        }
        checkSpotCode()
    }

}

extension CheckSpotCodeViewController {
    func checkSpotCode() {
        let code = "\(numberfirstView.text!)\(numbersecondView.text!)\(numberthirdView.text!)\(numberfourthView.text!)\(numberfifthView.text!)"
        
        let parameters = [
            "unique_number": code
        ] as [String: Any]
        
        ServerUtil.shared.getSpotNumberCheck(self, parameters: parameters) { (success, dict, message) in
            guard success, let spotDict = dict?["spot"] as? NSDictionary else {
                return
            }
            
            let spot = SpotDatas(spotDict)
            
            let vc = UseSpotViewController()
            vc.code = code
            vc.spot = spot
            self.show(vc, sender: nil)
        }
    }
}
