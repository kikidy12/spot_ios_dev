//
//  RestaurantPopUpViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 25/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RestaurantPopUpViewController: UIViewController {
    
    var type: AlienceTitles = .restaurant
    
    var promotion: PromotionDatas!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numberfirstView: UITextField!
    @IBOutlet weak var numbersecondView: UITextField!
    @IBOutlet weak var numberthirdView: UITextField!
    @IBOutlet weak var numberfourthView: UITextField!
    @IBOutlet weak var numberfifthView: UITextField!
    @IBOutlet weak var numbersixthView: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = promotion.title
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberfirstView.text = ""
        numbersecondView.text = ""
        numberthirdView.text = ""
        numberfourthView.text = ""
        numberfifthView.text = ""
        numbersixthView.text = ""
        
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
            numbersixthView.becomeFirstResponder()
        }
        if sender == numbersixthView, sender.text!.count == 1 {
            numbersixthView.resignFirstResponder()
        }
    }
    
    @IBAction func checkCode() {
        guard !numberfirstView.text!.isEmpty, !numbersecondView.text!.isEmpty, !numberthirdView.text!.isEmpty, !numberfourthView.text!.isEmpty, !numberfifthView.text!.isEmpty, !numbersixthView.text!.isEmpty else {
            AlertHandler().showAlert(vc: self, message: "코드를 입력해 주세요.", okTitle: "확인")
            return
        }
        usePromotion()
    }

}

extension RestaurantPopUpViewController {
    func usePromotion() {
        let code = "\(numberfirstView.text!)\(numbersecondView.text!)\(numberthirdView.text!)\(numberfourthView.text!)\(numberfifthView.text!)\(numbersixthView.text!)"
        
        let parameters = [
            "auth_num": code,
            "promotion_id": promotion.id!
        ] as [String: Any]
        
        self.numberfirstView.text = ""
        self.numbersecondView.text = ""
        self.numberthirdView.text = ""
        self.numberfourthView.text = ""
        self.numberfifthView.text = ""
        self.numbersixthView.text = ""
        
        ServerUtil.shared.postPromotionLogs(self, parameters: parameters) { (success, dict, message) in
            
            
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "error", okTitle: "확인")
                return
            }
            AlertHandler.shared.showAlert(vc: self, message: "인증이 완료되었습니다", okTitle: "확인", okHandler: { (_) in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}
