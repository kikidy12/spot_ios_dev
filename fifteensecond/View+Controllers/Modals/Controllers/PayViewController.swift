//
//  PayViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 02/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {
    
    var count = 1
    
    var cardList = [CardDatas]() {
        didSet {
            if cardList.isEmpty {
                
            }
            else {
                
            }
            
            cardCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: CustomPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardCell")
        
        // width, height 설정
        let cellWidth:CGFloat = 277
        
        // 상하, 좌우 inset value 설정
        let insetX = (UIScreen.main.bounds.width - cellWidth) / 2.0
        print(UIScreen.main.bounds.width)
        print(cardCollectionView.bounds.width)
        print(insetX)
        
        let layout = cardCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cardCollectionView.frame.height)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        cardCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "결제하기"
//        getCardList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func registCardEvent() {
        show(RegistCardViewController(), sender: nil)
    }
}

extension PayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = cardList.count
        return cardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        cell.initView(cardList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        AlertHandler.shared.showAlert(vc: self, message: "15Seconds 이용권 \(count)장을\n구매하시겠습니까?", okTitle: "확인", cancelTitle: "취소", okHandler: { (_) in
            self.registedCardPay(cardId: self.cardList[indexPath.item].id)
        })
    }
}

extension PayViewController : UIScrollViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let layout = self.cardCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = cardCollectionView.contentOffset
        visibleRect.size = cardCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = cardCollectionView.indexPathForItem(at: visiblePoint) else { return }
        pageControl.currentPage = indexPath.item
    }
}

extension PayViewController {
    func getCardList() {
        ServerUtil.shared.getCardRegistration(self) { (success, dict, message) in
            guard success, let array = dict?["user_card"] as? NSArray else {
                return
            }
            
            self.cardList = array.compactMap { CardDatas($0 as! NSDictionary) }
        }
    }
    
    func registedCardPay(cardId: Int) {
        let parameters = [
            "user_card_id": cardId,
            "count": count
        ] as [String:Any]
        ServerUtil.shared.postPayment(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "", okTitle: "확인")
                return
            }
            
            if let vc = self.navigationController?.viewControllers.last(where: {$0 is BuySpotTicketViewController}) {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}
