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
        if let urlStr = image.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            imaegView.kf.setImage(with: url)
        }
    }

}
