//
//  FacilityCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 10/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class FacilityCollectionViewCell: UICollectionViewCell {
    
    var facility: FacilityDatas!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initView(_ data: FacilityDatas) {
        facility = data
        
        if let urlStr = facility.imgUrl, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            imageView.kf.setImage(with: url)
        }
        
        nameLabel.text = facility.name
    }
}
