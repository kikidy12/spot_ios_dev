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
        webView.scrollView.bounces = false
        let request = URLRequest(url: fileUrl!)
        webView.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = titleStr
        navigationController?.navigationBar.backgroundColor = .darkblue
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
              let statusBarHeight: CGFloat = app.statusBarFrame.size.height
              
              let statusbarView = UIView()
              statusbarView.backgroundColor = UIColor.darkblue
              view.addSubview(statusbarView)
            
              statusbarView.translatesAutoresizingMaskIntoConstraints = false
              statusbarView.heightAnchor
                  .constraint(equalToConstant: statusBarHeight).isActive = true
              statusbarView.widthAnchor
                  .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
              statusbarView.topAnchor
                  .constraint(equalTo: view.topAnchor).isActive = true
              statusbarView.centerXAnchor
                  .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .darkblue
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .clear
        if #available(iOS 13.0, *) {
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .clear
        }
    }
}
