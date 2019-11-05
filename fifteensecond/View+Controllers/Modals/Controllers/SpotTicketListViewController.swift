//
//  SpotTicketListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 03/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotTicketListViewController: UIViewController {
    
    var selectItem: SpotTicketDatas!
    
    var spotTicketList = [SpotTicketDatas]() {
        didSet {
            spotTicketTableView.reloadData()
        }
    }
    
    @IBOutlet weak var spotTicketTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Sdfsdfsd")
        spotTicketTableView.register(UINib(nibName: "SpotTicketTableViewCell", bundle: nil), forCellReuseIdentifier: "ticketCell")
        spotTicketTableView.delegate = self
        spotTicketTableView.dataSource = self
        getTicketList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "이용권 구매하기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func buyTicketEvent() {
        let vc = SelectPayTypeViewController()
//        vc.spotTicket = selectItem
        show(vc, sender: nil)
    }
}

extension SpotTicketListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spotTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! SpotTicketTableViewCell
        cell.initView(spotTicketList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem = spotTicketList[indexPath.item]
    }
}

extension SpotTicketListViewController {
    func getTicketList() {
        ServerUtil.shared.getSpotTicketKind(self) { (success, dict, message) in
            guard success, let array = dict?["spot_ticket_kinds"] as? NSArray else {
                return
            }
            
            self.spotTicketList = array.compactMap { SpotTicketDatas($0 as! NSDictionary)}
        }
    }
}
