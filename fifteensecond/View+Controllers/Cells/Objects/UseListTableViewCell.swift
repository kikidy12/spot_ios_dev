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
        if let createdAt = spotTicketUseInfo.createAt {
            print(createdAt)
            let year = Calendar.current.component(.year, from: createdAt)
            let month = Calendar.current.component(.month, from: createdAt)
            let day = Calendar.current.component(.day, from: createdAt)
            print(year)
            print(month)
            print(day)
            useTimeLabel.text = "이용일자 \(year).\(month).\(day)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
