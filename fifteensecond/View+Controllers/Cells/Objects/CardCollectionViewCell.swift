//
//  CardCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 02/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var cardInfo: CardDatas!

    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var cardInfoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initView(_ data: CardDatas) {
        cardInfo = data
        cardInfoLabel.text = "\(cardInfo.name ?? "미확인") \(cardInfo.cardNum ?? "******1234")"
        setbackColor(cardStr: cardInfo.name)
    }
    
    func setbackColor(cardStr: String) {
        if cardStr == CardInfoEnum.shinhanCard.rawValue {
            customView.backgroundColor = .dodgerBlue
        }
        else if cardStr == CardInfoEnum.kakaoCard.rawValue {
            customView.backgroundColor = .sunflowerYellow
        }
        else if cardStr == CardInfoEnum.ibkCard.rawValue {
            customView.backgroundColor = .oceanBlue
        }
        else if cardStr == CardInfoEnum.wooriCard.rawValue {
            customView.backgroundColor = .cerulean
        }
        else if cardStr == CardInfoEnum.nonghyeopCard.rawValue {
            customView.backgroundColor = .viridian
        }
        else if cardStr == CardInfoEnum.kbCard.rawValue {
            customView.backgroundColor = .warmGrey
        }
        else if cardStr == CardInfoEnum.hanaCard.rawValue {
            customView.backgroundColor = .tealish
        }
        else {
            customView.backgroundColor = .lightBlueGreyThree
        }
    }

}
