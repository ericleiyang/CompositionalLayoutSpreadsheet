//
//  SectionData.swift
//  
//
//  Created by Eric Yang on 5/4/21.
//

import Foundation

class SectionData: Hashable {
    let cells: [CellData]
    let identifier: String
    
    init(
        cells: [CellData],
        identifier: String = UUID().uuidString
    ) {
        self.cells = cells
        self.identifier = identifier
    }
}

extension SectionData {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: SectionData, rhs: SectionData) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
