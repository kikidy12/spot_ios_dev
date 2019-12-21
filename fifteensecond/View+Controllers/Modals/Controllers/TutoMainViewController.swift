//
//  TutoMainViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 16/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class TutoMainViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tutoImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    let tuto8ImageList:[UIImage?] = [
        UIImage(named: "Iphone8_1"), UIImage(named: "Iphone8_2"), UIImage(named: "Iphone8_3"), UIImage(named: "Iphone8_4"), UIImage(named: "Iphone8_5")
    ]
    
    let tutoXImageList:[UIImage?] = [
        UIImage(named: "IphoneX_1"), UIImage(named: "IphoneX_2"), UIImage(named: "IphoneX_3"), UIImage(named: "IphoneX_4"), UIImage(named: "IphoneX_5")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        pageControl.currentPage = 0
        
        if UIDevice.modelName.contains("10") || UIDevice.modelName.contains("11") {
            tutoImageView.image = tutoXImageList[pageControl.currentPage]
        }
        else {
            tutoImageView.image = tuto8ImageList[pageControl.currentPage]
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    @IBAction func showNextTutoEvent() {
        pageControl.currentPage = pageControl.currentPage + 1
        
        if UIDevice.modelName.contains("10") || UIDevice.modelName.contains("11") {
            tutoImageView.image = tutoXImageList[pageControl.currentPage]
        }
        else {
            tutoImageView.image = tuto8ImageList[pageControl.currentPage]
        }
        
        if pageControl.currentPage == 4 {
            stackView.arrangedSubviews.forEach {
                if $0 == stackView.arrangedSubviews.first, let btn = $0 as? UIButton {
                    btn.setTitle("SPOT 시작하기", for: .normal)
                }
                else {
                    $0.isHidden = true
                }
            }
        }
    }
    
    @IBAction func showLoginViewEvent(_ sender: UIButton) {
        if sender.titleLabel?.text == "SPOT 시작하기" {
            UserDefs.setOpenedApp(false)
        }
        else {
            UserDefs.setOpenedApp(true)
        }

        let navi = UINavigationController(rootViewController: HomeViewController())
        navi.navigationBar.barStyle = .black
        navi.navigationBar.tintColor = .white
        navi.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navi.navigationBar.shadowImage = UIImage()
        UIApplication.shared.keyWindow?.rootViewController = navi
    }
}
