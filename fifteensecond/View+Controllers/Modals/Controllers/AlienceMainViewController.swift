//
//  AlienceMainViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceMainViewController: UIViewController {
    
    enum ChildViewType {
        case List, Map
    }
    
    var childViewType: ChildViewType = .List
    
    var customTitleView: AlienceListTileView!
    
    var titleString: AlienceTitles = .restaurant
    
    var rightBtn: UIBarButtonItem!
    
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviBarBtns()
        titleListSetting()
    }

    func showListViewController() {
        self.children.forEach {
            $0.removeFromParent()
            $0.view.removeFromSuperview()
        }
        let vc = AlienceListViewController()
        vc.categoryType = titleString
        self.addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        childViewType = .List
    }
    
    func showMapViewController() {
        self.children.forEach {
            $0.removeFromParent()
            $0.view.removeFromSuperview()
        }
        let vc = AlienceMapViewController()
        vc.categoryType = titleString
        self.addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        childViewType = .Map
    }
    
    func setNaviBarBtns() {
        customTitleView = AlienceListTileView(frame: CGRect(x: 0, y: 0, width: 150, height: 42))
        customTitleView.translatesAutoresizingMaskIntoConstraints = false
        customTitleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        customTitleView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        self.navigationItem.titleView = customTitleView
        customTitleView.titleLabel.text = titleString.rawValue
        customTitleView.showAndHidtStackViewClouser = {
            if self.titleStackView.isHidden {
                self.titleStackView.isHidden = false
                self.customTitleView.updownArrowImageView.image = UIImage(named: "white_up_arrow")
            }
            else {
                self.titleStackView.isHidden = true
                self.customTitleView.updownArrowImageView.image = UIImage(named: "white_down_arrow")
            }
        }
        
        var rightTitle = "MAP"
        if childViewType == .List {
            rightTitle = "MAP"
        }
        else {
            rightTitle = "LIST"
        }
        rightBtn = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(changeView(sender:)))
        
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc func changeView(sender: UIBarButtonItem) {
        if sender.title == "MAP" {
            self.showMapViewController()
            sender.title = "LIST"
        }
        else {
            self.showListViewController()
            sender.title = "MAP"
        }
    }
    
    func titleListSetting() {
        let tempTitleList = AlienceTitles.allCase.filter {
            if $0 == titleString {
                return false
            }
            else {
                return true
            }
        }
        titleStackView.arrangedSubviews.enumerated().forEach {
            if let btn = $0.element as? UIButton {
                btn.setTitle(tempTitleList[$0.offset].rawValue, for: .normal)
                btn.addTarget(self, action: #selector(selectTitleEvent(sender:)), for: .touchUpInside)
            }
        }
        
        if childViewType == .List {
            showListViewController()
        }
        else {
            showMapViewController()
        }
        
    }

    @objc func selectTitleEvent(sender: UIButton) {
        titleString = AlienceTitles(rawValue: sender.title(for: .normal)!)!
        customTitleView.titleLabel.text = titleString.rawValue
        titleListSetting()
        self.titleStackView.isHidden = true
        self.customTitleView.updownArrowImageView.image = UIImage(named: "white_down_arrow")
    }
}
