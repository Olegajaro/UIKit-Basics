//
//  ViewController.swift
//  ExAbstractFactory
//
//  Created by Олег Федоров on 12.05.2022.
//

import UIKit

class ViewController: UIViewController {

    private let acousticGuitarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "acustic")
        return imageView
    }()
    
    private let orderAcousticGuitarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Order an acoustic guitar", for: .normal)
        button.addTarget(self,
                         action: #selector(orderAcoustic),
                         for: .touchUpInside)
        return button
    }()
    
    private let electroGuitarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "electro")
        return imageView
    }()

    private let orderElectroGuitarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Order an electric guitar", for: .normal)
        button.addTarget(self,
                         action: #selector(orderElectro),
                         for: .touchUpInside)
        return button
    }()
    
    var guitar: Guitar?
    var bass: BassGuitar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        view.addSubview(acousticGuitarImageView)
        view.addSubview(orderAcousticGuitarButton)
        view.addSubview(electroGuitarImageView)
        view.addSubview(orderElectroGuitarButton)
        
        NSLayoutConstraint.activate([
            acousticGuitarImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50
            ),
            acousticGuitarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            acousticGuitarImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2),
            acousticGuitarImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        NSLayoutConstraint.activate([
            orderAcousticGuitarButton.topAnchor.constraint(
                equalTo: acousticGuitarImageView.bottomAnchor, constant: 8
            ),
            orderAcousticGuitarButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            orderAcousticGuitarButton.widthAnchor.constraint(
                equalTo: acousticGuitarImageView.widthAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            electroGuitarImageView.topAnchor.constraint(
                equalTo: orderAcousticGuitarButton.bottomAnchor, constant: 32
            ),
            electroGuitarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            electroGuitarImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2),
            electroGuitarImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        NSLayoutConstraint.activate([
            orderElectroGuitarButton.topAnchor.constraint(
                equalTo: electroGuitarImageView.bottomAnchor, constant: 8
            ),
            orderElectroGuitarButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            orderElectroGuitarButton.widthAnchor.constraint(
                equalTo: electroGuitarImageView.widthAnchor
            )
        ])
    }
}

extension ViewController {
    @objc private func orderAcoustic() {
        guitar = AcousticFactory().createGuitar()
        bass = AcousticFactory().createBass()
    }
    
    @objc private func orderElectro() {
        guitar = ElectroFactory().createGuitar()
        bass = ElectroFactory().createBass()
    }
}
