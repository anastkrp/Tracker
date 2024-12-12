//
//  String+Extension.swift
//  Tracker
//
//  Created by Anastasiia Ki on 04.12.2024.
//

extension String {
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
