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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initView(_ data: FacilityDatas) {
        facility = data
    }
}
