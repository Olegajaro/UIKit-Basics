//
//  BadgeSupplementaryView.swift
//  CompositionalLayout
//
//  Created by Олег Федоров on 31.03.2022.
//

import UIKit

class BadgeSupplementaryView: UICollectionViewCell {
    
    static let reuseId = "BadgeReuseId"
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            configureBorder()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            configureBorder()
        }
    }
}

extension BadgeSupplementaryView {
    private func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .label
        backgroundColor = .systemGreen
        configureBorder()
    }
    
    private func configureBorder() {
        let radius = bounds.width / 2.0
        layer.cornerRadius = radius
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
    }
}
