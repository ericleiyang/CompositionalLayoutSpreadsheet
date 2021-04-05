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
            parentView: view
        )
    }
}

extension ViewController {
    var stikyColumnDatas: [NSAttributedString] {
        var data: [NSAttributedString] = []
        for index in 0..<50 {
            let attributedText = NSAttributedString(
                string: "row \(index)",
                attributes: [
                    .font : UIFont.systemFont(ofSize: 16),
                    .foregroundColor: UIColor.lightGray,
                    .paragraphStyle: NSTextAlignment.center
                ]
            )
            data.append(attributedText)
        }
        return data
    }
    var rowDatas: [[NSAttributedString]] {
        var dataCollections: [[NSAttributedString]] = []

        for row in 0..<50 {
            var data: [NSAttributedString] = []
            for column in 0..<20 {
                let attributedText = NSAttributedString(
                    string: "data \(row),\(column)",
                    attributes: [
                        .font : UIFont.systemFont(ofSize: 16),
                        .foregroundColor: UIColor.lightGray,
                        .paragraphStyle: NSTextAlignment.center
                    ]
                )
                data.append(attributedText)
            }
            dataCollections.append(data)
        }
        return dataCollections
    }
}
