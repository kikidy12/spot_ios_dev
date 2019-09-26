//
//  RestaurantPopUpViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 25/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RestaurantPopUpViewController: UIViewController {
    
    var restaurant: RestaurantDatas!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numberfirstView: UITextField!
    @IBOutlet weak var numbersecondView: UITextField!
    @IBOutlet weak var numberthirdView: UITextField!
    @IBOutlet weak var numberfourthView: UITextField!
    @IBOutlet weak var numberfifthView: UITextField!
    @IBOutlet weak var numbersixthView: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = restaurant.name
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
        useRestaurant()
    }

}

extension RestaurantPopUpViewController {
    func useRestaurant() {
        let code = "\(numberfirstView.text!)\(numbersecondView.text!)\(numberthirdView.text!)\(numberfourthView.text!)\(numberfifthView.text!)\(numbersixthView.text!)"
        
        print(code)
    }
}
