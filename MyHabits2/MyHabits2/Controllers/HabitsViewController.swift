//
//  HabitsViewController.swift
//  MyHabits2
//
//  Created by Suharik on 28.04.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    var habit: Habit?
    
    static var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 22, left: 0, bottom: 12, right: 0)
        return layout
    }()
    
    var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: HabitsViewController.layout)
        collection.backgroundColor = .systemGray5
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Сегодня"
        view.backgroundColor = .systemGray5
        navigationItem.setRightBarButton(addButton(image: "plus", selector: #selector(buttonAddAction), reverse: true), animated: true)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        collectionView.dataSource = self
        collectionView.delegate = self
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView].forEach {view.addSubview($0)}
        NSLayoutConstraint.activate([
                                        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func addButton(image: String, selector: Selector, reverse: Bool) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemPurple
        button.setTitleColor(.systemPurple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    @objc private func buttonAddAction() {
        let rootVC = HabitViewController(habit)
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
    }
    
}
extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sectionsCount = 0
        switch section {
        case 0:
            sectionsCount = 1
        case 1:
            sectionsCount = HabitsStore.shared.habits.count
        default:
            break
        }
        return sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as? ProgressCollectionViewCell else { return UICollectionViewCell() }
            cell.setupContent()
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
            cell.setConfigureOfCell(habit: HabitsStore.shared.habits[indexPath.row])
            cell.habitCheckerAction = { [weak self] in
                self?.collectionView.reloadData()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath != [0,0] else { return }
        let habitDetailsViewController = HabitDetailsViewController(HabitsStore.shared.habits[indexPath.row])
        navigationController?.pushViewController(habitDetailsViewController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 60
        case 1:
            height = 130
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 32), height: height)
    }
}
