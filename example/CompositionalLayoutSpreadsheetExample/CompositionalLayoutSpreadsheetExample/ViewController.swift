//
//  ViewController.swift
//  CompositionalLayoutSpreadsheetExample
//
//  Created by Eric Yang on 3/4/21.
//

import CompositionalLayoutSpreadsheet
import UIKit

class ViewController: UIViewController {
    var provider: CompositionalLayoutSpreadsheet!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Compositional Spreadsheet"
        provider = CompositionalLayoutSpreadsheet()
        provider.configureHierarchy(
            stikyColumnDatas: stikyColumnDatas,
            rowDatas: rowDatas,
            parentView: view,
            cell: ValueCell.self,
            cellReuseIdentifier: ValueCell.reuseIdentifier
        )
    }
}

extension ViewController {
    var stikyColumnDatas: [String] {
        var data: [String] = []
        for index in 0..<50 {
            data.append("row \(index)")
        }
        return data
    }
    var rowDatas: [[String]] {
        var dataCollections: [[String]] = []

        for row in 0..<50 {
            var data: [String] = []
            for column in 0..<20 {
                data.append("data \(row),\(column)")
            }
            dataCollections.append(data)
        }
        return dataCollections
    }
}
