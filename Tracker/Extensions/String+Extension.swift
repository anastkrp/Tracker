//
//  String+Extension.swift
//  Tracker
//
//  Created by Anastasiia Ki on 04.12.2024.
//

import UIKit

extension String {
    
    var hexColor: UIColor {
        var rgbValue:UInt64 = 0
        Scanner(string: self).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func correctDay() -> String {
        let count = Int(self) ?? 0
        
        if count == 0 {
            return "0 дней"
        }

        if count % 100 >= 11 && count % 100 <= 19 {
            return "\(count) дней"
        }

        switch count % 10 {
            case 1:
            return "\(count) день"
        case 2...4:
            return "\(count) дня"
        default:
            return "\(count) дней"
        }
    }
}
