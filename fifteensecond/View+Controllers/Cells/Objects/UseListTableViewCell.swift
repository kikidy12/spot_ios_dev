//
//  UseListTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class UseListTableViewCell: UITableViewCell {
    
    var spotTicket: SpotTicketDatas!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var useTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initView(_ data: SpotTicketDatas) {
        spotTicket = data
        
        addressLabel.text = spotTicket.spot.address
        useTimeLabel.text = DateFormatter().showDateStr(spotTicket.usedTime)
        
        let foramtter = NumberFormatter()
        foramtter.numberStyle = .decimal
        priceLabel.text = "\(foramtter.string(for: spotTicket.price) ?? "0")원"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
