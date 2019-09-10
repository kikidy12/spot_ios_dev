//
//  HotelInfoListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 18/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class AlienceInfoListViewController: UIViewController {
    
    var type:AlienceTitles = .restaurant
    var alienceId: Int!
    var locationManager = CLLocationManager()
    
    var linkURL = ""
    
    var imageList = [ImageDatas]() {
        didSet {
            if let firstImageStr = imageList.first?.imageURL {
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
    
    
    var facilityList = [String]() {
        didSet {
            var str = ""
            facilityList.forEach {
                if facilityList.last == $0 {
                    str += "\($0)"
                }
                else {
                    str += "\($0), "
                }
            }
            facilityLabel.text = str
        }
    }
    
    var restaurant: RestaurantDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = false
            siteView.isHidden = true
            hotelView.isHidden = true
            ticketView.isHidden = true
            alienceMenuTableView.isHidden = false
            nameLabel.text = restaurant.name
            commentLabel.text = ""
            openTimeLabel.text = restaurant.openTime
            categoryLabel.text = restaurant.category.name
            addressLabel.text = restaurant.address
            linkURL = restaurant.linkUrl ?? ""
            imageList = restaurant.imageList
            alienceMenuTableView.reloadData()
        }
    }
    
    var hotel: HotelDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = true
            siteView.isHidden = false
            hotelView.isHidden = false
            ticketView.isHidden = true
            alienceMenuTableView.isHidden = true
            nameLabel.text = hotel.name
            commentLabel.text = hotel.comment ?? ""
            openTimeLabel.isHidden = true
            categoryLabel.text = hotel.category.name
            addressLabel.text = hotel.address
            linkURL = hotel.linkURL ?? ""
            imageList = hotel.imageList
            hotelRoomTableView.reloadData()
        }
    }
    
    var ticket: TicketDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = true
            siteView.isHidden = true
            ticketView.isHidden = false
            hotelView.isHidden = true
            alienceMenuTableView.isHidden = true
            nameLabel.text = ticket.name
            commentLabel.text = ""
            openTimeLabel.text = ticket.openTime
            categoryLabel.text = ticket.category.name
            addressLabel.text = ticket.address
            linkURL = ticket.linkUrl ?? ""
            imageList = ticket.imageList
            facilityList = ticket.facilityList.compactMap { $0.name }
            print(ticket.kindList.count)
            ticketKindTableView.reloadData()
        }
    }
    
    var shopping: ShoppingDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = true
            siteView.isHidden = true
            ticketView.isHidden = true
            alienceMenuTableView.isHidden = false
            nameLabel.text = shopping.name
            commentLabel.text = ""
            openTimeLabel.text = shopping.openTime
            categoryLabel.text = shopping.category.name
            addressLabel.text = shopping.address
            commentLabel.text = shopping.comment
            linkURL = shopping.linkUrl ?? ""
            imageList = shopping.imageList
            alienceMenuTableView.reloadData()
        }
    }
    
    var hotelMenuList = [String]()
    
    
    @IBOutlet weak var ticketView: UIView!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var alienceMenuTableView: UITableView!
    @IBOutlet weak var ticketKindTableView: UITableView!
    @IBOutlet weak var hotelRoomTableView: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var siteView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBarSetting()
        alienceMenuTableView.delegate = self
        alienceMenuTableView.dataSource = self
        ticketKindTableView.delegate = self
        ticketKindTableView.dataSource = self
        ticketKindTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        hotelRoomTableView.delegate = self
        hotelRoomTableView.dataSource = self
        hotelRoomTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        
        alienceMenuTableView.register(UINib(nibName: "RestaurantMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "restaurantCell")
        alienceMenuTableView.register(UINib(nibName: "ShoppingMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "shoppingCell")
        ticketKindTableView.register(UINib(nibName: "AlienceTicketTableViewCell", bundle: nil), forCellReuseIdentifier: "kindCell")
        imageCollectionView.register(UINib(nibName: "AlienceInfoImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        hotelRoomTableView.register(UINib(nibName: "HotelRoomInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "roomCell")
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
    
    @IBAction func callEventByBtn(sender: UIButton) {
        phoneCall(hotel.phoneNum)
    }
    
    @IBAction func locationEvent(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch type {
            case .restaurant:
                openNaverNavi(lat: restaurant.location.latitude, lng: restaurant.location.longitude)
                break
            case .shopping:
                openNaverNavi(lat: shopping.location.latitude, lng: shopping.location.longitude)
                break
            case .tickets:
                openNaverNavi(lat: ticket.location.latitude, lng: ticket.location.longitude)
                break
            case .hotel:
//                openNaverNavi(lat: hotel.location.latitude, lng: hotel.location.longitude)
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
        cell.initView(imageStr: imageList[indexPath.item].imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 141, height: 141)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageListPopupViewController()
        vc.imageList = self.imageList
        showPopupView(vc: vc)
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
            return ticket?.kindList.count ?? 0
        case .hotel:
            return hotel?.roomList.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .hotel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! HotelRoomInfoTableViewCell
            cell.initView(hotel.roomList[indexPath.item])
            return cell
        case .restaurant:
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
            cell.initView(restaurant.menuList[indexPath.item])
            return cell
        case .shopping:
            let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ShoppingMenuTableViewCell
            cell.initView(shopping.menuList[indexPath.item])
            return cell
        case .tickets:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kindCell", for: indexPath) as! AlienceTicketTableViewCell
            cell.initView(ticket.kindList[indexPath.item])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .hotel {
            let vc = ImageListPopupViewController()
            vc.imageList = self.imageList
            showPopupView(vc: vc)
        }
    }
    
}

extension AlienceInfoListViewController {
    func getAlienceInfo() {
        guard let id = alienceId else { return }
        var parameters = [
            "latitude": locationManager.location!.coordinate.latitude,
            "longitude": locationManager.location!.coordinate.longitude
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
            
            if let data = dict?["hotel"] as? NSDictionary {
                self.hotel = HotelDatas(data)
            }
        }
    }
}
