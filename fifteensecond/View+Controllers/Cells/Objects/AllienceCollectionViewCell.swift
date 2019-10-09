//
//  AllienceCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AllienceCollectionViewCell: UICollectionViewCell {
    
    var event: EventDatas!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func initView(_ data: EventDatas) {
        event = data
        if let urlStr = event.imgaeURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            imageView.kf.setImage(with: url)
        }
    }
}
