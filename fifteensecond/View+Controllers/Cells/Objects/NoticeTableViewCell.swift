//
//  NoticeTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    var notice: NoticeDatas!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: NoticeDatas) {
        notice = data
        
        titleLabel.text = notice.title
        
        if let createdAt = notice.createdAt {
            print(createdAt)
            let year = Calendar.current.component(.year, from: createdAt)
            let month = Calendar.current.component(.month, from: createdAt)
            let day = Calendar.current.component(.day, from: createdAt)
            print(year)
            print(month)
            print(day)
            dateLabel.text = "\(year).\(month).\(day)"
        }
        
    }
}
