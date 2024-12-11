//
//  WeekdayCellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 10.12.2024.
//

import UIKit

protocol WeekdayCellDelegate: AnyObject {
    func didSelectWeekday(_ cell: WeekdayCell)
    func didDeselectWeekday(_ cell: WeekdayCell)
}
