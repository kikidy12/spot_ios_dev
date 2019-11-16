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
    
    var termCheck: Bool = false
    
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
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "ex) 01012345678",
                                                                 attributes: [.foregroundColor: UIColor.steel])
        if email != nil {
            emailTextField.text = email
        }
        
        let nation = GlobalDatas.nationCodeList.first(where: { $0.code == "82"})
        self.phoneCodeLabel.text = nation!.code
        if let nationImageURL = URL(string: nation!.imgUrl ?? "") {
            self.nationImageView.kf.setImage(with: nationImageURL)
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
        if isNext, termCheck {
            signUpParameters["name"] = nameTextField.text!
            signUpParameters["email"] = emailTextField.text!
            signUpParameters["national_code"] = phoneCodeLabel.text!
            signUpParameters["phone_num"] = phoneTextField.text!
            signUpParameters["provieder"] = provider
            signUpParameters["uid"] = snsUID
            
            smsAuth()
        }
    }
    
    @IBAction func showServiceTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotPrivacyTerm", withExtension: "docx")
        vc.titleStr = "SPOT 서비스 이용약관"
        show(vc, sender: nil)
    }
    
    @IBAction func showLocationTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotServiceTerm", withExtension: "docx")
        vc.titleStr = "개인정보 처리방침"
        show(vc, sender: nil)
    }
    
    @IBAction func showPrivacyTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotLocationTerm", withExtension: "docx")
        vc.titleStr = "위치기반 서비스 이용약관"
        show(vc, sender: nil)
    }
    
    @IBAction func termCheckEvent(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "checkIcon"), for: .normal)
            sender.tag = 1
            termCheck = true
        }
        else {
            sender.setImage(nil, for: .normal)
            sender.tag = 0
            termCheck = false
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
        let nation = GlobalDatas.nationCodeList[pickerView.selectedRow(inComponent: 0)]
        self.phoneCodeLabel.text = nation.code
        if let nationImageURL = URL(string: nation.imgUrl ?? "") {
            self.nationImageView.kf.setImage(with: nationImageURL)
        }
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
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            let vc = AuthCheckViewController()
            vc.phoneNum = self.phoneTextField.text ?? ""
            vc.nationalCode = self.phoneCodeLabel.text ?? ""
            self.show(vc, sender: nil)
        }
    }
}
