//
//  CellData.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import Foundation

class CellData {
    let title: NSAttributedString
    let identifier: String
    
    init(
        title: NSAttributedString,
        identifier: String = UUID().uuidString
    ) {
        self.title = title
        self.identifier = identifier
    }
}

extension CellData: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: CellData, rhs: CellData) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
