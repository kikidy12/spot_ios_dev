//
//  AlienceCategoryCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceCategoryCollectionViewCell: UICollectionViewCell {
    
    let gradient = CAGradientLayer()
    
    @IBOutlet weak var categoryView: CustomView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradient.colors = [UIColor.peachyPink.cgColor, UIColor.darkishPink.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.frame = categoryView.frame
        categoryView.layer.addSublayer(gradient)
        categoryView.bringSubviewToFront(categoryLabel)
    }
    

}
