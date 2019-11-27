//
//  UseListTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class UseListTableViewCell: UITableViewCell {
    
    var spotTicketUseInfo: SpotUseLogData!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var useTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initView(_ data: SpotUseLogData) {
        spotTicketUseInfo = data
        
        addressLabel.text = spotTicketUseInfo.spot.address
        useTimeLabel.text = "이용일자 \(DateFormatter().showDateStr(spotTicketUseInfo.createAt, style: .dot))"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
