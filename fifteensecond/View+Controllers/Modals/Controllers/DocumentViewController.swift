//
//  DocumentViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/10/15.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import WebKit

class DocumentViewController: UIViewController {
    
    var fileUrl: URL!
    var titleStr = ""
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: fileUrl!)
        webView.load(request)
        title = titleStr
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
}
