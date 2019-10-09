//
//  ShoppingMenuTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 03/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class ShoppingMenuTableViewCell: UITableViewCell {
    
    var mall: ShoppingMenuDatas!
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var isFavorBtn: CustomButton!
    @IBOutlet weak var discountRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: ShoppingMenuDatas) {
        mall = data
        if mall.isHot {
            isFavorBtn.isHidden = false
        }
        else {
            isFavorBtn.isHidden = false
        }
        
        if let urlStr = mall.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            titleImageView.kf.setImage(with: url)
        }
        
        nameLabel.text = mall.name
        commentLabel.text = mall.comment
    }
}
