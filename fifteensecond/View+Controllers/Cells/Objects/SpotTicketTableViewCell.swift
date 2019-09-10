//
//  SoptTicketTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 03/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotTicketTableViewCell: UITableViewCell {
    
    var spotTicket: SpotTicketDatas!
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isSelectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            containerView.layer.borderColor = UIColor.darkishPink.cgColor
            containerView.backgroundColor = .white10
            isSelectImageView.image = #imageLiteral(resourceName: "darkpinkcircle")
        }
        else {
            containerView.layer.borderColor = UIColor.steel.cgColor
            containerView.backgroundColor = .clear
            isSelectImageView.image = UIImage(named: "emptyCircle")
        }
    }
    
    func initView(_ data: SpotTicketDatas) {
        spotTicket = data
        nameLabel.text = spotTicket.name
        priceLabel.text = "가격 : \(spotTicket.price ?? 0)원"
    }
    
}
