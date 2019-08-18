//
//  Extensions+Objects.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//


import UIKit
import Foundation

extension UIImage {
    func toBase64() -> String? {
        let imageData = self.jpegData(compressionQuality: 1.0)
        return imageData?.base64EncodedString() ?? nil
    }
}


extension UIColor {
    
    @nonobjc class var darkblue: UIColor {
        return UIColor(red: 30.0 / 255.0, green: 35.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var peachyPink: UIColor {
        return UIColor(red: 1.0, green: 152.0 / 255.0, blue: 134.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkishPink: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 54.0 / 255.0, blue: 116.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var steel: UIColor {
        return UIColor(red: 119.0 / 255.0, green: 125.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }
}
