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

extension Date {
    func dateToString(formatter:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = formatter
        
        return dateForamtter.string(from: self)
    }
}

extension String {
    func stringToDate(formatter:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = formatter
        return dateForamtter.date(from: self)
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
    
    @nonobjc class var lightGreyBlueTwo: UIColor {
        return UIColor(red: 181.0 / 255.0, green: 181.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white14: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.14)
    }
    
    @nonobjc class var veryLightPinkTwo: UIColor {
        return UIColor(white: 209.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var cerulean: UIColor {
        return UIColor(red: 0.0, green: 132.0 / 255.0, blue: 209.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var sunflowerYellow: UIColor {
        return UIColor(red: 1.0, green: 224.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var dodgerBlue: UIColor {
        return UIColor(red: 56.0 / 255.0, green: 162.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var viridian: UIColor {
        return UIColor(red: 34.0 / 255.0, green: 160.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var oceanBlue: UIColor {
        return UIColor(red: 5.0 / 255.0, green: 85.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmGrey: UIColor {
        return UIColor(red: 160.0 / 255.0, green: 142.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tealish: UIColor {
        return UIColor(red: 39.0 / 255.0, green: 198.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightBlueGreyThree: UIColor {
        return UIColor(red: 194.0 / 255.0, green: 203.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPinkThree: UIColor {
        return UIColor(white: 225.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteTwo: UIColor {
        return UIColor(white: 244.0 / 255.0, alpha: 1.0)
    }
}


public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
