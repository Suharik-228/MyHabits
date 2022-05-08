//
//  HabitCollectionViewCell.swift
//  MyHabits2
//
//  Created by Suharik on 06.05.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit?
    var habitCheckerAction: (()->())?
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var habitSelectedTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var habitCounter: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    lazy var checker: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(tapOnChecker), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setConfigureOfCell(habit: Habit) {
        self.habit = habit
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitSelectedTimeLabel.text = habit.dateString
        checker.tintColor = habit.color
        habitCounter.text = "Счётчик: " + String(habit.trackDates.count)
        
        if habit.isAlreadyTakenToday == true {
            checker.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            checker.isUserInteractionEnabled = false
        } else {
            self.checker.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            checker.isUserInteractionEnabled = true
        }
        setupLayout()
    }
    
    private func setupLayout() {
        habitNameLabel.translatesAutoresizingMaskIntoConstraints = false
        habitSelectedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        habitCounter.translatesAutoresizingMaskIntoConstraints = false
        checker.translatesAutoresizingMaskIntoConstraints = false
        [habitNameLabel, habitSelectedTimeLabel, habitCounter, checker].forEach {contentView.addSubview($0)}
        NSLayoutConstraint.activate([
                                        
                                        habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                                        habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                        
                                        habitSelectedTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 5),
                                        habitSelectedTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                                        
                                        checker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                        checker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                        checker.widthAnchor.constraint(equalToConstant: 30),
                                        checker.heightAnchor.constraint(equalToConstant: 30),
                                        
                                        habitCounter.topAnchor.constraint(equalTo: checker.bottomAnchor, constant: 10),
                                        habitCounter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)])
    }
    
    @objc func tapOnChecker() {
        guard let trackedHabit = habit else { return }
        HabitsStore.shared.track(trackedHabit)
        habitCheckerAction?()
    }
}
