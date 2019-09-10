//
//  SpotMarkerInfoWindowView.swift
//  fifteensecond
//
//  Created by 권성민 on 02/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotMarkerInfoWindowView: UIView {
    
    private let xibName = "SpotMarkerInfoWindowView"
    
    var spot: SpotDatas!

    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

    func initView(_ data: SpotDatas) {
        spot = data
        nameLabel.text = spot.name
    }
}
