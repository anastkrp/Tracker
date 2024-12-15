//
//  TrackerAdjustCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 07.12.2024.
//

import UIKit

final class TrackerAdjustCell: UITableViewCell {
    static let reuseIdentifier = "TrackerAdjustCell"
    
    private let adjustLabel = ["Категория", "Расписание"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.textColor = .trackerGray
        detailTextLabel?.font = .systemFont(ofSize: 17)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    func configCell(for cell: TrackerAdjustCell, with indexPath: IndexPath, detailText: [String]) {
        cell.textLabel?.text = adjustLabel[indexPath.row]
        cell.detailTextLabel?.text = detailText[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .trackerBackground
    }
}
