//
//  CompositionalLayoutSpreadsheet.swift
//
//
//  Created by Eric Yang on 5/4/21.
//

import UIKit

public class CompositionalLayoutSpreadsheet {
    // MARK: DATA
    
    /**
     -----------------------------------
     0 |
     -----------------------------------
     1 |
     -----------------------------------
     2 |
     -----------------------------------
      ...
      
        sticky column datas = [0, 1, 2, ...]
     */
    private var stikyColumnDatas: [NSAttributedString] = [] {
        didSet {
            stickyColumnCellDatas = stikyColumnDatas.compactMap{ CellData(title: $0) }
        }
    }
    private var stickyColumnCellDatas: [CellData] = []
    /**
     -----------------------------------
     0 |  00 |  01  | 02 | ...
     -----------------------------------
     1 |  10 |  11  | 12 | ...
     -----------------------------------
      ...
        row datas = [
            [00, 01, 02, ...],
            [10, 11, 12, ...],
            ...
        ]
     */
    private var rowDatas: [[NSAttributedString]] = [] {
        didSet {
            var flatArray: [NSAttributedString] = []
            let columnCount = rowDatas.first?.count ?? 0
            for column in 0..<columnCount {
                for row in 0..<rowDatas.count {
                    flatArray.append(rowDatas[row][column])
                }
            }
            let cellDatas = flatArray.compactMap{ CellData(title: $0) }
            sectionData = SectionData(cells: cellDatas)
        }
    }
    private var sectionData: SectionData?
    
    // MARK: UI
    
    let spreadsheetBackgroundColor: UIColor
    let cellWidth: CGFloat
    let cellHeight: CGFloat
    let cellBorderWidth: CGFloat
    let cellBorderColor: UIColor
    let cellBackgroundColor: UIColor
    let stickyCellBackgroundColor: UIColor
    
    init(
        spreadsheetBackgroundColor: UIColor = .white,
        cellWidth: CGFloat = 100,
        cellHeight: CGFloat = 44,
        cellBorderWidth: CGFloat = 1,
        cellBorderColor: UIColor = .darkGray,
        cellBackgroundColor: UIColor = .white,
        stickyCellBackgroundColor: UIColor = .lightGray
    ) {
        self.spreadsheetBackgroundColor = spreadsheetBackgroundColor
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.cellBorderWidth = cellBorderWidth
        self.cellBorderColor = cellBorderColor
        self.cellBackgroundColor = cellBackgroundColor
        self.stickyCellBackgroundColor = stickyCellBackgroundColor
    }
    
    private var parentView: UIView?
    private var cell: UICollectionViewCell.Type?
    private var cellReuseIdentifier: String?

    // update data
    func update(
        stikyColumnDatas: [NSAttributedString],
        rowDatas: [[NSAttributedString]]
    ) {
        guard let parentView = parentView,
              let cell = cell,
              let cellReuseIdentifier = cellReuseIdentifier else {
            return
        }
        configureHierarchy(
            stikyColumnDatas: stikyColumnDatas,
            rowDatas: rowDatas,
            parentView: parentView,
            cell: cell,
            cellReuseIdentifier: cellReuseIdentifier
        )
    }
    
    func configureHierarchy(
        stikyColumnDatas: [NSAttributedString],
        rowDatas: [[NSAttributedString]],
        parentView: UIView,
        cell: UICollectionViewCell.Type = ValueCell.self,
        cellReuseIdentifier: String = ValueCell.reuseIdentifier
    ) {
        self.stikyColumnDatas = stikyColumnDatas
        self.rowDatas = rowDatas
        if let collectionView = collectionView {
            collectionView.removeFromSuperview()
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            cell,
            forCellWithReuseIdentifier: cellReuseIdentifier
        )
        collectionView.register(
            StickColumnView.self,
            forSupplementaryViewOfKind: StickColumnView.reuseElementKind,
            withReuseIdentifier: StickColumnView.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = spreadsheetBackgroundColor
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor)
        ])
        configureDataSource()
        updateDataSource()
    }

    // MARK: UICollectionView
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionData, CellData>! = nil
    private var layoutProvider: CompositionalSpreadsheetLayoutProvider!

    private func createLayout() -> UICollectionViewCompositionalLayout {
        layoutProvider = CompositionalSpreadsheetLayoutProvider(
            cellWidth: cellWidth,
            cellHeight: cellHeight,
            numberOfDataRows: rowDatas.count,
            numberOfDataColumns: rowDatas.first?.count ?? 0,
            stickyColumnElementKind: StickColumnView.reuseElementKind
        )
        return layoutProvider.layout
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionData, CellData>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, data: CellData) -> UICollectionViewCell? in
            // Return the cell.
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ValueCell.reuseIdentifier, for: indexPath) as? ValueCell else {
                return nil
            }
            cell.configure(
                text: data.title,
                backgroundColor: self.cellBackgroundColor,
                borderWith: self.cellBorderWidth,
                borderColor: self.cellBorderColor
            )
            return cell
        }

        dataSource.supplementaryViewProvider = {(
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath
        ) -> UICollectionReusableView? in
            guard let stickColumnView = collectionView.dequeueReusableSupplementaryView(
                ofKind: StickColumnView.reuseElementKind,
                withReuseIdentifier: StickColumnView.reuseIdentifier,
                for: indexPath
            ) as? StickColumnView else {
                fatalError("Cannot create new supplementary")
            }
            stickColumnView.configure(
                stickyColumnDatas: self.stickyColumnCellDatas,
                stickyColumnWidth: self.cellWidth,
                stickyCellHeight: self.cellHeight,
                stickyCellBackgroundColor: self.stickyCellBackgroundColor,
                stickyCellBorderWidth: self.cellBorderWidth,
                stickyCellBorderColor: self.cellBorderColor
            )
            return stickColumnView
        }
    }
    
    func updateDataSource() {
        guard let sectionData = sectionData else { return }
        var snapshot = NSDiffableDataSourceSnapshot<SectionData, CellData>()
        snapshot.appendSections([sectionData])
        snapshot.appendItems(sectionData.cells)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

