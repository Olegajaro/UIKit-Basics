//
//  TextCell.swift
//  CompositionalLayout
//
//  Created by Олег Федоров on 31.03.2022.
//

import UIKit

// MARK: - Text Cell
class TextCell: UICollectionViewCell {
    
    static let reuseId = "TextCellId"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell
extension TextCell {
    private func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        contentView.addSubview(label)
        
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: inset
            ),
            label.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: inset
            ),
            label.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -inset
            ),
            label.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -inset
            )
        ])
    }
}
