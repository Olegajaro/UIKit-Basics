//
//  ViewController.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import UIKit

class ViewController: UIViewController {

    var arrayExercise = [Exercise]()
    var arrayButtons = [Button]()
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createExercise(exName: .jumping)
        createExercise(exName: .squats)
        createExercise(exName: .benchPress)
        runExercise()
        
        createButton(type: .standart)
        createButton(type: .cancel)
        createButton(type: .rounded)
        setup()
    }

    func createExercise(exName: Exercises) {
        let newExercise = FactoryExercises.shared.createExercise(type: exName)
        arrayExercise.append(newExercise)
    }
    
    func runExercise() {
        for ex in arrayExercise {
            ex.start()
            ex.stop()
        }
    }
    
    func createButton(type: ButtonType) {
        let newButton = FactoryButtons.shared.createButton(type: type)
        arrayButtons.append(newButton)
    }
    
    func setup() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        addButtonsTo(stackView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
    }
    
    private func addButtonsTo(_ stackView: UIStackView) {
        for button in arrayButtons {
            button.configureButton()
            guard let button = button as? UIButton else { return }
            stackView.addArrangedSubview(button)
        }
    }
}

