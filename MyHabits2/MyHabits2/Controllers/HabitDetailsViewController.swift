//
//  HabitDetailsViewController.swift
//  MyHabits2
//
//  Created by Suharik on 30.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let habit: Habit
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .systemGray5
        self.navigationController?.navigationBar.barTintColor = .white
        navigationItem.setRightBarButton(editButton(title: "Править", selector: #selector(editHabit), reverse: true) , animated: true)
        navigationItem.setLeftBarButton(cancelButton(title: "❮ Сегодня", selector: #selector(tapToCancel), reverse: true) , animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.systemPurple
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        createTable()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = habit.name
    }
    
    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let name = UILabel()
        var text = "Активность"
        name.text = text.uppercased()
        name.font = .systemFont(ofSize: 17)
        name.textColor = .systemGray
        return name
    }()
    
    func setupLayout(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        [nameLabel, tableView].forEach {view.addSubview($0)}
        NSLayoutConstraint.activate([
                                        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    
    func editButton(title: String, selector: Selector, reverse: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.setTitleColor(.systemPurple, for: .normal)
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    func cancelButton(title: String, selector: Selector, reverse: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.setTitleColor(.systemPurple, for: .normal)
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    @objc func editHabit() {
        navigationController?.pushViewController(HabitViewController(habit), animated: true)
    }
    
    @objc func tapToCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func createTable() {
        tableView.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self), for: indexPath) as? HabitDetailsTableViewCell else { return UITableViewCell() }
        let date = HabitsStore.shared.dates[indexPath.row]
        cell.setConfigureOfCell(index: indexPath.row, check: HabitsStore.shared.habit(habit, isTrackedIn: date))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
