//
//  DetailImageCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 10/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class DetailImageCollectionViewCell: UICollectionViewCell {
    
    var image: ImageDatas!
    @IBOutlet weak var imaegView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initView(_ data: ImageDatas) {
        image = data
        if let str = image.imageURL {
            imaegView.kf.setImage(with: URL(string: str), placeholder: UIImage(named: "placeholderImage"))
        }
    }

}
