//
//  AlienceInfoImageCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 19/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceInfoImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initView(imageStr: String) {
        coverImageView.kf.setImage(with: URL(string: imageStr), placeholder: UIImage(named: "placeholderImage"))
    }
}
