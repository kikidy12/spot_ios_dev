//
//  AlienceListViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

enum SortType: String {
    case name = "Sort by Name"
    case distance = "Sort by Distance"
    case discount = "Sort by Discount"
}

class AlienceListViewController: UIViewController {
    
    var categoryType: AlienceTitles!
    
    var sortType: SortType = .name
    
    var selectedCategory: CategoryDatas!
    
    var locManager = CLLocationManager()
    
    var alienceArray = NSArray() {
        didSet {
            let tempArray = alienceArray.sortedArray { (dict1, dict2) -> ComparisonResult in
                let id1 = (dict1 as! NSDictionary)["id"] as! Int
                let id2 = (dict2 as! NSDictionary)["id"] as! Int
                
                return "\(id1)".compare("\(id2)")
                } as NSArray
            
            premiumArray = tempArray.filter {
                if (($0 as! NSDictionary)["is_premium"] as! Bool) {
                    return true
                }
                else {
                    return false
                }
                } as NSArray
            
            alienceTableView.reloadData()
        }
    }
    
    var premiumArray = NSArray() {
        didSet {
            recommandColletionView.reloadData()
        }
    }
    
    var categoryList = [CategoryDatas]() {
        didSet {
            if !categoryList.isEmpty {
                categoryList.insert(CategoryDatas(name: "전체"), at: 0)
                selectedCategory = categoryList[0]
                getAliences()
            }
            categoryColletionView.reloadData()
        }
    }
    
    @IBOutlet weak var categoryColletionView: UICollectionView!
    @IBOutlet weak var recommandColletionView: UICollectionView!
    @IBOutlet weak var alienceTableView: UITableView!
    @IBOutlet weak var sortTypeView: UIView!
    @IBOutlet weak var sortTypeBtn: UIButton!
    
    @IBOutlet weak var alienceTableHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryColletionView.delegate = self
        categoryColletionView.dataSource = self
        recommandColletionView.delegate = self
        recommandColletionView.dataSource = self
        alienceTableView.delegate = self
        alienceTableView.dataSource = self
        
        categoryColletionView.register(UINib(nibName: "AlienceCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
        recommandColletionView.register(UINib(nibName: "RecommandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "recommandCell")
        
        alienceTableView.register(UINib(nibName: "AlienceTableViewCell", bundle: nil), forCellReuseIdentifier: "alienceCell")
        
        alienceTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        alienceTableView.separatorStyle = .none
        
        getCategorys()
    }
    
    @IBAction func showSortTypeView(_ sender: UIButton) {
        sortTypeView.isHidden = false
    }
    
    @IBAction func selectSortType(_ sender: UIButton) {
        sortTypeView.isHidden = true
        if sender.title(for: .normal) == SortType.name.rawValue {
            sortType = .name
        }
        else if sender.title(for: .normal) == SortType.distance.rawValue {
            sortType = .distance
        }
        else {
            sortType = .discount
        }
        sortTypeBtn.setTitle(sortType.rawValue, for: .normal)
        getAliences()
        sortTypeView.subviews.forEach {
            if let btn = $0 as? UIButton {
                if sortType == .name {
                    if btn.tag == 0 {
                        btn.setTitle(SortType.name.rawValue, for: .normal)
                    }
                    if btn.tag == 1 {
                        btn.setTitle(SortType.distance.rawValue, for: .normal)
                    }
                    if btn.tag == 2 {
                        btn.setTitle(SortType.discount.rawValue, for: .normal)
                    }
                }
                
                if sortType == .discount {
                    if btn.tag == 0 {
                        btn.setTitle(SortType.discount.rawValue, for: .normal)
                    }
                    if btn.tag == 1 {
                        btn.setTitle(SortType.name.rawValue, for: .normal)
                    }
                    if btn.tag == 2 {
                        btn.setTitle(SortType.distance.rawValue, for: .normal)
                    }
                }
                
                if sortType == .distance {
                    if btn.tag == 0 {
                        btn.setTitle(SortType.distance.rawValue, for: .normal)
                    }
                    if btn.tag == 1 {
                        btn.setTitle(SortType.discount.rawValue, for: .normal)
                    }
                    if btn.tag == 2 {
                        btn.setTitle(SortType.name.rawValue, for: .normal)
                    }
                }
            }
        }
    }
    
    
}

extension AlienceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            alienceTableHeightConstraint.constant = cell.frame.height * CGFloat(alienceArray.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alienceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alienceCell", for: indexPath) as! AlienceTableViewCell
        cell.initView(type: categoryType, data: alienceArray[indexPath.item] as! NSDictionary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlienceInfoListViewController()
        vc.type = categoryType
        if let dict = alienceArray[indexPath.item] as? NSDictionary {
            vc.alienceId = (dict["id"] as! Int)
        }
        parent?.title = categoryType.rawValue
        self.show(vc, sender: nil)
    }
    
}

extension AlienceListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryColletionView {
            return categoryList.count
        }
        else if collectionView == recommandColletionView {
            return premiumArray.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryColletionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! AlienceCategoryCollectionViewCell
            let data = categoryList[indexPath.item]
            if !data.isSelect {
                cell.gradient.isHidden = true
                cell.categoryView.borderWidth = 1
                cell.categoryView.backgroundColor = .clear
                cell.categoryLabel.textColor = .darkishPink
            }
            else {
                cell.gradient.isHidden = false
                cell.categoryView.borderWidth = 0
                cell.categoryView.backgroundColor = .darkishPink
                cell.categoryLabel.textColor = .white
            }
            cell.categoryLabel.text = data.name
            return cell
        }
        else if collectionView == recommandColletionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommandCell", for: indexPath) as! RecommandCollectionViewCell
            cell.initView(type: categoryType, data: premiumArray[indexPath.item] as! NSDictionary)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryColletionView {
            let label = UILabel(frame: CGRect.zero)
            label.text = categoryList[indexPath.item].name
            label.sizeToFit()
            return CGSize(width: label.frame.width + 30, height: collectionView.frame.height)
        }
        else {
            return CGSize(width: 163, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryColletionView {
            categoryList.forEach {
                if categoryList[indexPath.item] == $0 {
                    $0.isSelect = true
                }
                else {
                    $0.isSelect = false
                }
            }
            categoryColletionView.reloadData()
            selectedCategory = categoryList[indexPath.item]
            getAliences()
        }
        
        if collectionView == recommandColletionView {
            let vc = AlienceInfoListViewController()
            vc.type = categoryType
            if let dict = premiumArray[indexPath.item] as? NSDictionary {
                vc.alienceId = (dict["id"] as! Int)
            }
            parent?.title = categoryType.rawValue
            self.show(vc, sender: nil)
        }
    }
}


extension AlienceListViewController {
    func getCategorys() {
        guard let type = categoryType else { return }
        ServerUtil.shared.getCategorys(self, type: type) { (success, dict, message) in
            guard success, let array = dict?["category"] as? NSArray else { return }
            self.categoryList = array.compactMap{ CategoryDatas($0 as! NSDictionary) }
        }
    }
    
    func getAliences() {
        sortTypeView.isHidden = true
        guard let type = categoryType else { return }
        //수정 필요
        var parameters = [
            "latitude": locManager.location!.coordinate.latitude,
            "longitude": locManager.location!.coordinate.longitude,
            "category_id": selectedCategory.id!
        ] as Parameters
        
        if sortType == .distance {
            parameters["sort_type"] = "distance"
        }
        else if sortType == .discount {
            parameters["sort_type"] = "discount"
        }
        else {
            parameters["sort_type"] = "name"
        }
        ServerUtil.shared.getAliences(self, type: type, parameters: parameters) { (success, dict, message) in
            guard success, let data = dict else { return }
            
            switch type {
            case .restaurant:
                self.alienceArray = data["restaurant"] as? NSArray ?? NSArray()
                break
            case .shopping:
                self.alienceArray = data["shopping_mall"] as? NSArray ?? NSArray()
                break
            case .tickets:
                self.alienceArray = data["ticket"] as? NSArray ?? NSArray()
                break
            case .hotel:
                self.alienceArray = data["hotel"] as? NSArray ?? NSArray()
                break
            case .play:
                self.alienceArray = data["play"] as? NSArray ?? NSArray()
            case .beauty:
                self.alienceArray = data["beauty"] as? NSArray ?? NSArray()
            }
            
        }
    }
}
