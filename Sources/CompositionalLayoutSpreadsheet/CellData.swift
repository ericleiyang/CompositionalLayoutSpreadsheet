//
//  CellData.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import Foundation

class CellData {
    let attributedText: NSAttributedString
    let identifier: String
    
    init(
        attributedText: NSAttributedString,
        identifier: String = UUID().uuidString
    ) {
        self.attributedText = attributedText
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
