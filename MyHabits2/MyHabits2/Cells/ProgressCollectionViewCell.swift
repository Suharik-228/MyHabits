//
//  ProgressCollectionViewCell.swift
//  MyHabits2
//
//  Created by Suharik on 06.05.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var progressNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Так держать!"
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var progressProcentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var progressLine: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar )
        progress.trackTintColor = .systemGray2
        progress.progressTintColor = .systemPurple
        progress.backgroundColor = .white
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 3
        progress.subviews[1].clipsToBounds = true
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        setupContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        progressLine.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressProcentLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        setupLayout()
    }
    
    private func setupLayout() {
        progressNameLabel.translatesAutoresizingMaskIntoConstraints = false
        progressProcentLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLine.translatesAutoresizingMaskIntoConstraints = false
        [progressNameLabel, progressProcentLabel, progressLine].forEach {contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            progressNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            progressProcentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressProcentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            progressLine.topAnchor.constraint(equalTo: progressNameLabel.bottomAnchor, constant: 10),
            progressLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            progressLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            progressLine.heightAnchor.constraint(equalToConstant: 12 / 2),
        ])
    }
}
