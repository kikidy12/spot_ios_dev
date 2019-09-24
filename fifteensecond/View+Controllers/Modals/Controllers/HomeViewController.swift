//
//  HomeViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 08/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var mainEventList = [EventDatas]() {
        didSet {
            eventCollectionView.reloadData()
        }
    }
    var subEventList = [EventDatas]() {
        didSet {
            allianceCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var attandAlertview: UIView!
    @IBOutlet weak var pageControl: CustomPageControl!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var allianceCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBarBtns()
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        allianceCollectionView.delegate = self
        allianceCollectionView.dataSource = self
        
        eventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "eventColletionCell")
        
        allianceCollectionView.register(UINib(nibName: "AllienceCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        allianceCollectionView.register(UINib(nibName: "AllienceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "allienceColletionCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    
    @IBAction func showAttandView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.attandAlertview.isHidden = true
            self.showPopupView(vc: AttendanceCheckViewController())
        }
    }
    
    @IBAction func showAlienceListView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let vc = AlienceMainViewController()
            vc.childViewType = .List
            switch sender.view!.tag {
            case 0:
                vc.titleString = .restaurant
                break
            case 1:
                vc.titleString = .shopping
                break
            case 2:
                vc.titleString = .tickets
                break
            case 4:
                vc.titleString = .hotel
                break
            default:
                break
            }
            title = " "
            self.show(vc, sender: nil)
        }
    }
    
    @IBAction func showMyPageView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.show(MyPageMainViewController(), sender: nil)
        }
    }
    
    @IBAction func show15SecondView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            show(SpotMapViewController(), sender: nil)
        }
    }
    
    @IBAction func hideAttandAlertView(sender: UIButton) {
        attandAlertview.isHidden = true
    }
    
    @objc func showMapView() {
        let vc = AlienceMainViewController()
        vc.childViewType = .Map
        vc.titleString = .restaurant
        show(vc, sender: nil)
    }
    
    func setNaviBarBtns() {
        title = " "
        let titleImageView = UIImageView(image: UIImage(named: "login_logo"))
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.widthAnchor.constraint(equalToConstant: 73).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleImageView.contentMode = .scaleToFill
        self.navigationItem.titleView = titleImageView
        self.navigationItem.hidesBackButton = true
        
        let rightBtn = UIBarButtonItem(image: UIImage(named: "mainSpotTicket"), style: .plain, target: self, action: #selector(goToSpotTicketList))
        
        let leftBtn = UIBarButtonItem(title: "MAP", style: .plain, target: self, action: #selector(showMapView))
        
        navigationItem.leftBarButtonItem = leftBtn
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc func goToSpotTicketList() {
        let vc = HasSpotTicketListViewController()
        show(vc, sender: nil)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            pageControl.numberOfPages = mainEventList.count
            return mainEventList.count
        }
        else {
            return subEventList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == allianceCollectionView {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
//            headerView.frame = CGRect(x: 0, y: 0, width: 150, height: collectionView.frame.width)
            return headerView
        }
        else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == allianceCollectionView {
            return CGSize(width: 95, height: collectionView.frame.width)
        }
        else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventColletionCell", for: indexPath) as! EventCollectionViewCell
            cell.initView(mainEventList[indexPath.item])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allienceColletionCell", for: indexPath) as! AllienceCollectionViewCell
            cell.initView(subEventList[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == eventCollectionView {
            return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
        }
        else {
            return CGSize(width: 215, height: collectionView.frame.height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == eventCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == eventCollectionView, pageControl.currentPage == indexPath.row {
            pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == eventCollectionView {
            showViewByType(mainEventList[indexPath.item])
        }
        else if collectionView == allianceCollectionView {
            showViewByType(subEventList[indexPath.item])
        }
    }
    
    func showViewByType(_ event: EventDatas) {
        if event.linkType == .OUT {
            if let urlStr = event.linkURL, let url = URL(string: urlStr) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        else {
            if let inType = event.inType, let id = event.inTypeId {
                let vc = AlienceInfoListViewController()
                vc.type = inType
                vc.alienceId = id
                self.title = inType.rawValue
                self.show(vc, sender: nil)
            }
        }
        
    }
}

extension HomeViewController {
    func getMainEvents() {
        ServerUtil.shared.getMainEvent(self) { (success, dict, message) in
            guard success else { return }
            self.getSubEvents()
            
            if let array = dict?["main_event"] as? NSArray {
                self.mainEventList = array.compactMap{ EventDatas($0 as! NSDictionary)}
            }
        }
    }
    
    func getSubEvents() {
        ServerUtil.shared.getSubEvent(self) { (success, dict, message) in
            guard success, let array = dict?["sub_event"] as? NSArray else { return }
            
            self.subEventList = array.compactMap{ EventDatas($0 as! NSDictionary)}
        }
    }
    
    func getUserInfo() {
        let parameters = [
            "os": "iOS",
            "device_token": GlobalDatas.deviceToken
        ] as [String:Any]
        
        ServerUtil.shared.getInfo(self, parameters: parameters) { (success, dict, message) in
            guard success, let isAttend = dict?["today_attendance"] as? Bool,
                let user = dict?["user"] as? NSDictionary else { return }
            
            GlobalDatas.currentUser = UserData(user, isAttend: isAttend)
            
            if isAttend {
                self.attandAlertview.isHidden = true
            }
            else {
                self.attandAlertview.isHidden = false
            }
            
            self.getMainEvents()
        }
    }
}
