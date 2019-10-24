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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = titleStr
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.barStyle = .default
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .white
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.standardAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.tintColor = .black
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.barStyle = .black
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.tintColor = .white
        }
        
    }
}
