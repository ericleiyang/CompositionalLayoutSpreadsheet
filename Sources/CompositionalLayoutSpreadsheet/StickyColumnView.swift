//
//  StickColumnView.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import UIKit

class StickColumnView: UICollectionReusableView {

    static let reuseIdentifier = "sticky-column-reuse-identifier"
    static let reuseElementKind = "sticky-column-element-kind"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    func configure(
        stickyColumnDatas: [CellData],
        stickyColumnWidth: CGFloat,
        stickyCellHeight: CGFloat,
        stickyCellBackgroundColor: UIColor,
        stickyCellBorderWidth: CGFloat,
        stickyCellBorderColor: UIColor
    ) {
        for index in 0..<stickyColumnDatas.count {
            let frame = CGRect(
                x: 0,
                y: CGFloat(index) * stickyCellHeight,
                width: stickyColumnWidth,
                height: stickyCellHeight
            )
            let stickyCell = StickyCellView(frame: frame)
            stickyCell.configure(
                attributedText: stickyColumnDatas[index].title,
                backgroundColor: stickyCellBackgroundColor,
                borderWith: stickyCellBorderWidth,
                borderColor: stickyCellBorderColor
            )
            addSubview(stickyCell)
        }
    }
}
