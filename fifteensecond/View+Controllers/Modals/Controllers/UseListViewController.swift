//
//  UseListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class UseListViewController: UIViewController {
    
    var useSpotList = [SpotTicketUseInfoDatas]() {
        didSet {
            useListTableView.reloadData()
        }
    }
    
    @IBOutlet weak var useListTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        useListTableView.register(UINib(nibName: "UseListTableViewCell", bundle: nil), forCellReuseIdentifier: "useCell")
        useListTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        useListTableView.delegate = self
        useListTableView.dataSource = self
        
        getUseList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "이용내역"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
}


extension UseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useSpotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "useCell", for: indexPath) as! UseListTableViewCell
        cell.initView(useSpotList[indexPath.item])
        return cell
    }
    
    
}


extension UseListViewController {
    func getUseList() {
        ServerUtil.shared.getSpotHistory(self) { (success, dict, message) in
            guard success, let array = dict?["history"] as? NSArray else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "", okTitle: "확인")
                return }
            
            self.useSpotList = array.compactMap { SpotTicketUseInfoDatas($0 as! NSDictionary) }
        }
    }
}
