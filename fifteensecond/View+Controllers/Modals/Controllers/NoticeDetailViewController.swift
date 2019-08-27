//
//  NoticeDetailViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class NoticeDetailViewController: UIViewController {
    
    var notice: NoticeDatas!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "공지사항"
        titleLabel.text = notice.title
        contentLabel.text = notice.content
        dateLabel.text = DateFormatter().showDateStr(notice.createdAt, style: .dot)
    }

}
