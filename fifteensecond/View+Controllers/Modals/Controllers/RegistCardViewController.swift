//
//  RegistCardViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 02/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RegistCardViewController: UIViewController {
    
    var cardTextFields = [UITextField]()
    var twoDigitTextFields = [UITextField]()
    
    //card num textfield
    @IBOutlet weak var cardNumFisrtTextField: UITextField!
    @IBOutlet weak var cardNumSecondTextField: UITextField!
    @IBOutlet weak var cardNumThirdTextField: UITextField!
    @IBOutlet weak var cardNumFourthTextField: UITextField!
    
    //date text field
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    
    //secure text field
    @IBOutlet weak var passwordTextField: UITextField!
    
    //birth text field
    @IBOutlet weak var birthdayTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardTextFields = [cardNumFisrtTextField, cardNumSecondTextField, cardNumThirdTextField, cardNumFourthTextField]
        twoDigitTextFields = [yearTextField, monthTextField, passwordTextField]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "카드 등록"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func selectNextTextField(_ sender: UITextField) {
        if let tempText = sender.text, tempText.count > 4 {
            sender.text = String(tempText.dropLast())
        }
        
        if sender == cardNumFisrtTextField, sender.text!.count == 4 {
            cardNumSecondTextField.becomeFirstResponder()
        }
        if sender == cardNumSecondTextField, sender.text!.count == 4 {
            cardNumThirdTextField.becomeFirstResponder()
        }
        if sender == cardNumThirdTextField, sender.text!.count == 4 {
            cardNumFourthTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func limitTextCount(_ sender: UITextField) {
        if sender == birthdayTextField, let tempText = sender.text, tempText.count > 6 {
            sender.text = String(tempText.dropLast())
        }
        
        if sender != birthdayTextField, let tempText = sender.text, tempText.count > 2 {
            sender.text = String(tempText.dropLast())
        }
    }
    
    @IBAction func registCardEvent() {
        registCard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension RegistCardViewController {
    func registCard() {
        
        guard !cardTextFields.contains(where: {$0.text!.count != 4}) else { return }
        guard !twoDigitTextFields.contains(where: {$0.text!.count != 2}) else { return }
        guard birthdayTextField.text?.count == 6 else { return }
        
        let parameters = [
            "card_num": cardNumFisrtTextField.text! + cardNumSecondTextField.text! + cardNumThirdTextField.text! + cardNumFourthTextField.text!,
            "year": yearTextField.text!,
            "month": monthTextField.text!,
            "birthday": birthdayTextField.text!,
            "password_2digit": passwordTextField.text!
        ] as [String:Any]
        ServerUtil.shared.putCardRegistration(self, parameters: parameters) { (success, dict, message) in
            guard success else { return }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}


