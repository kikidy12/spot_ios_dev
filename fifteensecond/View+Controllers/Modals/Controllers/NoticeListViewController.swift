//
//  NoticeListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class NoticeListViewController: UIViewController {
    
    var noticeList = [NoticeDatas]() {
        didSet {
            noticeTableView.reloadData()
        }
    }
    
    @IBOutlet weak var noticeTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTableView.register(UINib(nibName: "NoticeTableViewCell", bundle: nil), forCellReuseIdentifier: "noticeCell")
        
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        noticeTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        title = "공지사항"
        
        getNotice()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
}


extension NoticeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as! NoticeTableViewCell
        
        cell.initView(noticeList[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoticeDetailViewController()
        vc.notice = noticeList[indexPath.item]
        self.show(vc, sender: nil)
    }
}

extension NoticeListViewController {
    func getNotice() {
        ServerUtil.shared.getNotice(self) { (success, dict, message) in
            guard success, let array = dict?["notice"] as? NSArray else { return }
            
            self.noticeList = array.compactMap { NoticeDatas( $0 as! NSDictionary ) }
        }
    }
}
