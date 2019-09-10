//
//  HasSpotTicketTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 09/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class HasSpotTicketTableViewCell: UITableViewCell {
    
    var hasTicketInfo: SpotTicketUseInfoDatas!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: SpotTicketUseInfoDatas) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy.MM.dd"
        hasTicketInfo = data
        
        nameLabel.text = hasTicketInfo.ticketKind.name
        dueDateLabel.text = "유효기간 : \(dateformatter.string(from: hasTicketInfo.createdAt)) - \(dateformatter.string(from: hasTicketInfo.expireDate))"
    }
}
