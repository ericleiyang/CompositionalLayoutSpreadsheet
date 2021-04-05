//
//  ValueCell.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import UIKit

class ValueCell: UICollectionViewCell {
    let label = UILabel()
    static let reuseIdentifier = "value-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

}

extension ValueCell {
    func configure(
        text: NSAttributedString,
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
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
