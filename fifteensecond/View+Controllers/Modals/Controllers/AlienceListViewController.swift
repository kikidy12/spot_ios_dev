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

class AlienceListViewController: UIViewController {
    
    var categoryType: AlienceTitles!
    
    var alienceArray = NSArray() {
        didSet {
            alienceTableView.reloadData()
        }
    }
    
    var categoryList = [CategoryDatas]() {
        didSet {
            if !categoryList.isEmpty {
                categoryList.insert(CategoryDatas(name: "전체"), at: 0)
            }
            categoryColletionView.reloadData()
        }
    }
    
    @IBOutlet weak var categoryColletionView: UICollectionView!
    @IBOutlet weak var recommandColletionView: UICollectionView!
    @IBOutlet weak var alienceTableView: UITableView!
    
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

    
}

extension AlienceListViewController: UITableViewDelegate, UITableViewDataSource {
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
        self.show(vc, sender: nil)
    }
    
}

extension AlienceListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryColletionView {
            return categoryList.count
        }
        else {
            return 10
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
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommandCell", for: indexPath) as! RecommandCollectionViewCell
            
            return cell
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
            getAliences(categoryId: categoryList[indexPath.item].id)
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
    
    func getAliences(categoryId: Int) {
        guard let type = categoryType else { return }
        let parameters = [
            "latitude": 37.562899,
            "longitude": 127.064770,
            "sort_type": "name",
            "category_id": categoryId
        ] as Parameters
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
            }
        }
    }
}
