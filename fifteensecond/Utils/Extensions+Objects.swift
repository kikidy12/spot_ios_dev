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

extension DateFormatter {
    
    func showDateStr(_ date: Date, style: DateFormatterStyle = .hypoon) -> String {
        self.dateFormat = "yyyy\(style.rawValue)MM\(style.rawValue)dd"
        return self.string(from: date)
    }
    
    func stringToDate(_ str: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return self.date(from: str)
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
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var steel: UIColor {
        return UIColor(red: 119.0 / 255.0, green: 125.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white10: UIColor {
        return UIColor(white: 1.0, alpha: 0.1)
    }
    
    @nonobjc class var maize: UIColor {
        return UIColor(red: 1.0, green: 201.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightGreyBlue: UIColor {
        return UIColor(red: 165.0 / 255.0, green: 170.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var orangeyRed: UIColor {
        return UIColor(red: 1.0, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tangerine: UIColor {
        return UIColor(red: 1.0, green: 149.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var marigold: UIColor {
        return UIColor(red: 1.0, green: 204.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var weirdGreen: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var robinSEgg: UIColor {
        return UIColor(red: 90.0 / 255.0, green: 200.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deepSkyBlue: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var warmBlue: UIColor {
        return UIColor(red: 88.0 / 255.0, green: 86.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var reddishPink: UIColor {
        return UIColor(red: 1.0, green: 45.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var paleLilac: UIColor {
        return UIColor(red: 229.0 / 255.0, green: 229.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightBlueGrey: UIColor {
        return UIColor(red: 209.0 / 255.0, green: 209.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightBlueGreyTwo: UIColor {
        return UIColor(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueGrey: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var slateGrey: UIColor {
        return UIColor(red: 81.0 / 255.0, green: 86.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 242.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gunmetal: UIColor {
        return UIColor(red: 70.0 / 255.0, green: 76.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var slate: UIColor {
        return UIColor(red: 64.0 / 255.0, green: 73.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0)
    }
    
}
