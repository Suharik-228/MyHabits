//
//  InfoViewController.swift
//  MyHabits2
//
//  Created by Suharik on 28.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Информация"
        view.backgroundColor = .white
        view.addSubview(textView)
        setupLayout()
    }
    
    var textView: UITextView = {
        let text = UITextView()
        text.textColor = .black
        text.isEditable = false
        text.font = UIFont.systemFont(ofSize: 17)
        text.text = "\nПривычка за 21 день \n\nПрохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться. \n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
        return text
    }()
    
    func setupLayout(){
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}
