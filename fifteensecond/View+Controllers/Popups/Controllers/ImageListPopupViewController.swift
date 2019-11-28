//
//  ImageListPopupViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 10/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class ImageListPopupViewController: UIViewController {
    
    var imageList = [ImageDatas]()
    
    var index = 0
    
    var isScrolled = false
    
    @IBOutlet weak var imageCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageList.forEach {
            print("imageId: ", $0.id)
        }
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UINib(nibName: "DetailImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isScrolled && imageCollectionView.visibleCells.count > 0 {
            isScrolled = true
            imageCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
        }
    }

    @IBAction func testEvetn() {
        imageCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ImageListPopupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! DetailImageCollectionViewCell
        
        cell.initView(imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
