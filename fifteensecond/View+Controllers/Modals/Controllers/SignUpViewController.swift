//
//  SignUpViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 08/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var provider: String = ""
    var snsUID: String = ""
    var signUpParameters = [String:Any]()
    let pickerView = UIPickerView()
    let textField = UITextField(frame: .zero)
    
    var email: String!
    var isNext = false
    
    @IBOutlet weak var nationImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneCodeLabel: UILabel!
    @IBOutlet weak var nextButton: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                             attributes: [.foregroundColor: UIColor.steel])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                 attributes: [.foregroundColor: UIColor.steel])
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                                                 attributes: [.foregroundColor: UIColor.steel])
        if email != nil {
            emailTextField.text = email
        }
        
        createPickerViewAndAccessarayView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func showNationCodeList(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            textField.becomeFirstResponder()
        }
    }
    
    @IBAction func textChange(sender: UITextField) {
        if !nameTextField.text!.isEmpty, !emailTextField.text!.isEmpty, !phoneTextField.text!.isEmpty {
            setActivateBtn(button: nextButton, isActivate: true)
            nextButton.layer.borderWidth = 0
            isNext = true
        }
        else {
            setActivateBtn(button: nextButton, isActivate: false)
            nextButton.layer.borderWidth = 1
            isNext = false
        }
    }

    @IBAction func nextEvent(sender: UIButton) {
        if isNext {
            signUpParameters["name"] = nameTextField.text!
            signUpParameters["email"] = emailTextField.text!
            signUpParameters["national_code"] = phoneCodeLabel.text!
            signUpParameters["phone_num"] = phoneTextField.text!
            signUpParameters["provieder"] = provider
            signUpParameters["uid"] = snsUID
            
            smsAuth()
        }
    }
    
    func createPickerViewAndAccessarayView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let selectBtn = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectRow))
        toolbar.items = [spaceBar, selectBtn]
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        view.addSubview(textField)
    }
    
    @objc func selectRow() {
        phoneCodeLabel.text = GlobalDatas.nationCodeList[pickerView.selectedRow(inComponent: 0)].code
        textField.resignFirstResponder()
    }
}

extension SignUpViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GlobalDatas.nationCodeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GlobalDatas.nationCodeList[row].name
    }
    
}

extension SignUpViewController {
    func smsAuth() {
        print(signUpParameters)
        ServerUtil.shared.putSendSms(self, parameters: signUpParameters) { (success, dict, message) in
            guard success else { return }
            print(message)
            let vc = AuthCheckViewController()
            vc.phoneNum = "\(self.phoneCodeLabel.text ?? "")\(self.phoneTextField.text ?? "")"
            self.show(AuthCheckViewController(), sender: nil)
        }
    }
}
