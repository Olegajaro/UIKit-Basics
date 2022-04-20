//
//  Header.swift
//  UICollectionViewFlowLayout
//
//  Created by Олег Федоров on 01.04.2022.
//

import UIKit

class Header: UICollectionViewCell {
    
    static let headerReuseId = "HeaderReuseId"
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        textLabel = label
        textLabel.textAlignment = .center
        textLabel.text = "Header"
        
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
