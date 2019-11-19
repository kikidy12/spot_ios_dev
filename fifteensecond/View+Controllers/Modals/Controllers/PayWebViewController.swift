//
//  PayWebViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/19.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class PayWebViewController: UIViewController {
    
    var backColor: UIColor!
    
    let contentController = WKUserContentController()
    let config = WKWebViewConfiguration()
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let count = GlobalDatas.spotTicketBuyDict["count"] as? Int, count != 0, let type = GlobalDatas.spotTicketBuyDict["type"] as? PayType else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let urlStr = "http://ec2-13-125-252-197.ap-northeast-2.compute.amazonaws.com/payment/?user_id=" + "\(GlobalDatas.currentUser.id!)" + "&count=" + "\(count)" + "&paymethod=" + "\(type.rawValue)"
        
//        guard let url = URL(string: urlStr) else { return }
//        let safariViewController = SFSafariViewController(url: url)
//        safariViewController.delegate = self
//        present(safariViewController, animated: true, completion: nil)
        
        webView.configuration.userContentController = contentController
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.allowsBackForwardNavigationGestures = true
        let request = URLRequest(url: URL(string: urlStr)!)
        webView.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "결제하기"
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

extension PayWebViewController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("jsMessage: ", message)
        if message.name == "callbackHandler" {
            print(message.body)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        AlertHandler.shared.showAlert(vc: self, message: message, okTitle: "확인")
        completionHandler()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, let scheme = url.scheme {
            if !["http", "https", "mailto", "c4project"].contains(where: { $0.caseInsensitiveCompare(scheme) == .orderedSame }) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        if navigationAction.request.url?.scheme == "c4project" {
            if let vc = self.navigationController?.viewControllers.first(where: { $0 is CouponsViewController}) {
                self.navigationController?.popToViewController(vc, animated: true)
            }
            else {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}

extension PayWebViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        if let vc = self.navigationController?.viewControllers.first(where: { $0 is CouponsViewController}) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
        else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print(URL.absoluteString)
    }
}
