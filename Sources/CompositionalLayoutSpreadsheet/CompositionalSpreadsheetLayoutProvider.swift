//
//  CompositionalSpreadsheetLayoutProvider.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import UIKit

class CompositionalSpreadsheetLayoutProvider {
    let cellWidth: CGFloat
    let cellHeight: CGFloat
    let numberOfDataRows: CGFloat
    let numberOfDataColumns: CGFloat
    let stickyColumnElementKind: String

    private var columnHeight: CGFloat {
        return numberOfDataRows * cellHeight
    }
    
    private var contentWidth: CGFloat {
        return numberOfDataColumns * cellWidth
    }
    
    private var scrollingWidth: CGFloat {
        return contentWidth - 2 * cellWidth
    }

    required init(
        cellWidth: CGFloat,
        cellHeight: CGFloat,
        numberOfDataRows: Int,
        numberOfDataColumns: Int,
        stickyColumnElementKind: String
    ) {
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.numberOfDataRows = CGFloat(numberOfDataRows)
        self.numberOfDataColumns = CGFloat(numberOfDataColumns)
        self.stickyColumnElementKind = stickyColumnElementKind
    }
    
    var layout: UICollectionViewCompositionalLayout {
        // Sticky column
        let stickyColumnCellSize = NSCollectionLayoutSize(
            widthDimension: .absolute(cellWidth),
            heightDimension: .absolute(columnHeight)
        )
        let stickyColumn = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: stickyColumnCellSize,
            elementKind: stickyColumnElementKind,
            alignment: .leading,
            absoluteOffset: CGPoint(x: -cellWidth, y: 0)
        )
        stickyColumn.pinToVisibleBounds = true
        stickyColumn.zIndex = 2
        
        // Item cell
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(cellWidth),
            heightDimension: .absolute(cellHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(cellWidth * CGFloat(numberOfDataColumns)),
            heightDimension: .absolute(cellHeight)
        )
        var groups: [NSCollectionLayoutGroup] = []
        for _ in 0..<Int(numberOfDataRows) {
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: horizontalGroupSize,
                subitem: item,
                count: Int(numberOfDataColumns)
            )
            groups.append(group)
        }

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(cellWidth * (numberOfDataColumns + 1)),
            heightDimension: .absolute(columnHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: groups
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [stickyColumn]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: cellWidth, bottom: 0, trailing: -cellWidth)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
