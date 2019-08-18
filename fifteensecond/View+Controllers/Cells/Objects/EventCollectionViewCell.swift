//
//  EventCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 08/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {
    
    var event: EventDatas!
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func initView(_ data: EventDatas) {
        event = data
        
        if let urlStr = event.imgaeURL, let url = URL(string: urlStr) {
            imageView.kf.setImage(with: url)
        }
    }
}
