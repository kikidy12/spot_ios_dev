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
    @IBOutlet weak var tutoLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    let tutoSet: [[String:UIImage]] = [
        ["클릭 한 번으로 내주변 먹거리,\n축제 , 호텔 정보를 결제부터 이용까지!":UIImage(named: "tuto1")!],
        ["내주변 먹거리 , 쇼핑 ,티켓, 숙소,\n15Seconds 한번에 알아보기!":UIImage(named: "tuto2")!],
        ["15Seconds로 영화같은\n나만의 영상 촬영하기":UIImage(named: "tuto3")!],
        ["내주변 15Seconds\n위치 확인하기":UIImage(named: "tuto4")!],
        ["촬영한 영상을 편집한 뒤\nSNS에 자랑하기":UIImage(named: "tuto5")!]
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        setText(tutoSet[0].keys.first!)
        tutoImageView.image = tutoSet[0].values.first!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setText(_ str: String) {
        let attributedString = NSMutableAttributedString(string: str)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        tutoLabel.attributedText = attributedString
    }

    @IBAction func showNextTutoEvent() {
        pageControl.currentPage = pageControl.currentPage + 1
        setText(tutoSet[pageControl.currentPage].keys.first!)
        tutoImageView.image = tutoSet[pageControl.currentPage].values.first!
        
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
