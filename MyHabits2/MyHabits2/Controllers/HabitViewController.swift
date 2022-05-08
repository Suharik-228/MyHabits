//
//  HabitViewController.swift
//  MyHabits2
//
//  Created by Suharik on 28.04.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit?
    var timePicker = UIDatePicker()
    var colorPicker = UIColorPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = (habit == nil) ? "Создать" : "Править"
        navigationItem.setRightBarButton(saveButton(title: "Сохранить", selector: #selector(buttonSaveAction), reverse: true) , animated: true)
        navigationItem.setLeftBarButton(cancelButton(title: "Отменить", selector: #selector(buttonCancelAction), reverse: true) , animated: true)
        nameTextField.delegate = self
        colorPicker.delegate = self
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(HabitViewController.timeChanged), for: .valueChanged)
        if let habit = habit {
            setConfigureOfViewController(habit: habit)
        }
        setupLayout()
    }
    
    var nameLabel: UILabel = {
        let name = UILabel()
        var text = "Название"
        name.text = text.uppercased()
        name.font = .boldSystemFont(ofSize: 13)
        name.textColor = .black
        return name
    }()
    
    var nameTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.leftViewMode = .always
        text.attributedPlaceholder = NSAttributedString.init(string: "Дуит!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3])
        return text
    }()
    
    var colorLabel: UILabel = {
        let color = UILabel()
        var textc = "Цвет"
        color.text = textc.uppercased()
        color.font = .boldSystemFont(ofSize: 13)
        color.textColor = .black
        return color
    }()
    
    var colorButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(buttonColorPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var timeLabel: UILabel = {
        let time = UILabel()
        var text = "Время"
        time.text = text.uppercased()
        time.font = .boldSystemFont(ofSize: 13)
        time.textColor = .black
        return time
    }()
    
    var timeTextField: UITextField = {
        var text = UITextField()
        text.backgroundColor = .white
        text.leftViewMode = .always
        text.text = "Каждый день в"
        text.isEnabled = false
        return text
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(removeHabit), for: .touchUpInside)
        return button
    }()
    
    init(_ habitForEditing: Habit?) {
        super.init(nibName: nil, bundle: nil)
        habit = habitForEditing
        if let habitSource = habit {
            nameTextField.text = habitSource.name
            colorButton.tintColor = habitSource.color
            timePicker.date = habitSource.date
            deleteButton.isHidden = false
        } else {
            deleteButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAddAction() {
        present(HabitViewController(habit), animated: true)
    }
    
    @objc func buttonColorPressed(color: UIColor) {
        present(colorPicker, animated: true, completion: nil)
    }
    
    @objc func timeChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeTextField.text = "Каждый день в \(dateFormatter.string(from: timePicker.date))"
    }
    
    @objc func removeHabit(sender: UIButton!) {
        let name = habit?.name ?? "Unknown"
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(name)?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Отменить", style: .default) { (_) -> Void in }
        let declineAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) -> Void in
            if let removingHabit = self.habit {
                HabitsStore.shared.habits.removeAll(where: {$0 == removingHabit})
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public func setConfigureOfViewController (habit: Habit) {
        self.habit = habit
        self.nameTextField.text = habit.name
        self.colorButton.tintColor = habit.color
        self.timePicker.date = habit.date
    }
    
    func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        [nameLabel, nameTextField, colorLabel, colorButton, timeLabel, timeTextField, timePicker, deleteButton].forEach {view.addSubview($0)}
        NSLayoutConstraint.activate([
                                        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
                                        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 18),
                                        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -18),
                                        
                                        colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
                                        colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 5),
                                        colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 10),
                                        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        timeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
                                        timeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        timePicker.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 5),
                                        timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
                                        
                                        deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                        deleteButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
    }
    
    func cancelButton(title: String, selector: Selector, reverse: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    func saveButton(title: String, selector: Selector, reverse: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        button.setTitleColor(.systemPurple, for: .normal)
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    @objc private func buttonCancelAction() {
        if title == "Править"{
            self.navigationController?.popToRootViewController(animated: true)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func buttonSaveAction() {
        if let currentHabit = habit {
            currentHabit.name = nameTextField.text ?? "Unknown"
            currentHabit.date = timePicker.date
            currentHabit.color = colorButton.tintColor ?? .systemPurple
            HabitsStore.shared.save()
        } else {
            let newHabit = Habit(name: nameTextField.text ?? "Unknown", date: timePicker.date, color: colorButton.tintColor ?? .systemPurple)
            HabitsStore.shared.habits.append(newHabit)
        }
        if title == "Править"{
            self.navigationController?.popToRootViewController(animated: true)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ colorPicker: UIColorPickerViewController) {
        colorButton.tintColor = colorPicker.selectedColor
        colorPicker.dismiss(animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ colorPicker: UIColorPickerViewController) {
        colorButton.tintColor = colorPicker.selectedColor
        colorPicker.dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        view.endEditing(true)
        return true
    }
}



