//
//  AlienceTicketTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 10/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceTicketTableViewCell: UITableViewCell {
    
    var kind: TicketKindDatas!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: TicketKindDatas) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        kind = data
        nameLabel.text = kind.name
        priceLabel.text = "\(formatter.string(for: kind.price) ?? "0")원"
    }
}
