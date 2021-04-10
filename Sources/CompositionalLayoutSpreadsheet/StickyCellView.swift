//
//  StickyCellView.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import UIKit

class StickyCellView: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func configure(
        attributedText: NSAttributedString,
        backgroundColor: UIColor,
        borderWith: CGFloat,
        borderColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        layer.borderWidth = borderWith
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        label.attributedText = attributedText
        label.textAlignment = .center
    }
}
