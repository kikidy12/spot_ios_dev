//
//  AlienceListTileView.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceListTileView: UIView {

    private let xibName = "AlienceListTileView"
    
    var showAndHidtStackViewClouser: (()->())!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updownArrowImageView: UIImageView!
    
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
    @IBAction func showAndHideStackViewEvent(_ sender: UIButton) {
        showAndHidtStackViewClouser()
    }
}
