//
//  WeekdayCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 08.12.2024.
//

import UIKit

final class WeekdayCell: UITableViewCell {
    static let reuseIdentifier = "WeekdayCell"
    weak var delegate: WeekdayCellDelegate?
    
    private let weekdayName = Schedule.allCases.map { $0.weekdayFullName }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = false
        switchControl.onTintColor = .trackerBlue
        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switchControl
    }()
    
    func configCell(for cell: WeekdayCell, with indexPath: IndexPath, schedule: [Schedule]) {
        cell.backgroundColor = .trackerBackground
        cell.textLabel?.text = weekdayName[indexPath.row]
        cell.accessoryView = switchControl
        cell.switchControl.isOn = schedule.contains(Schedule.allCases[indexPath.row])
    }
    
    @objc
    private func switchValueChanged() {
        if switchControl.isOn {
            delegate?.didSelectWeekday(self)
        } else {
            delegate?.didDeselectWeekday(self)
        }
    }
}
