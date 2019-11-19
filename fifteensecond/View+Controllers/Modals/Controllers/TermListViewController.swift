//
//  TermListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/10/21.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class TermListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        title = "약관 및 정책"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func showServiceTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotServiceTerm", withExtension: "docx")
        vc.titleStr = "SPOT 서비스 이용약관"
        show(vc, sender: nil)
    }
    
    @IBAction func showLocationTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotLocationTerm", withExtension: "docx")
        vc.titleStr = "위치기반 서비스 이용약관"
        show(vc, sender: nil)
    }
    
    @IBAction func showPrivacyTermEvent() {
        let vc = DocumentViewController()
        vc.fileUrl = Bundle.main.url(forResource: "spotPrivacyTerm", withExtension: "docx")
        vc.titleStr = "개인정보 처리방침"
        show(vc, sender: nil)
    }
}
