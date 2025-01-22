//
//  StatisticsCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 22.01.2025.
//

import UIKit

final class StatisticsCell: UITableViewCell {
    static let reuseIdentifier = "StatisticsCell"
    
    // MARK: - UI Elements
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.frame.size.height = 90
        view.frame.size.width = UIScreen.main.bounds.width - 32
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .trackerBlack
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statisticsTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .trackerBlack
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        statisticsTypeLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        addSubview(cardView)
        cardView.addGradient()
        cardView.addSubview(valueLabel)
        cardView.addSubview(statisticsTypeLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topAnchorTable),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingAnchorTable),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailingAnchorTable),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.bottomAnchorTable),
            
            valueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.leadingLabel),
            valueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: Constants.trailingLabel),
            valueLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.topLabel),
            
            statisticsTypeLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: Constants.topSubLabel),
            statisticsTypeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.leadingLabel),
            statisticsTypeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: Constants.trailingLabel)
        ])
    }
    
    // MARK: - Public Methods
    
    func configCell(for cell: StatisticsCell, with indexPath: IndexPath, statistics: [TrackerStatistics]) {
        cell.valueLabel.text = String(statistics[indexPath.row].value)
        cell.statisticsTypeLabel.text = statistics[indexPath.row].statisticsType.statisticTitle
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
}
