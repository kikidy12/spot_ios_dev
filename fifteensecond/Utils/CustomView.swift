//
//  CustomView.swift
//  fifteensecond
//
//  Created by 권성민 on 05/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//


import UIKit

@IBDesignable
class BorderView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 1
    }
    
}

@IBDesignable
class HalfRoundedBtton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height/2.0
        self.layer.borderColor = #colorLiteral(red: 0.4156862745, green: 0.7882352941, blue: 0.7921568627, alpha: 1)
        self.layer.borderWidth = 1.0
    }
}

@IBDesignable
class GradientButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.peachyPink.cgColor, UIColor.darkishPink.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
        self.bringSubviewToFront(self.titleLabel!)
    }
}

@IBDesignable
class GradientDarkBlueView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.darkblue.cgColor, UIColor.slate.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
}

@IBDesignable
class GradientHorizentalView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.peachyPink.cgColor, UIColor.darkishPink.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
}

@IBDesignable
class CustomView: UIView {
    
    //Shadow
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    //coner
    @IBInspectable var conerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class CustomImageView: UIImageView {
    
    //Shadow
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    //coner
    @IBInspectable var conerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class CustomButton: UIButton {
    
    //Shadow
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    //coner
    @IBInspectable var conerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}


@IBDesignable
class CustomLabel: UILabel {
    @IBInspectable var underLine: Bool = false {
        didSet {
            if underLine {
                guard let text = text else { return }
                let textRange = NSMakeRange(0, text.count)
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
                // Add other attributes if needed
                self.attributedText = attributedText
            }
        }
    }
}
