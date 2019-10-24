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
    
    
    var facilityList = [FacilityDatas]() {
        didSet {
            print("fcCount:",facilityList.count)
            facilityCollectionView.reloadData()
        }
    }
    
    var promotionList = [PromotionDatas]() {
        didSet {
            if promotionList.isEmpty {
                promotionView.isHidden = true
            }
            else {
                promotionView.isHidden = false
            }
            promotionTableView.reloadData()
        }
    }
    
    var restaurant: RestaurantDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = false
            siteView.isHidden = true
            hasFacilityView.isHidden = true
            menuView.isHidden = false
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
    
    var beauty: BeautyDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = false
            siteView.isHidden = true
            hasFacilityView.isHidden = true
            menuView.isHidden = false
            nameLabel.text = beauty.name
            commentLabel.text = ""
            openTimeLabel.text = beauty.openTime
            categoryLabel.text = beauty.category.name
            addressLabel.text = beauty.address
            linkURL = beauty.linkUrl ?? ""
            imageList = beauty.imageList
            alienceMenuTableView.reloadData()
        }
    }
    
    var play: PlayDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = false
            siteView.isHidden = true
            hasFacilityView.isHidden = true
            menuView.isHidden = false
            nameLabel.text = play.name
            commentLabel.text = ""
            openTimeLabel.text = play.openTime
            categoryLabel.text = play.category.name
            addressLabel.text = play.address
            linkURL = play.linkUrl ?? ""
            imageList = play.imageList
            alienceMenuTableView.reloadData()
        }
    }
    
    var hotel: HotelDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = true
            siteView.isHidden = false
            hasFacilityView.isHidden = false
            menuView.isHidden = true
            nameLabel.text = hotel.name
            commentLabel.text = hotel.comment ?? ""
            openTimeLabel.isHidden = true
            categoryLabel.text = hotel.category.name
            addressLabel.text = hotel.address
            linkURL = hotel.linkURL ?? ""
            imageList = hotel.imageList
            facilityList = hotel.facilityList
            hasFacilityMenuTableView.reloadData()
        }
    }
    
    var ticket: TicketDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = true
            siteView.isHidden = true
            hasFacilityView.isHidden = false
            menuView.isHidden = true
            nameLabel.text = ticket.name
            commentLabel.text = ""
            openTimeLabel.text = ticket.openTime
            categoryLabel.text = ticket.category.name
            addressLabel.text = ticket.address
            linkURL = ticket.linkUrl ?? ""
            imageList = ticket.imageList
            facilityList = ticket.facilityList
            hasFacilityMenuTableView.reloadData()
        }
    }
    
    var shopping: ShoppingDatas! {
        didSet {
            locationView.isHidden = false
            callView.isHidden = true
            siteView.isHidden = true
            menuView.isHidden = false
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
    
    
    @IBOutlet weak var hasFacilityView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var promotionView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var alienceMenuTableView: UITableView!
    @IBOutlet weak var hasFacilityMenuTableView: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var facilityCollectionView: UICollectionView!
    
    @IBOutlet weak var useBtn: UIButton!
    @IBOutlet weak var useView: UIView!
    
    @IBOutlet weak var hasFacilityTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var promotionTableView: UITableView!
    @IBOutlet weak var promotionTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var siteView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        naviBarSetting()
        facilityCollectionView.delegate = self
        facilityCollectionView.dataSource = self
        alienceMenuTableView.delegate = self
        alienceMenuTableView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        hasFacilityMenuTableView.delegate = self
        hasFacilityMenuTableView.dataSource = self
        promotionTableView.delegate = self
        promotionTableView.dataSource = self
        hasFacilityMenuTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        
        alienceMenuTableView.register(UINib(nibName: "RestaurantMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "restaurantCell")
        alienceMenuTableView.register(UINib(nibName: "ShoppingMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "shoppingCell")
        imageCollectionView.register(UINib(nibName: "AlienceInfoImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        hasFacilityMenuTableView.register(UINib(nibName: "HotelRoomInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "roomCell")
        hasFacilityMenuTableView.register(UINib(nibName: "AlienceTicketTableViewCell", bundle: nil), forCellReuseIdentifier: "ticketCell")
        facilityCollectionView.register(UINib(nibName: "FacilityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "facilityCell")
        alienceMenuTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        promotionTableView.register(UINib(nibName: "PromotionTableViewCell", bundle: nil), forCellReuseIdentifier: "promotionCell")
        promotionTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        getAlienceInfo()
    }
    
    @IBAction func callEvent(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch type {
            case .restaurant:
                phoneCall(restaurant.phoneNum)
                break
            case .shopping:
                break
            case .tickets:
                break
            case .hotel:
                break
            case .play:
                phoneCall(play.phoneNum)
                break
            case .beauty:
                phoneCall(beauty.phoneNum)
                break
            }
        }
    }
    
    @IBAction func useBtnEvent(_ sender: UIButton) {
        switch type {
        case .restaurant:
            break
        case .shopping:
            break
        case .tickets:
            let vc = BuyTicketPopupViewController()
            vc.ticket = self.ticket
            showPopupView(vc: vc)
            break
        case .hotel:
            phoneCall(hotel.phoneNum)
            break
        case .play:
            break
        case .beauty:
            break
        }
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
                openNaverNavi(lat: hotel.location.latitude, lng: hotel.location.longitude)
                break
            case .play:
                openNaverNavi(lat: play.location.latitude, lng: hotel.location.longitude)
                break
            case .beauty:
                openNaverNavi(lat: beauty.location.latitude, lng: hotel.location.longitude)
                break
            }
        }
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
        activityVC.modalPresentationStyle = .fullScreen
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension AlienceInfoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            return imageList.count
        }
        else if collectionView == facilityCollectionView {
            return facilityList.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imageCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AlienceInfoImageCollectionViewCell
            cell.initView(imageStr: imageList[indexPath.item].imageURL)
            return cell
        case facilityCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facilityCell", for: indexPath) as! FacilityCollectionViewCell
            cell.initView(facilityList[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case imageCollectionView:
            return CGSize(width: 141, height: 141)
        case facilityCollectionView:
            return CGSize(width: 65, height: 50)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case imageCollectionView:
            let vc = ImageListPopupViewController()
            vc.imageList = self.imageList
            showPopupView(vc: vc)
            break
        default:
            print("error")
        }
        
    }
    
}

extension AlienceInfoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == promotionTableView {
            if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
                promotionTableViewHeightConstraint.constant = cell.frame.height * CGFloat(promotionList.count)
            }
        }
        else if tableView == hasFacilityMenuTableView {
            if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
                if type == .hotel {
                    hasFacilityTableHeightConstraint.constant = cell.frame.height * CGFloat(hotel.roomList.count)
                }
                else if type == .tickets {
                    hasFacilityTableHeightConstraint.constant = cell.frame.height * CGFloat(ticket.kindList.count)
                }
            }
        }
        else {
            if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
                if type == .restaurant {
                    menuTableHeightConstraint.constant = cell.frame.height * CGFloat(restaurant.menuList.count)
                }
                else if type == .play {
                    menuTableHeightConstraint.constant = cell.frame.height * CGFloat(play.menuList.count)
                }
                else if type == .beauty {
                    menuTableHeightConstraint.constant = cell.frame.height * CGFloat(beauty.menuList.count)
                }
                else if type == .shopping {
                    menuTableHeightConstraint.constant = cell.frame.height * CGFloat(shopping.menuList.count)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == promotionTableView {
            return promotionList.count
        }
        else {
            switch type {
            case .restaurant:
                return restaurant?.menuList.count ?? 0
            case .shopping:
                return shopping?.menuList.count ?? 0
            case .tickets:
                return ticket?.kindList.count ?? 0
            case .hotel:
                return hotel?.roomList.count ?? 0
            case .play:
                return play?.menuList.count ?? 0
            case .beauty:
                return beauty?.menuList.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == promotionTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell", for: indexPath) as! PromotionTableViewCell
            cell.initView(promotionList[indexPath.item])
            return cell
        }
        else {
            switch type {
            case .hotel:
                let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! HotelRoomInfoTableViewCell
                cell.initView(hotel.roomList[indexPath.item])
                return cell
            case .restaurant:
                let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
                cell.initView(restaurant: restaurant.menuList[indexPath.item])
                return cell
            case .shopping:
                let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ShoppingMenuTableViewCell
                cell.initView(shopping.menuList[indexPath.item])
                return cell
            case .tickets:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! AlienceTicketTableViewCell
                cell.initView(ticket.kindList[indexPath.item])
                return cell
            case .play:
                let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
                cell.initView(play: play.menuList[indexPath.item])
                return cell
            case .beauty:
                let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantMenuTableViewCell
                cell.initView(beauty: beauty.menuList[indexPath.item])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .hotel {
            let vc = ImageListPopupViewController()
            vc.imageList = hotel.roomList[indexPath.item].imageList
            showPopupView(vc: vc)
        }
        
        if tableView == promotionTableView {
            let vc = RestaurantPopUpViewController()
            vc.promotion = promotionList[indexPath.item]
            vc.type = type
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
        useView.isHidden = true
        switch type {
        case .restaurant:
            parameters["restaurant_id"] = id
            break
        case .shopping:
            parameters["shopping_id"] = id
            break
        case .tickets:
            useView.isHidden = false
            useBtn.setTitle("구매하기", for: .normal)
            parameters["ticket_id"] = id
            break
        case .hotel:
            useView.isHidden = false
            useBtn.setTitle("전화하기", for: .normal)
            parameters["hotel_id"] = id
            break
        case .play:
            parameters["play_id"] = id
            break
        case .beauty:
            parameters["beauty_id"] = id
            break
        }
        ServerUtil.shared.getDetails(self, type: type, parameters: parameters) { (success, dict, message) in
            guard success else { return }
            
            if let promotions = dict?["promotion_menu"] as? NSArray {
                self.promotionList = promotions.compactMap({PromotionDatas($0 as! NSDictionary)})
            }
            
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
            
            if let data = dict?["play"] as? NSDictionary {
                self.play = PlayDatas(data)
            }
            
            if let data = dict?["beauty"] as? NSDictionary {
                self.beauty = BeautyDatas(data)
            }
        }
    }
}
