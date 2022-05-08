//
//  HabitDetailsTableViewCell.swift
//  MyHabits2
//
//  Created by Suharik on 06.05.2022.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var checkmark: UIButton = {
        let check = UIButton()
        check.setImage(UIImage(systemName: "checkmark"), for: .normal)
        check.tintColor = .systemPurple
        return check
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        [dateLabel, checkmark].forEach {contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            checkmark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkmark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func setConfigureOfCell(index: Int, check: Bool) {
        dateLabel.text = HabitsStore.shared.trackDateString(forIndex: index)
        checkmark.isHidden = !check
    }
}
