//
//  BorderButton.swift
//  Set
//
//  Created by Олег Федоров on 14.04.2022.
//

import UIKit

@IBDesignable class BorderButton: UIButton {
    
    private struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 4.0
        static let borderColor: UIColor = .systemYellow
    }

    @IBInspectable var borderColor: UIColor = Constants.borderColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = Constants.borderWidth {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = Constants.cornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
}
