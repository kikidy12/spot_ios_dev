//
//  HotelInfoListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 18/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceInfoListViewController: UIViewController {
    
    var type:AlienceTitles = .restaurant
    var alienceId: Int!
    
    var linkURL = ""
    
    var imageList = [String]() {
        didSet {
            if let firstImageStr = imageList.first {
                let url = URL(string: firstImageStr)
                mainImageView.kf.setImage(with: url)
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = mainImageView.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                mainImageView.addSubview(blurEffectView)
            }
            imageCollectionView.reloadData()
        }
    }
    
    var restaurant: RestaurantDatas! {
        didSet {
            ticketView.isHidden = true
            alienceMenuTableView.isHidden = false
            nameLabel.text = restaurant.name
            commentLabel.text = ""
            openTimeLabel.text = restaurant.openTime
            categoryLabel.text = restaurant.category.name
            addressLabel.text = restaurant.address
            linkURL = restaurant.linkUrl ?? ""
            imageList = restaurant.imageList.compactMap { $0.imageURL }
            alienceMenuTableView.reloadData()
        }
    }
    
    var hotel: HotelDatas! {
        didSet {
            ticketView.isHidden = true
            alienceMenuTableView.isHidden = false
        }
    }
    
    var ticket: TicketDatas! {
        didSet {
            ticketView.isHidden = false
            alienceMenuTableView.isHidden = true
            nameLabel.text = ticket.name
            commentLabel.text = ""
            openTimeLabel.text = ticket.openTime
            categoryLabel.text = ticket.category.name
            addressLabel.text = ticket.address
            linkURL = ticket.linkUrl ?? ""
            imageList = ticket.imageList.compactMap { $0.imageURL }
        }
    }
    
    var shopping: ShoppingDatas! {
        didSet {
            ticketView.isHidden = true
            alienceMenuTableView.isHidden = false
            nameLabel.text = shopping.name
            commentLabel.text = ""
            openTimeLabel.text = shopping.openTime
            categoryLabel.text = shopping.category.name
            addressLabel.text = shopping.address
            commentLabel.text = shopping.comment
            linkURL = shopping.linkUrl ?? ""
            imageList = shopping.imageList.compactMap { $0.imageURL }
            alienceMenuTableView.reloadData()
        }
    }
    
    var hotelMenuList = [String]()
    
    
    @IBOutlet weak var ticketView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var alienceMenuTableView: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBarSetting()
        alienceMenuTableView.delegate = self
        alienceMenuTableView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        
        alienceMenuTableView.register(UINib(nibName: "RestaurantMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "restaurantCell")
        imageCollectionView.register(UINib(nibName: "AlienceInfoImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        alienceMenuTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        getAlienceInfo()
    }
    
    @IBAction func callEvent(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch type {
            case .restaurant:
                let vc = RestaurantCallPopupViewController()
                vc.restaurant = self.restaurant
                showPopupView(vc: vc)
                break
            case .shopping:
                break
            case .tickets:
                break
            case .hotel:
                break
            }
        }
    }
    
    @IBAction func buyTicketEvent(_ sender: UIButton) {
        let vc = BuyTicketPopupViewController()
        vc.ticket = self.ticket
        showPopupView(vc: vc)
    }
    
    func naviBarSetting() {
        
        let shareBtn = UIButton()
        shareBtn.addTarget(self, action: #selector(shareLink), for: .touchUpInside)
        shareBtn.setBackgroundImage(UIImage(named: "shareBtn"), for: .normal)
        let shareBarItem = UIBarButtonItem(customView: shareBtn)
        shareBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        shareBarItem.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
        shareBarItem.customView?.widthAnchor.constraint(equalToConstant: 26).isActive = true
        navigationItem.rightBarButtonItem = shareBarItem
    }
    
    @objc func shareLink() {
        guard !linkURL.isEmpty else {
            AlertHandler.shared.showAlert(vc: self, message: "연결된 링크가 없습니다.", okTitle: "확인")
            return
        }
        let activityVC = UIActivityViewController(activityItems: [linkURL], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension AlienceInfoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AlienceInfoImageCollectionViewCell
        cell.initView(imageStr: imageList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 141, height: 141)
    }
}

extension AlienceInfoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .restaurant:
            return restaurant?.menuList.count ?? 0
        case .shopping:
            return shopping?.menuList.count ?? 0
        case .tickets:
            return 0
        case .hotel:
            return hotelMenuList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .hotel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
            return cell
        case .restaurant:
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
            cell.initView(restaurant.menuList[indexPath.item])
            return cell
        case .shopping:
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
            return cell
        case .tickets:
            return UITableViewCell()
        }
    }
    
    
}

extension AlienceInfoListViewController {
    func getAlienceInfo() {
        guard let id = alienceId else { return }
        var parameters = [
            "latitude": 37.562899,
            "longitude": 127.064770
        ] as [String:Any]
        
        switch type {
        case .restaurant:
            parameters["restaurant_id"] = id
        case .shopping:
            parameters["shopping_id"] = id
        case .tickets:
            parameters["ticket_id"] = id
        case .hotel:
            parameters["hotel_id"] = id
        }
        ServerUtil.shared.getDetails(self, type: type, parameters: parameters) { (success, dict, message) in
            guard success else { return }
            
            if let data = dict?["restaurant"] as? NSDictionary {
                self.restaurant = RestaurantDatas(data)
            }
            
            if let data = dict?["shopping"] as? NSDictionary {
                self.shopping = ShoppingDatas(data)
            }
            
            if let data = dict?["ticket"] as? NSDictionary {
                self.ticket = TicketDatas(data)
            }
        }
    }
}
