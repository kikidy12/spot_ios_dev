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
        dateLabel.text = DateFormatter().showDateStr(notice.createdAt, style: .dot)
        
    }
}
